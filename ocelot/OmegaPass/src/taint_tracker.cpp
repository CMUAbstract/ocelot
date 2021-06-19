#include "include/taint_tracker.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AliasSetTracker.h"
#include "llvm/Analysis/CFLSteensAliasAnalysis.h"

Value* get_definition(Value* use)
{
  //Value* ret_val;
  stack<Value*> real_def;
  real_def.push(use);
  while(!real_def.empty()){
    Value* curr_use = real_def.top();
    real_def.pop();
    for(User* user : curr_use->users()){
      //errs() << "use of io call is " << *user << "\n";
      //store of result of function call
      if(isa<StoreInst>(user)){
	return dyn_cast<StoreInst>(user)->getPointerOperand();
      }
      real_def.push(user);
    }
  }
  
  return 0;
}


/*Get the value pointer from various writing instructions*/
Value* val_from_inst(Instruction* inst)
{
  Value* ret;
  if(StoreInst* si = dyn_cast<StoreInst>(inst)){
    ret = si->getPointerOperand();
  } //end store inst
  else if(isa<MemCpyInst>(inst)) {
      ret = dyn_cast<MemCpyInst>(inst)->getDest();
      
      if (GEPOperator* gep = dyn_cast<GEPOperator>(ret)) {
	if (GlobalValue* gv = dyn_cast<GlobalValue>(gep->getPointerOperand())) {
	  ret = gv;
	}
      }
  }//end memcpy
  return ret;
}

vector<Instruction*> scan_io(Function* func, vector<Function*> io_name) 
{
  vector<Instruction*> sources;
  for (BasicBlock& bb : *func) {
    for(Instruction& inst : bb) {
      if(isa<CallInst>(&inst)) {
	if(is_io(&inst, io_name)) {
	  sources.push_back(&inst);
	}
      }
    }

  }
  return sources;
}

/*taken from CMUAbstract/idempotence_bugs_pass*/
/*Search for downwards exposed stores from li, see if they are in match*/
bool precedingWrite(LoadInst* li, vector<Value*> match) {
  queue<BasicBlock*> to_visit; 
  vector<BasicBlock*> visited;
  BasicBlock* current;
  vector<Value*> possible;
  int found = 0;
  int skip = 1;
  
  to_visit.push(li->getParent());

  while(!to_visit.empty()) {
    current = to_visit.front();
    to_visit.pop();
     
    for(BasicBlock::reverse_iterator i = current->rbegin(), e = current->rend(); i!=e;++i) {
      Instruction* inst = &*i;
      //don't look at li block before li
      if((current == li->getParent())&&(skip)) {
	//errs() << "skipping" << *inst <<"\n";
	if(li==inst){
	  skip = 0;
	}
	continue;
      }
      //if(BI!=nullptr) {
      //errs() << "looking at" << *BI <<"\n";
	if (StoreInst* si = dyn_cast<StoreInst>(inst)) {
	  //errs() << "found a store" << *si <<"\n";
	  if (si->getPointerOperand() == li->getPointerOperand()) {
	    possible.push_back(si);
	    found = 1;
	    break;
	  }
	}
	//}
    }
    //we found a store in this node
    if(found) {
      found = 0;
      continue;
    }
    /*add pred. blocks to our queue*/
    for (auto PI = pred_begin(current); PI != pred_end(current); ++PI) {
      //if it's new
      if(!(find(visited.begin(), visited.end(), *PI) != visited.end())){
	visited.push_back(*PI);
	to_visit.push(*PI);
      }
    }
  }
  /*now to check if the possible preceding writes were tainted*/
  for (Value* matching : match) {
    for(Value* poss : possible) {
      // errs () << "matching: "<< *poss <<" and "<< *matching<<"\n";
      if(poss == matching) {
	//errs() << "returning true\n";
	return true;
      }
    }
  }
  //preceding writes to our load were not tainted
  return false;
}

/*This is a function to return all the control dependent stores off of a branch
Inputs: ti - the terminator instruction (branch or switch), depth - the depth of the branch nest from the call*/
vector<Value*> find_control_dep(Instruction* ti)
{
  vector<Value*> deps;
  int succ_i = 0;
  //for(BasicBlock* bb : ti->successors()) {
  while (succ_i < ti->getNumSuccessors()) {
    BasicBlock* bb = ti->getSuccessor(succ_i);
    succ_i++;
    for(Instruction& inst : *bb) {
      //if we encounter a store, add to deps
      if(isa<StoreInst>(&inst)) {
	deps.push_back(&inst);
      } //if we encounter a multi succ branch, recursive call, if we encouter a join, continue to next succ
      else if(inst.isTerminator()) {
	//double check which instruction to be looking at here.
	if(ti->getNumSuccessors() > 1) {
	  vector<Value*> intermed = find_control_dep(&inst);
	  for(Value* item : intermed) {
	    deps.push_back(item);
	  }
	} else {
	  break;
	}
      }
    }
  }

  
  return deps;
}


/*This is the transfer function for the dataflow framework*/
/* Paras: func to search, in_edge - list of tainted inter proc instructions generated from parent, 
 * out_edge - list of tainted instructions from self
 */
void find_tainted(Function* F, int old_in_edge, vector<Value*>* in_edge,
		  vector<Value*>* out_edge, vector<Function*> io_name, AliasAnalysis& aa)
{

  stack<Value*> real_def;
  //quick fix for multiple src
  
  vector<Value*> visited;
  stack<Value*> tainted;
  vector<Value*> pass_refs;

  //if this is the first time visiting, scan for annotated io points, add to in edge
  //in edge doesn't have to be empty since a prev function might have had interproc flow
  //to the current function
  if(old_in_edge == 0) {
    vector<Instruction*> sources = scan_io(F, io_name);
    for (Instruction* source : sources) {
      in_edge->push_back(source);
    }
  }

  //no local or interproc io yet, so just return
  if(in_edge->empty()) {
    //errs() << "no io to follow\n";
    //errs() << "sizes of in and out: " << in_edge->size()<<" "<< out_edge->size()<<"\n";
    return;
  }

  //if old in edge = in edge, we've already traversed everything on a previous iteration
  if (old_in_edge == in_edge->size()) {
   // errs() << "no new io to follow\n";
    //errs() << "sizes of in and out: " << in_edge->size()<<" "<< out_edge->size()<<"\n";
    return;
  }
  //othwerise we just want to consider the new information, so in_edge - old_in_edge
  unsigned int len = in_edge->size();
  while(len > old_in_edge) {
    tainted.push(in_edge->at(len-1));
    //errs() << "pushing un explored source " << *tainted.top() << "\n";
    if(isa<AllocaInst>(tainted.top())) {
      pass_refs.push_back(tainted.top());
    }
    len--;
  }
  //now, for every instruction in the tainted list, follow the def-uses
  //special cases for load, store, branch
  //not call though, since that's handled by the dataflow framework.
  while(!tainted.empty()){
    
    Value* curr_tainted = tainted.top();
    visited.push_back(curr_tainted);
    tainted.pop();

    //errs() <<"curr tainted is" <<*curr_tainted <<"\n";
    if(isa<StoreInst>(curr_tainted)){
      //only push if we haven't visited
      if(!(find(visited.begin(), visited.end(),
		dyn_cast<StoreInst>(curr_tainted)->getPointerOperand())!=visited.end())){

	tainted.push(dyn_cast<StoreInst>(curr_tainted)->getPointerOperand());
	visited.push_back(dyn_cast<StoreInst>(curr_tainted)->getPointerOperand());

	//if the pointer op is global, push to visited maybe?
        if(isa<GlobalValue>(tainted.top())){
	  visited.push_back(tainted.top());
	  out_edge->push_back(tainted.top());
	  //keeps tracking taint through array, glob and otherwise
	} else   if(GEPOperator* gep = dyn_cast<GEPOperator>(tainted.top())) {
	    if (GlobalValue* gv = dyn_cast<GlobalValue>(gep->getPointerOperand())) {
	      visited.push_back(gv);
	      tainted.push(gv);
	      out_edge->push_back(gv);
	      //not glob array, but still need to keep taint going
	    } else {
	      tainted.push(gep->getPointerOperand());
	    }
	  }
	//bitcastinst or castinst?
	if (isa<CastInst>(tainted.top())) {
	  tainted.push(dyn_cast<Instruction>(tainted.top())->getOperand(0));
	}
	//now do an extra check that we weren't storing into a pointer arg
	for (auto& arg : dyn_cast<Instruction>(curr_tainted)->getFunction()->args()) {
	  //query the aa results here
	  if(!aa.isNoAlias(dyn_cast<StoreInst>(curr_tainted)->getPointerOperand(), dyn_cast<Value>(&arg))&&isa<PointerType>(arg.getType())) {
	    out_edge->push_back(dyn_cast<Value>(&arg));
	  }
	}

        
      }
    }
    

    for (User* use : curr_tainted->users()) {
      //errs() << "use is "<< *use <<"\n";

      //otherwise check that load was actually tainted
      if((isa<AllocaInst>(curr_tainted)&&!(find(pass_refs.begin(), pass_refs.end(), curr_tainted)!=pass_refs.end()))
	 ||(isa<GlobalValue>(curr_tainted))) {
	//alloca is ok if it is from a pass by ref interproc flow
	
	if(isa<LoadInst>(use)) {
	  /* errs() << "load inst "<< *use <<"\n";
	  for(Value* item : visited) {
	    errs() << *item <<"is item \n";
	    }*/
	  if(!precedingWrite(dyn_cast<LoadInst>(use), visited)){
	    continue;
	  }
	}
  //verify this is still needed
	if(isa<StoreInst>(use)) {
	  continue;
	}
      } else 
      if(isa<BranchInst>(use)||isa<SwitchInst>(use)){
	Instruction* ti = dyn_cast<Instruction>(use);
	//with just one successor it's generally loop conditions and things
	//not branches we care about
	if(ti->getNumSuccessors() > 1 ) {
	  tainted.push(dyn_cast<Value>(use));
	  out_edge->push_back(use);
	}
	//get control dep insts
	vector<Value*> c_dep = find_control_dep(ti);
	for(Value* item : c_dep) {
	  tainted.push(item);
	}

      } else if (isa<ReturnInst>(use)){
	tainted.push(dyn_cast<Value>(use));
	out_edge->push_back(use);
      } else if (isa<CallInst>(use)) {
	
	Function* called = dyn_cast<CallInst>(use)->getCalledFunction();
	if (called==nullptr) {
	  continue;
	}
	if (called->empty()) {
	  continue;
	}
	//a memcpy inst is a call -_-
	if(isa<MemCpyInst>(use)) {
	  Value* dest = dyn_cast<MemCpyInst>(use)->getDest();
        
	  // errs() << *dest << "\n";
	  if (GlobalValue* gv = dyn_cast<GlobalValue>(dest)) {
	    visited.push_back(gv);
	    out_edge->push_back(gv);  
	  }
	   
	  if (GEPOperator* gep = dyn_cast<GEPOperator>(dest)) {
	    if (GlobalValue* gv = dyn_cast<GlobalValue>(gep->getPointerOperand())) {
	      visited.push_back(gv);  
	      out_edge->push_back(gv);  
	    } else {
	      tainted.push(gep->getPointerOperand());
	    }
	  }
	}//end memcpyinst if
	else {
	  CallInst* ci = dyn_cast<CallInst>(use);
	  unsigned int arg_num = ci->getNumArgOperands();
	  Argument* t_arg;
	  // get parameter number of our value, and then the function arg value
	  for (unsigned int i = 0; i < arg_num; i++){
	    //found the tainted parameter
	    //errs() << "searching f\n";
	    if(ci->getArgOperand(i)==curr_tainted) {
	      t_arg =(called->arg_begin() + i);
	      break;
	    }
	  }
	  for (User* arg_use : t_arg->users()) {
	    out_edge->push_back(dyn_cast<Value>(arg_use));
	  }
	}//other callinst case

	
      }
      //may not be needed
      //errs() << "pushing "<< *use <<" onto taint list\n";
	tainted.push(use);
    }
  
    
  }//end while taint not empty
}

/*This will be the meet operator for the dataflow framework, essentially it looks at the 
possible interproc flows from *the current* function and adds to the in edge of the relevant *sucessor functions*
This is flipped from the usual dataflow framework for efficiency*/
void interproc_flow(Function* func, vector<Value*>* out_dir, map<Function*, vector<Value*>*>* in_dir)
{

  //possible interproc flows are: global -> use of global, return from the current function -> caller function,
  //tainted para in call inst -> callee function, and a tainted pass by reference into a parameter -> caller function.
  if(out_dir->empty()) {
    return;
  }
  //errs() << "out dir is not empty - " << out_dir->size() <<"\n";
  for(Value* iproc : *out_dir) {
    //tainted para case
    if(iproc==NULL) {
      continue;
    }
    if(isa<StoreInst>(iproc)|isa<GEPOperator>(iproc)){

     // errs() << "para use: \n";

      Function* currf = dyn_cast<Instruction>(iproc)->getFunction();
      
      if(currf==nullptr) {
	//errs() << "no function for " << *iproc<<"\n";
	//errs() << "no function for current instruction\n";
      }

      if(currf->getName().contains("task")) {
	continue;
      }
      if(!(find(in_dir->at(currf)->begin(), in_dir->at(currf)->end(),iproc)!=in_dir->at(currf)->end())){
        in_dir->at(currf)->push_back(iproc);
      }
      //end isa callinst
    } else if(isa<ReturnInst>(iproc)){
      //cycle through callers, find def of return inst and add to caller in_edge
      for(User* caller : func->users()) {
//	errs() << "return use: " << *caller << " \n";
	if (CallInst* ci =  dyn_cast<CallInst>(caller)) {
	  Function* currf = ci->getFunction();
	  if(currf==nullptr) {
	   // errs() << "no function for " << *ci<<"\n";
	  }

	  if(currf->getName().contains("task")) {
	    continue;
	  }
	  //errs() << "adding to function " << currf->getName() << "\n";
	  if(!(find(in_dir->at(currf)->begin(), in_dir->at(currf)->end(),ci)!=in_dir->at(currf)->end())){
	    in_dir->at(currf)->push_back(ci);
	  }
	}//end ci check
      }
    }//end isa return
    else if (isa<GlobalVariable>(iproc)) {
      for(User* glob_use : iproc->users()) {
//	errs() << "global use: " << *glob_use << "\n";
	if(isa<Instruction>(glob_use)) {
	  Instruction* iuse = dyn_cast<Instruction>(glob_use); 
	  Function* currf = iuse->getFunction();
	  if(currf==nullptr) {
	    errs() << "no function for " << *iuse<<"\n";
	  }
	  if(currf->getName().contains("task")) {
	    continue;
	  }
	  if(!(find(in_dir->at(currf)->begin(), in_dir->at(currf)->end(),iuse)!=in_dir->at(currf)->end())){
	    in_dir->at(currf)->push_back(iuse);
	  }
	}
      }
    }//end isa global
    else if (isa<Argument>(iproc)) { //possibly tainted pass-by-ref parameter
     // errs() << "looking at the tainted reference argument: "<<*iproc<<"\n";
      if(func->arg_empty()) {
	continue;
      }
      //how should we link the ref arg to the caller functions?
      int index = -1;
      int i = 0;
      for (auto& arg : func->args()){
	//errs() <<"arg is "<<arg<<"\n";
	if(dyn_cast<Value>(&arg)!=iproc) {
	  i++;
	} else {
	  index = i;
	}
	 
      }
      if(index == -1){
//	errs() << "couldn't find pass by ref " << *iproc << " and " << func->getName() <<"\n";
	continue;
      }
      //errs() << "index: " << index << " function: " << callee->getName() << " val: " <<*val <<"\n";

      for (User* caller : func->users()) {
	  //for all the caller functions
	if(CallInst* ci = dyn_cast<CallInst>(caller)){
	  Value* arg = ci->getArgOperand(index);
	  //errs() << "arg_op: "<< *arg_op<<"\n";
	  //check if reference is part of an array
	  if (GEPOperator* gep = dyn_cast<GEPOperator>(arg)) {
	    arg = gep->getPointerOperand();
	  
	  }
	  //errs() << "ref use: " << *arg << "\n";
	
	  Function* currf = ci->getFunction();
	  
	  if(currf==nullptr) {
	    errs() << "no function for " << *caller<<"\n";
	  } else if(currf->getName().contains("task")) {
	    continue;
	  }
	  if(!(find(in_dir->at(currf)->begin(), in_dir->at(currf)->end(),arg)!=in_dir->at(currf)->end())){
	    in_dir->at(currf)->push_back(arg);
	  }
	}//end ci check
      }//end for
    }//end pass by ref
    else {
      try {
	//errs() << "unexpected interproc item: " << *iproc << "\n";
      } catch(int error) {
	//errs() << "unexpected interproc item\n";
      }
    }//end else if chain
  }//end iproc for loop
  //errs()<< "end interproc\n";
}


/* Function to check if an Instruction is io
*  Can be compiled a few different ways to make it more customizable
*  Is there anything more universal to use as default case?
*/
bool is_io(Instruction* potential, vector<Function*> io_name)
{
  if(Function* func = dyn_cast<CallInst>(potential)->getCalledFunction()) {
    if(find(io_name.begin(), io_name.end(),func)!=io_name.end()) {
      return true;
    }
  }
  //else, no io
  return false;
  
}
  
