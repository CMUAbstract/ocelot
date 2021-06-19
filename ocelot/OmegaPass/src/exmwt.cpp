#include "include/exmwt.h"
#include "include/dataflow.h"
#include "include/taint_tracker.h"

#define TAINTED 0

int exmwt::filter_global(Value* glob, Function* func)
{
  for (BasicBlock& bb : *func) {
    for (Instruction& inst : bb) {
      if (StoreInst* si = dyn_cast<StoreInst>(&inst)) {
	//we do a safe store into the glob before any branches -- not tainted
	if(si->getPointerOperand()==glob) {
	  return 0;
	}
      }//end si check
      if (inst.isTerminator()) {
	if(inst.getNumSuccessors() > 1 ) {
	  return 1;
	}
      }
    }
  }
  return 1;
}

/*Helper functions for getting output*/
unsigned int get_lnum(Instruction* inst) {
  unsigned int num = 0;
  Metadata* md = inst->getMetadata("dbg");
  if(md!=NULL){
    DILocation* dil = dyn_cast<DILocation>(md);
    unsigned Line = dil->getLine();
    num = Line;
   }

  return num;
}

string get_filename(Instruction* inst) {
  StringRef dir;
  StringRef f;
  string name = "";
  Metadata* md = inst->getMetadata("dbg");
  if(md!=NULL){
    DILocation* dil = dyn_cast<DILocation>(md);
    dir = dil->getDirectory();
    f = dil->getFilename();
    name = (dir + "/"+ f).str();
  } 
  return name;
}

//adapted from stack overflow
string getLine(ifstream& file, unsigned int num){
  string line;
  file.seekg(ios::beg);
  for(unsigned int i=0; i < (num - 1); ++i){
    file.ignore(numeric_limits<streamsize>::max(),'\n');
  }
  getline(file, line);
  
  return line;
}

Value* exmwt::get_definition(Value* use)
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
Value* exmwt::val_from_inst(Instruction* inst)
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

void print_set(set<Value*> v) {
  if(v.empty()) {
    return;
  }
  errs () << "printing set: \n";
  for(Value* item : v) {
    errs() << *item <<"\n";
  }
}


/*Check if a store ultimately refers to a nv location or not
Make modular in case the rust annotation mechanism changes.
Side effect: pushes nv or aliases to the nv_in_region structure*/
bool exmwt::is_nonvolatile(Value* p_op, Instruction* reg_start, Function* curr_f)
{
  //errs() << "checking pointer " << *p_op << "\n"; 
  AliasAnalysis &loc_aa = pass->getAnalysis<AAResultsWrapperPass>(*curr_f).getAAResults();
  //unwrap from bit_cast if necc.
  Value* loc_op = p_op->stripPointerCasts();
  if(CallInst* ci = dyn_cast<CallInst>(loc_op)) {
    loc_op = ci->getOperand(0)->stripPointerCasts();
    //errs() << "unwrapping " << *loc_op << "\n";
  }
  //   errs() << "unwrapped " << *loc_op << "\n";
  //Value* p_op = si->getPointerOperand();
  //change to handle non-option type nv vars
  if (GlobalObject* go = dyn_cast<GlobalObject>(loc_op)) {
    if(go->getSection().contains(".nv_vars")) {
      nv_in_region[reg_start].push_back(p_op);
      nv_in_region[reg_start].push_back(go);
      backing_statics[reg_start].push_back(cast<GlobalVariable>(go));
      // errs() << "pushed backing static " << *go << " to region " << *reg_start <<"\n";
      gv_aliases[cast<GlobalVariable>(go)].push_back(p_op);
      gv_aliases[cast<GlobalVariable>(go)].push_back(loc_op);
    
      //        errs() << "pushed alias " << *loc_op << " to backing static " << *go <<"\n";
      return true;
    }
  }

  if (GetElementPtrInst* gepi = dyn_cast<GetElementPtrInst>(loc_op)) {
    if (GlobalObject* go = dyn_cast<GlobalObject>(gepi->getPointerOperand())) {
      if(go->getSection().contains(".nv_vars")) {
	nv_in_region[reg_start].push_back(p_op);
	nv_in_region[reg_start].push_back(go);
	backing_statics[reg_start].push_back(cast<GlobalVariable>(go));
	// errs() << "pushed backing static " << *go << " to region " << *reg_start <<"\n";
	gv_aliases[cast<GlobalVariable>(go)].push_back(p_op);
	gv_aliases[cast<GlobalVariable>(go)].push_back(loc_op);
	gv_aliases[cast<GlobalVariable>(go)].push_back(gepi);
	//  errs() << "pushed alias" << *gepi << " to backing static " << *go <<"\n";
	return true;
      }
    }
    loc_op = gepi->getPointerOperand();
  }
	    

  //option type nv macro, leave here for legacy
  if(LoadInst* li = dyn_cast<LoadInst>(loc_op)) {
    Value* li_p_op = li->getPointerOperand();
      for(User* user : li_p_op->users()) {
	if(StoreInst* si_2 = dyn_cast<StoreInst>(user)) {
	  //not pointer op, but rather value
	  if(CallInst* ci_2 = dyn_cast<CallInst>(si_2->getValueOperand())) {
	    Value* loc_2 = ci_2->getOperand(0)->stripPointerCasts();
	    //	    errs() << "unwrapping nested" << *loc_2 << "\n";
	    //finally there?
	    if (GlobalObject* go = dyn_cast<GlobalObject>(loc_2)) {
	      if(go->getSection().contains(".nv_vars")) {
		nv_in_region[reg_start].push_back(p_op);
		nv_in_region[reg_start].push_back(go);
		backing_statics[reg_start].push_back(cast<GlobalVariable>(go));
		// errs() << "pushed backing static " << *go << " to region " << *reg_start <<"\n";
		gv_aliases[cast<GlobalVariable>(go)].push_back(p_op);
		gv_aliases[cast<GlobalVariable>(go)].push_back(loc_op);
		gv_aliases[cast<GlobalVariable>(go)].push_back(loc_2);

		gv_aliases[cast<GlobalVariable>(go)].push_back(li_p_op);
		//gv_aliases[cast<GlobalVariable>(go)].push_back(loc_2);
	
		//  errs() << "pushed alias " << *p_op << " to backing static " << *go <<"\n";
		return true;
	      }
	    }
	    
	  }//2nd callinst
	  
	}//store inst
      }//for loop
  }
  
  // for (GlobalVariable* gv : backing_statics[reg_start]) {
  for (auto map : gv_aliases) {
    for(Value* nv :  map.second ){
      //for (GlobalVariable& gv : si->getModule()->globals())
      //errs() << "value " << *nv << "in region " << *reg_start << "\n";
      //AliasResult result = loc_aa.alias(p_op, nv);
      if (loc_op == nv) {
	//errs() << *loc_op << " may alias with nv " << *nv  << " on global " << *map.first<<" \n";
        nv_in_region[reg_start].push_back(p_op);
        //bookkeeping structs
        gv_aliases[map.first].push_back(p_op);
	gv_aliases[map.first].push_back(loc_op);
	//errs() << "pushed new alias " << *p_op << " to backing static " << *gv <<"\n";
        return true;
      }
    }
  }

  return false;
}

GlobalVariable* exmwt::get_backing_static(Value* p_op, Instruction* reg_start) 
{

  //check which gv the pointer is aliasing
 // errs() << "searching for backing static of " << *p_op << " in region " << *reg_start <<"\n";
  //for(GlobalVariable* gv : backing_statics[reg_start]) {
  for(auto gvmap : gv_aliases) {
    for (Value* possible : gvmap.second) {
   //   errs() << "comparing" << *p_op << " and " << *possible <<"\n";
      if (possible==p_op) {
     //   errs() << "found " << *gv << "\n";
        return gvmap.first;
      }
    } 
  }
  errs() << "FATAL ERROR: no backing static for an aliasing pointer\n";
  return NULL;
}


/*This function calculates the exclusive may write set of a single function.
It does this by calculating the inclusive may-write set and subtracting the must-write 
set*/
struct xm_pair exmwt::find_exclusive(BasicBlock* start, map<Function*, vector<Value*>*> tainted, vector<BasicBlock*> visit, int reach, Instruction* reg_start) 
{
 struct xm_pair exmays;

 set<Value*> mustwt;
 //vector<Value*> exwt;

 set<Value*> mustwt_tail;
 set<Value*> exwt_tail;
 
 queue<pair<BasicBlock*, int>> explore;
 vector<pair<BasicBlock*, int>> visitedQueue;
 //vector<BasicBlock*> visit;
 //if not branch, we should have only one successor?
 explore.push(make_pair(start,reach));
 Instruction* curr_reg_start = reg_start;
 while(!explore.empty()) {
   // errs() << "exploring\n";
   pair<BasicBlock*, int> curr_p = explore.front();
   explore.pop();
   if (find(visitedQueue.begin(), visitedQueue.end(), curr_p)!=visitedQueue.end()) {
     continue;
   }
   visitedQueue.push_back(curr_p);
   BasicBlock* currb = curr_p.first;
   int reaching_cp = curr_p.second;
   //errs() << "Reaching CP: " << reaching_cp << "\n";
   
   visit.push_back(currb);
   for(Instruction& inst : *currb) {

     //for building nv var map, regardless of atomic regions or taintedness
     if (StoreInst* si = dyn_cast<StoreInst>(&inst)) {
       	//for building nv var map
       	//for building nv var map
       if (is_nonvolatile(si->getValueOperand(), curr_reg_start, si->getFunction())) {
	     
	 GlobalVariable* gv = get_backing_static(si->getValueOperand(), curr_reg_start);
	 gv_aliases[gv].push_back(si->getValueOperand());
	 gv_aliases[gv].push_back(si->getPointerOperand());
	 //errs() << "pushed back nv var aliases" << *si->getValueOperand()<< " and " << *si->getPointerOperand()<<"\n";
       }
	 

	 //otherwise, just check the pointer
	 if (is_nonvolatile(si->getPointerOperand(), curr_reg_start, si->getFunction())) {
	   GlobalVariable* gv = get_backing_static(si->getPointerOperand(), curr_reg_start);
	   gv_aliases[gv].push_back(si->getPointerOperand());
	 }


     }

     if(isa<StoreInst>(&inst)&&(reaching_cp > 0)) {
        StoreInst* si = dyn_cast<StoreInst>(&inst);
	if (is_nonvolatile(si->getPointerOperand(), curr_reg_start, si->getFunction())) {
	  GlobalVariable* gv = get_backing_static(si->getPointerOperand(), curr_reg_start);
    
	  if(gv!=NULL) {
	    //errs() << "backing static is: " << *gv <<"\n";
	    mustwt.insert(gv);
	  }
	}
	//    errs () << *si<<" inserted\n";
      }
      //todo: call insts
      else if(CallInst* ci = dyn_cast<CallInst>(&inst)) {
	//errs() << "looking at callinst\n";
        Function* cf = ci->getCalledFunction();

	
        //make sure function ptr isn't null (gotos, weird macro stuff) and that
	//func isn't empty (e.g., external lib)
	if(cf!=nullptr) {
	  //if this is a task, then don't recurse!
	  if(cf->getName().contains("task")){
	    continue;
	  } else if (cf->getName().contains("atomic_start")) {
	    //this check would be to handle nested atomic regions -- only set this variables on outermost
	    if(reaching_cp == 0) {
	     // errs () << "clearing lists\n";
	      curr_reg_start = ci;
	      //gather fresh sets
	      mustwt.clear();
	      mustwt_tail.clear();
	      exwt_tail.clear();
	    }
	    //should be count of nested region now
	    reaching_cp++;
	  } else if (cf->getName().contains("atomic_end")) {

	    //only do this if leaving the outermost nested.
	    if (reaching_cp == 1) {
	      //now do the final combo of head and tail sets.
	      //todo: verify where to set diff
	     // errs() << "ending section\n";
	      union_of(mustwt_tail, &mustwt);
      
	      vector<Value*> exwt(exwt_tail.size());
	      set_difference(exwt_tail.begin(), exwt_tail.end(), mustwt.begin(), mustwt.end(), exwt.begin());
	     // errs() << "finish set ops\n";
	      exmays.mset = mustwt;
	      for(Value* item : exwt) {
		if (item==NULL) {
		  continue;
		}
		//errs() << "exwt: " << *item << "\n";
		exmays.exset.insert(item);
          
		if (!(find(RIOinRegion[curr_reg_start].begin(), RIOinRegion[curr_reg_start].end(), item)!=RIOinRegion[curr_reg_start].end())) {
		  RIOinRegion[curr_reg_start].push_back(item);
		}
	      }
	      //curr_reg_start = NULL;
	    }

	    //TODO: need counter to track nesting of automic
	    reaching_cp--;
	    
	  }
	  if(!cf->empty()){
	    //errs() << "calling internal\n"; 
	    BasicBlock* cb = &(cf->getEntryBlock());
	    /*check if a gv or alias is passed in as an arg*/
	    int num_op = ci->getNumArgOperands();
	    //not performant!!d
	    for(int i = 0; i < num_op; i++) {
	      Value* p_op = ci->getArgOperand(i);
	      if (LoadInst* li = dyn_cast<LoadInst>(p_op)) {
		p_op = li->getPointerOperand();
	      }
	       //errs() <<"checking arg " << *p_op << "\n";
	     
	      if(is_nonvolatile(p_op, curr_reg_start, cf)){
		GlobalVariable* gv = get_backing_static(p_op, curr_reg_start);
		//no idea why getArg isn't working -- possibly deprecated?
		//errs() << "INTERPROC: got backing " << *gv<< "for arg " << *p_op<< "\n";
		int j = 0;
		for (auto& arg : cf->args()) {
		  //errs() << "INTERPROC: pushing arg" << arg<< "\n";
		  if (j == i) {
		    // errs() << "INTERPROC: pushing arg" << arg<< "\n";
		    gv_aliases[gv].push_back(&arg);
		    gv_aliases[gv].push_back(p_op);
		    for (Value* argUse : arg.users()) {
		      gv_aliases[gv].push_back(argUse);
		    }
		    break;
		  }
		  j++;
		}
		
	      }
	    }
	    
	    struct xm_pair intermed_res = find_exclusive(cb, tainted, visit, reaching_cp, curr_reg_start);
	    
	    for(Value* item : intermed_res.exset) {
	      exwt_tail.insert(item);
	     // errs() << "inserting exmwt tail " << *item<<"\n";
	    }

	    for(Value* item : intermed_res.mset) {
	      mustwt.insert(item);
	     // errs() << "inserting mustwt tail " << *item<<"\n";
	    }
	  }//end empty func check
	}//end nullptr
      }
      else if(inst.isTerminator()) {
        unsigned int num_succ = inst.getNumSuccessors();
	//errs () << *ti<<" is examined branch\n";

	//Quick Test: For loop switch inst, succ 0 isn't a real successor
	
	#if TAINTED
	if(tainted[currb->getParent()]->size()==0) {
	  continue;
	}
	#endif
        //if multiple successor (branch or switch) and it is tainted
        if((num_succ > 1)&&(reaching_cp > 0)&&(find(tainted[currb->getParent()]->begin(),tainted[currb->getParent()]->end(),&inst)!=
			    tainted[currb->getParent()]->end())) {
          //errs () << *ti<<" is branch\n";
          //if it's a branch, we recursive call find_exclusive on each succ
          for (unsigned int i = 0; i < num_succ; i++) {
	    //don't recurse on things we've already visited
	    if(isa<SwitchInst>(&inst)&&i==0){
	      continue;
	    }
	    if(find(visit.begin(), visit.end(), inst.getSuccessor(i))!=visit.end()) {
	      continue;
	    }
            struct xm_pair part = find_exclusive(inst.getSuccessor(i), tainted, visit, reaching_cp, curr_reg_start);
            //accumulate the partial res by intersecting must sets and unioning ex set with both x and m
            if(!mustwt_tail.empty()) {
              intersect(part.mset, &mustwt_tail);
              //errs() << "intersecting mustwt tail\n";
            } else {
              for(Value* item : part.mset) {
                mustwt_tail.insert(item);
                //errs() << "inserting mustwt tail " << *item<<"\n";
              }
            }
            //print_set(mustwt_tail);
            vector<Value*> temp(part.mset.size()+part.exset.size());
            //union x and m of successor
            set_union(part.mset.begin(), part.mset.end(), part.exset.begin(),part.exset.end(), temp.begin());
            //union with rest
            union_of(temp, &exwt_tail);
            //print_set(exwt_tail);
          }
        } else if((num_succ > 1)
		  &&(!(find(tainted[currb->getParent()]->begin(),tainted[currb->getParent()]->end(),&inst)!=
		       tainted[currb->getParent()]->end()))) {
	  //multiple blocks, but not tainted
	  for(unsigned int i =0; i < num_succ; i++) {

	    if(isa<SwitchInst>(&inst)&&i==0){
	      continue;
	    }
	    if(find(visit.begin(), visit.end(), inst.getSuccessor(i))!=visit.end()) {
	      continue;
	    }
	    explore.push(make_pair(inst.getSuccessor(i), reaching_cp));
	  }
	}else if (num_succ > 0){
	  //don't recurse on things we've already visited
	  if(find(visit.begin(), visit.end(), inst.getSuccessor(0))!=visit.end()) {
	    continue;
	  }
          explore.push(make_pair(inst.getSuccessor(0),reaching_cp));
        }
        
      }//end if/else chain
   }//end inst for loop
 }//end queue

 //now do the final combo of head and tail sets.
 //todo: verify where to set diff
 //errs() << "finish loops\n";
 
 union_of(mustwt_tail, &mustwt);
 //errs() << "print ex tail\n";
 // print_set(exwt_tail);
 //errs() << "print mustwt\n";
 //print_set(mustwt);
 vector<Value*> exwt(exwt_tail.size());
 set_difference(exwt_tail.begin(), exwt_tail.end(), mustwt.begin(), mustwt.end(), exwt.begin());
 //errs() << "finish set ops\n";
 exmays.mset = mustwt;
 if(curr_reg_start!=NULL) {
 for(Value* item : exwt) {
   //errs() << "exwt: " << *item << "\n";
   exmays.exset.insert(item);
    if (!(find(RIOinRegion[curr_reg_start].begin(), RIOinRegion[curr_reg_start].end(), item)!=RIOinRegion[curr_reg_start].end())) {
             RIOinRegion[curr_reg_start].push_back(item);
    }
 }
 }
 
 return exmays;
}

void exmwt::union_of(vector<Value*> to_combine, set<Value*>* original)
{
  if(to_combine.empty()) {
    return;
  }
  for (Value* item : to_combine) {
    original->insert(item);
  }
}

void exmwt::union_of(set<Value*> to_combine, set<Value*>* original)
{
  if(to_combine.empty()) {
    return;
  }
  for (Value* item : to_combine) {
    original->insert(item);
  }
}

void exmwt::intersect(set<Value*> to_intersect, set<Value*>* original)
{
  set<Value*> temp;
  for(Value* item : *original) {
    temp.insert(item);
  }
  for (Value* item : temp) { 
    if(!(to_intersect.find(item)!=to_intersect.end())) {
      errs() << "erasing " << *item << "\n";
      original->erase(item);
    }
  }
}

/*Wrapper function to call find_exclusive on each function of the module*/
map<Instruction*, vector<Value*>> exmwt::search_functions(Module &M,AliasAnalysis &aa)
{
  map<Function*, vector<Value*>> ex_map;
  vector<Function*> io_name;
  //get the io information from the prog globals
   for(GlobalVariable& gv : M.globals()) {
    //errs() << "glob name is " << gv.getName() <<"\n";
    if(gv.getName().contains("IO_NAME"))  {
      if( Function* fp = dyn_cast<Function>(gv.getInitializer()->getOperand(0)->stripPointerCasts())) {
	io_name.push_back(fp);
	//errs() << "annotation is " << *item << "\n";
      } else {
	errs() << "ERROR: could not unwrap function pointer from annotation\n";
      }
    }
   } 
  

 // errs() << "starting run\n";
  map<Function*, vector<Value*>*> in, out;

  //init empty entries for the map
  for(Function& F : M) {
    vector<Value*>* new_vect = new vector<Value*>();
    vector<Value*>* new_vector = new vector<Value*>();
    in[&F] = new_vect;
    out[&F] = new_vector;
  }
#if TAINTED
  map<Function*, vector<Value*>*> tainted = iterate(&M, find_tainted, interproc_flow, &in, &out, io_name, aa);
#endif
  for (Function& F : M){
    if(F.empty()) {
      continue;
    }
   // errs() << F.getName()<<"\n";
   // errs() << "tainted list size: " << out[&F]->size() << "\n";
    for(Value* item : *out[&F]) {
      errs() << *item <<"\n";
    }

    vector<BasicBlock*> visit;
    struct xm_pair list = find_exclusive(&(F.getEntryBlock()), out, visit, 0, NULL);
   // errs() << "finish find exclusive\n";
    vector<Value*> res(list.exset.begin(), list.exset.end());
    //errs() << "make list\n";
    ex_map[&F] = res;
    //errs() << "got res\n";
  }

  //errs() << "finished res\n";
  return RIOinRegion;
}


bool exmwt::compare_values(Value* wrtset, Value* filtered) {
  bool found = 0;
  if(Instruction* ival = dyn_cast<Instruction>(wrtset)) {
    if(StoreInst* si = dyn_cast<StoreInst>(ival)){
      if(filtered==si->getPointerOperand()) {
	found = 1;
      }  
    } //end store inst
    else if(isa<MemCpyInst>(ival)) {
      Value* dest = dyn_cast<MemCpyInst>(ival)->getDest();
      // errs() << *dest << "\n";
      if(filtered == dest) {
	found = 1;
      }
      if (GEPOperator* gep = dyn_cast<GEPOperator>(dest)) {
	if (GlobalValue* gv = dyn_cast<GlobalValue>(gep->getPointerOperand())) {
	  if(filtered == gv) {
	    found = 1;
	  }
	}
      }
    }//end memcpy
  }
  return found;
}
  


