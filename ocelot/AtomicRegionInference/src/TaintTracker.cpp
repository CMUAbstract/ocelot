#include "include/TaintTracker.h"


/*Main DataFlow function to construct map of store insts to vars they depend on*/
inst_insts_map buildInputs(Module* m) 
{
  inst_vec inputs = findInputInsts(m);
  inst_insts_map taintedDecl;
  inst_vec promoted_inputs;

  for (Instruction* iOp : inputs) {
    #if DEBUG
    errs() << "Starting input: " << *iOp <<"\n";
    #endif
    //don't forget to add self to map
    taintedDecl[iOp].insert(iOp);
    queue<Value*> toExplore;
    toExplore.push(iOp);

    //iterate until no more interproc flows found
    while(!toExplore.empty()) {
      
      Value* currVal = toExplore.front();
      if (currVal == NULL) {
        continue;
      }

      val_vec interProcFlows;
      toExplore.pop();
      if (currVal == iOp) {
        interProcFlows = traverseLocal(currVal, iOp, &taintedDecl, nullptr);
        for (Value* vipf : interProcFlows) {
          if(Instruction* iipf = dyn_cast<Instruction>(vipf)) {
            if (CallInst* anno_check = dyn_cast<CallInst>(iipf)){
                    //we delete these later... creates problems
                    if (anno_check->getName().contains("Fresh") || 
                    anno_check->getName().contains("Consistent") ) {
                      continue;
                    }
                  }
            taintedDecl[iipf].insert(iOp);
          }
        }
      } else if (isa<CallInst>(currVal)) {
        //note it will not be iop, even though iop is a call
        //this case handles both returns and pbref
        
        promoted_inputs.push_back(dyn_cast<CallInst>(currVal));
        Value* next = toExplore.front();
        toExplore.pop();
        //if the next is a return, this was a return flow
        //otherwise, if it's an arg, this was pbref
        if (isa<ReturnInst>(next)) {
         interProcFlows =  traverseLocal(currVal, dyn_cast<CallInst>(currVal), &taintedDecl, nullptr);
          for (Value* vipf : interProcFlows) {
            if(Instruction* iipf = dyn_cast<Instruction>(vipf)) {

              //don't add self 
              if (currVal == vipf) {
                continue;
              }
              if (CallInst* anno_check = dyn_cast<CallInst>(iipf)){
                    //we delete these later... creates problems
                    if (anno_check->getName().contains("Fresh") || 
                    anno_check->getName().contains("Consistent") ) {
                      continue;
                    }
                  }
              taintedDecl[iipf].insert(dyn_cast<CallInst>(currVal));
            }
          }          
        } else if (isa<Argument>(next)) {
          //grab the para corresponding to the argument
          int index = -1;
          int i = 0;
          CallInst* ci = dyn_cast<CallInst>(currVal);
          

          if (ci->getCalledFunction() == NULL) {
            continue;
          }
          if (ci->getCalledFunction()->empty()) {
            continue;
          }

          #if DEBUG
            errs() << "exploring function " <<  ci->getCalledFunction()->getName() << "\n";
          #endif
         
          for (auto& arg : ci->getCalledFunction()->args()){
        	//errs() <<"arg is "<<arg<<"\n";
          	if(dyn_cast<Value>(&arg)!=next) {
          	  i++;
          	} else {
	            index = i;
          	}
	 
          }
          if(index == -1){
            #if DEBUG
          	errs() << "couldn't find pass by ref " << *next << "\n";
            #endif
          	continue;
          }
        
	        Value* tArg = ci->getArgOperand(index);
	        //errs() << "arg_op: "<< *arg_op<<"\n";
	        //check if reference is part of an array
	        if (GEPOperator* gep = dyn_cast<GEPOperator>(tArg)) {
	          tArg = gep->getPointerOperand();
	        } 
          //if bitcast inst,
          else if (BitCastInst* bci = dyn_cast<BitCastInst>(tArg)){
            tArg = bci->getOperand(0);
          }
          //need to actually find the first use *after* the callInst
          Instruction* fstUse = ptrAfterCall(tArg,ci);
          if (fstUse!=nullptr && fstUse!=tArg) {
            #if DEBUG
            errs() << "First use after call: " << *fstUse << "\n";
            #endif
            //if the first use is itself a callinst, then treat as a tainted para case, 
            val_vec visited_fstuse;
            visited_fstuse.push_back(ci);
      
            while (CallInst* ci_fstuse = dyn_cast<CallInst>(fstUse) ) {
              //already visited, as in loop
              if (find(visited_fstuse.begin(),visited_fstuse.end(), ci_fstuse)
              !=visited_fstuse.end()) {
                //no non-call uses
                fstUse = nullptr;
                break;
              }
              if (CallInst* anno_check = dyn_cast<CallInst>(ci_fstuse)){
                    //we delete these later... creates problems
                    if (anno_check->getName().contains("Fresh") || 
                    anno_check->getName().contains("Consistent") ) {
                      continue;
                    }
                  }
              visited_fstuse.push_back(ci_fstuse);

              unsigned int arg_num = ci_fstuse->getNumArgOperands();
          
              // Find the index of the tainted argument
              for (unsigned int i = 0; i < arg_num; i++){
                #if DEBUG
                  errs() << "DEBUG: comparing "<< *tArg <<" and " << *(ci_fstuse->getArgOperand(i))<<"\n";
                #endif
                if(ci_fstuse->getArgOperand(i)==tArg) {
                  #if DEBUG
                   // errs() << "DEBUG: pushing arg of "<< calledFunc->getName() <<"\n";
                  #endif
                  interProcFlows.push_back((ci_fstuse->getCalledFunction()->arg_begin() + i));
                  //MUST also push back the call inst.
                  interProcFlows.push_back(ci_fstuse);
                  //and the srcOp
                  interProcFlows.push_back(ci);
                  
                  break;
                }
              }
              //find next local use 
              //promoted_inputs.push_back(ci);
              taintedDecl[ci_fstuse].insert(ci);
              fstUse  = ptrAfterCall(tArg,ci_fstuse);

              if (fstUse == nullptr) {
                break;
              }
            } 
            //re nullptr check
            if (fstUse!=nullptr) {  
              interProcFlows =  traverseLocal(fstUse, dyn_cast<CallInst>(currVal), &taintedDecl, nullptr);
              for (Value* vipf : interProcFlows) {
                if(Instruction* iipf = dyn_cast<Instruction>(vipf)) {
                  if (CallInst* anno_check = dyn_cast<CallInst>(iipf)){
                    //we delete these later... creates problems
                    if (anno_check->getName().contains("Fresh") || 
                    anno_check->getName().contains("Consistent") ) {
                      continue;
                    }
                  }
                  taintedDecl[iipf].insert(dyn_cast<CallInst>(currVal));
                }
              }
            }
          }  
        }
      } else if (isa<Argument>(currVal)) {
        #if DEBUG
          	errs() << "exploring tainted arg " << *currVal << "\n";
          #endif
        Instruction* caller = dyn_cast<CallInst>(toExplore.front());
        
        //promoted_inputs.push_back(caller);
        toExplore.pop();
        Instruction* innerSrcOp = dyn_cast<Instruction>(toExplore.front());
        toExplore.pop();
        interProcFlows = traverseLocal(currVal, innerSrcOp, &taintedDecl, caller);
             
              for (Value* vipf : interProcFlows) {
                if(Instruction* iipf = dyn_cast<Instruction>(vipf)) {
                  if (CallInst* anno_check = dyn_cast<CallInst>(iipf)){
                    //we delete these later... creates problems
                    if (anno_check->getName().contains("Fresh") || 
                    anno_check->getName().contains("Consistent") ) {
                      continue;
                    }
                  }
                  taintedDecl[iipf].insert(innerSrcOp);
                }
              }
      }//end elsif chain
      #if DEBUG
        errs() << "Finished iteration\n";
      #endif
      for (Value* item : interProcFlows) {
        if(item != NULL) {
          //errs() <<"pushing item " << *item <<"\n";
          toExplore.push(item);
        } else {
          errs() << "ERROR: encountered null interproc item\n";
        }
      }
    }//end while queue not empty
  }//end for all iOp
  
  return taintedDecl;
}

val_vec traverseLocal(Value* tainted, Instruction* srcOp, inst_insts_map* iInfo, Instruction* caller)
{
  val_vec interProcSinks;
  queue<Value*> localDeps;

  localDeps.push(tainted);
  while(!localDeps.empty()) {
    Value* currVal = localDeps.front();
    localDeps.pop();
     val_vec customUsers;
    if (StoreInst* si = dyn_cast<StoreInst>(currVal)) {    
      //add the pointer to deps, as stores have no uses
      //Add info on the store to the map
      if(iInfo->find(si)!=iInfo->end()) {
        if (find(iInfo->at(si).begin(), iInfo->at(si).end(), srcOp)!=iInfo->at(si).end()) {
          continue;
        } else {
          iInfo->at(si).insert(srcOp);
        }
      } else {
        set<Instruction*> seti;
        seti.insert(srcOp);
        iInfo->emplace(si, seti);
      }
      #if DEBUG
        errs() << " adding to map " << *srcOp << " for " << *si << "\n";
      #endif
      //See if it is (or aliases?) one of the function arguments
      for (Argument& arg : si->getFunction()->args()) {
        Value* to_comp = si->getPointerOperand()->stripPointerCasts();
        #if DEBUG
        errs() << " PBRef comp: " << *to_comp << " and " << arg << "\n";
        #endif
        if (to_comp== &arg) {
          //if taint came from inside any callsite is potentially tainted
          if (caller == nullptr) {
            for(Value* calls : si->getFunction()->users()) {
              interProcSinks.push_back(calls);
              interProcSinks.push_back(dyn_cast<Value>(&arg));
              if (Instruction* key = dyn_cast<Instruction>(calls)) {
               //check to make sure not already visited
             //   iInfo->at(key).insert(srcOp);
                
              }
            }
          } else {
          //otherwise, just the caller's
            interProcSinks.push_back(caller);
            interProcSinks.push_back(dyn_cast<Value>(&arg));
            if (Instruction* key = dyn_cast<Instruction>(caller)) {


              //check to make sure not already visited
      //        iInfo->at(key).insert(srcOp);
              
            }
          }
        }
      }
      //construct "users" of the store
      #if DEBUG
        errs() << "DEBUG: Store users\n";
      #endif
      //add in loads that are reachable from the tainted store.
      Value* ptr = si->getPointerOperand();
      //if bci, get the operand, as that's the useful ptr
      if (BitCastInst* bciptr = dyn_cast<BitCastInst>(ptr) ){
        ptr = bciptr->getOperand(0);
      }
      for(Value* use : ptr->users()){
        if (Instruction* useOfStore = dyn_cast<Instruction>(use)) {
          #if DEBUG
            errs() << "DEBUG: checking use " << *useOfStore << "\n";
          #endif
          if (storePrecedesUse(useOfStore, si)) {
            customUsers.push_back(useOfStore);
          }
        }
      }
      //update currVal to be the pointer
      currVal = si->getPointerOperand();

      //if it's a gepi, see if there are others that occur afterwards 
      if (isa<GetElementPtrInst>(si->getPointerOperand())) {
        inst_vec matching = couldMatchGEPI(dyn_cast<GetElementPtrInst>(si->getPointerOperand()));
        for (Instruction* item : matching) {
          localDeps.push(item);
        }
        //check pbref, need to compare op of the gepi, not gepi itself
         for (Argument& arg : si->getFunction()->args()) {
          #if DEBUG
          errs() << " PBRef comp: " << *dyn_cast<Instruction>(currVal)->getOperand(0) << " and " << arg << "\n";
          #endif
          if (dyn_cast<Instruction>(currVal)->getOperand(0) == &arg) {
            //if taint came from inside any callsite is potentially tainted
            if (caller == nullptr) {
              for(Value* calls : si->getFunction()->users()) {
                interProcSinks.push_back(calls);
                interProcSinks.push_back(dyn_cast<Value>(&arg));
                if (Instruction* key = dyn_cast<Instruction>(calls)) {

          //         iInfo->at(key).insert(srcOp);
                }
              }
            } else {
            //otherwise, just the caller's
              interProcSinks.push_back(caller);
              interProcSinks.push_back(dyn_cast<Value>(&arg));
              if (Instruction* key = dyn_cast<Instruction>(caller)) {

            //  iInfo->at(key).insert(srcOp);
              }
            }
          }
         }
      }
        
    } else {
      //if not a store, do normal users of currval
      customUsers.insert(customUsers.end(), currVal->user_begin(), currVal->user_end());
    }

    
   
      
    for (Value* use : customUsers) { 

      //check that the use of a tainted pointer is really tainted
      
      //this is checking if the use is a tainted store 
      
      if (ReturnInst* ri = dyn_cast<ReturnInst>(use)) {
        #if DEBUG
          errs() << "DEBUG: in return case\n";
        #endif
        if (caller == nullptr) {
          for(Value* calls : ri->getFunction()->users()) {
            if(CallInst* ci = dyn_cast<CallInst>(calls)) {
              interProcSinks.push_back(calls);
              //extra for bookkeeping
              interProcSinks.push_back(use);
            }
          }
        } else {
        //otherwise, just the caller's
          interProcSinks.push_back(caller);
          //extra for bookkeeping
          interProcSinks.push_back(use);
        }

      } else if (isa<CallInst>(use)) {
        #if DEBUG
          errs() << "DEBUG: in call case\n";
        #endif
        //Add the right argument to the list
        CallInst* ci = dyn_cast<CallInst>(use);
        Function* calledFunc = ci ->getCalledFunction();
        if (calledFunc == NULL || calledFunc->empty()) {
          //special case for llvm.memcpy
          //See if it is (or aliases?) one of the function arguments
          if (calledFunc!=NULL && calledFunc->hasName() &&
            calledFunc->getName().contains("llvm.memcpy")) {
            //errs() << "DEBUG: memcpy " << *ci << "\n";  
            Value* src = ci->getOperand(1)->stripPointerCasts();
            Value* dest = ci->getOperand(0);
           // errs() << "DEBUG: with dest " << *dest << "\n";  
            if (BitCastInst* bci = dyn_cast<BitCastInst>(dest)) {
              dest = bci->getOperand(0);
            } 
            if (GetElementPtrInst* gepi = dyn_cast<GetElementPtrInst>(dest)) {
              dest = gepi->getOperand(0);
          //    errs() << "DEBUG: and gepi dest " << *dest << "\n"; 
            }
            bool found = false;
            for (Argument& arg : ci->getFunction()->args()) {
              //Value* to_comp = 
              #if DEBUG
              errs() << " PBRef comp: " << *dest << " and " << arg << "\n";
              #endif
              if (dest== &arg) {
                found = true;
                //if taint came from inside any callsite is potentially tainted
                if (caller == nullptr) {
                  for(Value* calls : ci->getFunction()->users()) {
                    interProcSinks.push_back(calls);
                    interProcSinks.push_back(dyn_cast<Value>(&arg));
                    if (Instruction* key = dyn_cast<Instruction>(calls)) {

               //        iInfo->at(key).insert(srcOp);
                    }
                  }
                } else {
                //otherwise, just the caller's
                  interProcSinks.push_back(caller);
                  interProcSinks.push_back(dyn_cast<Value>(&arg));
                  if (Instruction* key = dyn_cast<Instruction>(caller)) {
              //      iInfo->at(key).insert(srcOp);
                  }
                }
              }
            }
            //it wasn't pbref, just "store", so find fst ptr after call
            //and also put in iInfo
            if (!found) {
              Value* destFst = ptrAfterCall(dest,ci);

              
              //in case of loop 
              if (destFst !=ci->getOperand(0)) {
               // errs () << "found a memcpy store " << *destFst <<"\n";
                if(iInfo->find(ci)!=iInfo->end()) {
                  if (find(iInfo->at(ci).begin(), iInfo->at(ci).end(), srcOp)!=iInfo->at(ci).end()) {
                    continue;
                  } else {
                    iInfo->at(ci).insert(srcOp);
                  }
                } else {
                  set<Instruction*> seti;
                  seti.insert(srcOp);
                  iInfo->emplace(ci, seti);
                }
                localDeps.push(destFst);
              }
            }  
          } //end memcpy check

          //conservative tainting decision
          if (calledFunc->empty()) {
            
              //if it's empty but declared in our mod (one of the passed in C ones)
              //and it returns a value, then consider the taint passed to the 
              //return
              if (!calledFunc->getName().contains("llvm") && 
              !calledFunc->getName().contains("core")) {
                #if DEBUG
                errs() << "DEBUG: pushing presumed c lib func " << calledFunc->getName() << "\n";
                #endif
                localDeps.push(ci);
              }
            
          }
          continue;
            
        }
	      unsigned int arg_num = ci->getNumArgOperands();
	      
	      // Find the index of the tainted argument
	      for (unsigned int i = 0; i < arg_num; i++){
          #if DEBUG
            errs() << "DEBUG: comparing "<< *currVal <<" and " << *(ci->getArgOperand(i))<<"\n";
          #endif
	        if(ci->getArgOperand(i)==currVal) {
            #if DEBUG
              errs() << "DEBUG: pushing arg of "<< calledFunc->getName() <<"\n";
            #endif
	          interProcSinks.push_back((calledFunc->arg_begin() + i));
            //MUST also push back the call inst.
            interProcSinks.push_back(ci);
            //MUST also push back the current srcOp
            interProcSinks.push_back(srcOp);
            if (Instruction* key = dyn_cast<Instruction>(ci)) {
              //  iInfo->at(key).insert(srcOp);
            }
	          break;
	        }
	      }

      } else if (Instruction* iUse = dyn_cast<Instruction>(use)) {
        if (iUse->isTerminator()) {
          if (iUse->getNumSuccessors() > 1) {
            //Add control deps off of a branch.
            #if DEBUG
              errs() << "DEBUG: adding condeps case\n";
            #endif
            val_vec controlDeps = getControlDeps(iUse);
            //for all condep, add any reached loads, and add the store to the map 
            for (Value* item : controlDeps) {
              if (StoreInst* siCon = dyn_cast<StoreInst>(item)) {
                localDeps.push(siCon);
              }
            }//end for vals in condep
          }
        }//end terminator check
        #if DEBUG
        //errs() << "DEBUG: pushing "<< *iUse<<"\n";
        #endif
        localDeps.push(iUse);
      }
    }
  }

  return interProcSinks;
}



inst_vec findInputInsts(Module* M) 
{
  inst_vec sources;
  func_vec io_name;
  //Find io name annotations
  for(GlobalVariable& gv : M->globals()) {
    if(gv.getName().contains("IO_NAME"))  {
      
      if( Function* fp = dyn_cast<Function>(gv.getInitializer()->getOperand(0)->stripPointerCasts())) {
      #if DEBUG
        errs() << "Found io inst "<< fp->getName() <<"\n";
      #endif  
      	io_name.push_back(fp);
      } else {
      	errs() << "ERROR: could not unwrap function pointer from annotation\n";
      }
    }
  } 

  //now, search for calls to those functions
  for (Function& func : * M) {
    for (BasicBlock& bb : func) {
      for(Instruction& inst : bb) {
        if(CallInst* ci = dyn_cast<CallInst>(&inst)) {
        	if(find(io_name.begin(), io_name.end(),ci->getCalledFunction())!=io_name.end()) {
	          sources.push_back(&inst);
	        }
        }
      }

    } 
  }
  return sources;
}


/*See if a particular store is exposed to a use -- possibly replace couldLoadTainted*/
bool storePrecedesUse(Instruction* use, StoreInst* toMatch) {
  queue<BasicBlock*> to_visit; 
  vector<BasicBlock*> visited;
  BasicBlock* current;
  vector<Value*> possible;
  int found = 0;
  int skip = 1;
  
  to_visit.push(use->getParent());

  while(!to_visit.empty()) {
    current = to_visit.front();
    to_visit.pop();
     
    for(BasicBlock::reverse_iterator i = current->rbegin(), e = current->rend(); i!=e;++i) {
      Instruction* inst = &*i;
      //don't look at li block before li
      if((current == use->getParent())&&(skip)) {
	      //errs() << "skipping" << *inst <<"\n";
      	if(use==inst){
	        skip = 0;
      	}
      	continue;
      }
      //if(BI!=nullptr) {
      //errs() << "looking at" << *BI <<"\n";
    	if (StoreInst* si = dyn_cast<StoreInst>(inst)) {
    	  //errs() << "found a store" << *si <<"\n";
    	  if (si->getPointerOperand() == toMatch->getPointerOperand()) {
	        possible.push_back(si);
	        found = 1;
	        break;
	      }
    	}
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
  /*Was one of the preceding writes the store in question?*/
  for(Value* poss : possible) {
    if(poss == toMatch) {
	    return true;
    }
    
  }
  //this use does not consume the tainted store
  return false;
}


/*See if the same EP is used in multiple GEPI, check if exposed*/
inst_vec couldMatchGEPI(GetElementPtrInst* tGEPI) {
  queue<BasicBlock*> to_visit; 
  vector<BasicBlock*> visited;
  BasicBlock* current;
  vector<Value*> possible;
  inst_vec matching;
  int found = 0;
  int skip = 1;
  
  to_visit.push(tGEPI->getParent());

  while(!to_visit.empty()) {
    current = to_visit.front();
    to_visit.pop();
     
     //forwards exploration
    for(Instruction& i : *current) {
      Instruction* inst = &i;
      //don't look at gepi block before gepi
      if((current == tGEPI->getParent())&&(skip)) {
	      //errs() << "skipping" << *inst <<"\n";
      	if(tGEPI==inst){
	        skip = 0;
      	}
      	continue;
      }
      //if(BI!=nullptr) {
      //errs() << "looking at" << *BI <<"\n";
    	if (GetElementPtrInst* another = dyn_cast<GetElementPtrInst>(inst)) {
    	  //errs() << "found a store" << *si <<"\n";
        //check if the ops match
    	  if (another->getPointerOperand() == tGEPI->getPointerOperand()) {
          //check if used in load or store
	        for (Value* pUse : another->users()) {
            if (isa<StoreInst>(pUse)) {
              found = 1;
              break;
            }
          }
	        //no store
          if (!found) {
            #if DEBUG
            errs() << "matching GEPS: " << *another<<" and " << *tGEPI <<"\n";
            #endif
            matching.push_back(another);
          }
	      }
    	}
    }
    //we found a store in this node
    if(found) {
      found = 0;
      continue;
    }
    /*add succ. blocks to our queue*/
    for (auto SI = succ_begin(current); SI != succ_end(current); ++SI) {
      //if it's new
      if(!(find(visited.begin(), visited.end(), *SI) != visited.end())){
	      visited.push_back(*SI);
	      to_visit.push(*SI);
      }
    }
  }
  
  return matching;
}

/*Find first use of a pointer after a callInst, for pass-by-ref*/
Instruction* ptrAfterCall(Value* ptr, CallInst* ci) {
  queue<BasicBlock*> to_visit; 
  vector<BasicBlock*> visited;
  BasicBlock* current;
  
  int found = 0;
  int skip = 1;
  
  to_visit.push(ci->getParent());

  while(!to_visit.empty()) {
    current = to_visit.front();
    to_visit.pop();
     
     //forwards exploration
    for(Instruction& i : *current) {
      Instruction* inst = &i;
      //don't look at gepi block before gepi
      if((current == ci->getParent())&&(skip)) {
	      //errs() << "skipping" << *inst <<"\n";
      	if(ci==inst){
	        skip = 0;
      	}
      	continue;
      }
      //if the inst is a use of the pointer
    	if (find(ptr->user_begin(),ptr->user_end(), inst)!=ptr->user_end()) {
        return inst;
      }
      
    }
    /*add succ. blocks to our queue*/
    for (auto SI = succ_begin(current); SI != succ_end(current); ++SI) {
      //if it's new
      if(!(find(visited.begin(), visited.end(), *SI) != visited.end())){
	      visited.push_back(*SI);
	      to_visit.push(*SI);
      }
    }
  }
  return nullptr;
}


/*This is a function to return all the control dependent stores off of a control inst 
Input -- ti, the (formerly) terminator inst 
Output -- list of deps */
val_vec getControlDeps(Instruction* ti)
{
  val_vec deps;
  int succ_i = 0;
  while (succ_i < ti->getNumSuccessors()) {
    BasicBlock* bb = ti->getSuccessor(succ_i);
    succ_i++;
    for(Instruction& inst : *bb) {
      //if we encounter a store, add to deps
      if(isa<StoreInst>(&inst)) {
	      deps.push_back(&inst);
      } //if we encounter a multi succ branch, recursive call, if we encouter a join, continue to next succ
      else if(inst.isTerminator()) {

    	  if(ti->getNumSuccessors() > 1) {
	        vector<Value*> intermed = getControlDeps(&inst);
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


/*Get direct uses (at src level, not IR) of a fresh var*/
inst_vec traverseDirectUses(Instruction* root)
{
  inst_vec uses;
  queue<Instruction*> localDeps;
  localDeps.push(root);
  
  //Edge case: check if return is an internally allocated stack var
  Value* retPtr;
  Instruction* last = &(root->getFunction()->back().back());
  if (ReturnInst* ri = dyn_cast<ReturnInst>(last)) {
    for (Use& op : ri->operands()) {
      if(LoadInst* li  = dyn_cast<LoadInst>(op.get())) {
        retPtr = li->getPointerOperand();
      }
    }

  }

  while(!localDeps.empty()) {
    Instruction* currVal = localDeps.front();
    uses.push_back(currVal);
    localDeps.pop();
    for (Value* use : currVal->users()) {
      //if it's a gepi, see if there are others that occur afterwards 
      //      errs() << *use <<" is a direct use of " << *currVal<<"\n";
      if (isa<GetElementPtrInst>(use)) {
        inst_vec matching = couldMatchGEPI(dyn_cast<GetElementPtrInst>(use));
        for (Instruction* item : matching) {
	  //  errs() << "pushing to local deps " << *item <<"\n";
          localDeps.push(item);
        }
      }
      else if (ReturnInst* ri = dyn_cast<ReturnInst>(use)) {
        for(Value* calls : ri->getFunction()->users()) {
          if(isa<CallInst>(calls)) {
            uses.push_back(dyn_cast<Instruction>(calls));
            
          }
        }
      } else if (StoreInst* si = dyn_cast<StoreInst>(use)) {
        //if stores into ret pointer, treat as above
        if (si->getPointerOperand() == retPtr) {
          for(Value* calls : si->getFunction()->users()) {
            if(isa<CallInst>(calls)) {
             uses.push_back(dyn_cast<Instruction>(calls));
            
            }
         }
        }
      } else if (BranchInst* bi = dyn_cast<BranchInst>(use)) {
        //if a use is a branch inst the atomic region needs to 
        //dominate the successors
        for (BasicBlock* bbInterior : bi->successors()) {
          //skip panic blocks, otherwise there will be no post dom
          if (bbInterior->getName().equals("panic")) {
            continue;
          }
          uses.push_back(&(bbInterior->front()));
        }
      } else if (CallInst* ci = dyn_cast<CallInst>(use)) {
        if(ci->hasName() && ci->getName().startswith("_")) {
          //fall through  
        } else {
          uses.push_back(ci);
          continue;
        }
      }
      if (Instruction* iUse = dyn_cast<Instruction>(use)) {
        //see if load is to another var or just internal ssa
        if (LoadInst* li = dyn_cast<LoadInst>(iUse)) {
          if(li->hasName()) {
            //Hacky --verify that this is always true
            if(!li->getName().startswith("_")) {
              continue;
            }
          }
        }
        localDeps.push(iUse);
      }
    }
  }

  return uses;
}


