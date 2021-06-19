#include "include/InferAtomicPass.h"
#include "include/TaintTracker.h"

#define CAPSIZE 1000
#define PRINTMAPS 1
#define FRESHDEBUG 1

void InferAtomicModulePass::removeAnnotations(inst_vec* toDelete) 
{
 //delete all the annotation function calls
 bool instsLeftToDelete = true;
  Instruction* candidate;
  while (instsLeftToDelete) {
    instsLeftToDelete = false;
    //can't delete while directly iterating through the module
    for (Function& f : *this->m) {
      for (BasicBlock& bb : f) {
        for (Instruction& inst : bb) {

          //for now, let's just delete unused core or compiler builtin functions
          if(isa<CallInst>(&inst)) {
            if (find(toDelete->begin(), toDelete->end(), &inst)!=toDelete->end()) {
              candidate = &inst;
              instsLeftToDelete = true;
              break;
              }
          }
        }
      }
    }
      //recheck, as this could be the last iteration
      if(instsLeftToDelete) {
  #if DEBUG
        errs() << "DEBUG: deleting: " << candidate->getName() <<"\n";
  #endif
        candidate->replaceAllUsesWith(UndefValue::get(candidate->getType()));
        candidate->eraseFromParent();
      }
    
  }
    //now delete all the annotation functions
    //vector<Function*> toDeleteF;
    bool functionsLeftToDelete = true;
    Function* candidatef;
    while (functionsLeftToDelete) {
      functionsLeftToDelete = false;
      //can't delete while directly iterating through the module
      for (Function& f : *this->m) {
        if (f.hasName()) {
          //for now, let's just delete unused core or compiler builtin functions
          if(f.getName().contains("Fresh")||f.getName().contains("Consistent")) {
            candidatef = &f;
            functionsLeftToDelete = true;
            break;
            
          }
        }

      }

      //recheck, as this could be the last iteration
      if(functionsLeftToDelete) {
#if DEBUG
      errs() << "DEBUG: deleting: " << candidatef->getName() <<"\n";
#endif

      candidatef->replaceAllUsesWith(UndefValue::get(candidatef->getType()));
      candidatef->eraseFromParent();
    }
  }
}

/*
 * Top-level pass for atomic region inference 
 */
bool InferAtomicModulePass::runOnModule(Module &M) {
  m = &M;
  capacitorSize = CAPSIZE;

  //TODO: init atomStart/End with the proper functions
  for (Function& F : M) {
    if (F.getName().contains("atomic_start")) {
      #if DEBUG
      errs() << "DEBUG: found atom start\n";
      #endif
      atomStart = &F;
    }
    if (F.getName().contains("atomic_end")) {
      #if DEBUG
      errs() << "DEBUG: found atom end\n";
      #endif
      atomEnd = &F;
    }
  }

  //Build the consistent set and fresh lists here, to only 
  //go through all the declarations once. 
  std::map<int,inst_vec> conVars;
  inst_vec_vec freshVars;
  inst_insts_map inputInfo = buildInputs(m);
  inst_vec toDelete;
  getAnnotations(&conVars, &freshVars, inputInfo, &toDelete);
  //TODO: need to add unique point of call chain prefix to con set
  #if PRINTMAPS
    errs () << "Initial fresh is: \n";
    for (inst_vec item : freshVars) {
      for (Instruction* item2 : item) {
        errs() << *item2 << "\n";
      }
    }
    errs() << "End init fresh\n";
  #endif

  #if PRINTMAPS
    errs () << "Initial consistent is: \n";
    for (auto map : conVars) {
      errs() << "Begin set\n";
      for (Instruction* item2 : map.second) {
        errs() << *item2 << "\n";
      }
    }
    errs() << "End init Consistent\n";
  #endif

  #if PRINTMAPS
    errs() << "Printing map:\n";
    for (auto map : inputInfo) {
      if (isa<CallInst>(map.first)) {
      errs() << *(map.first) << "in map\n";
      for (Value* l : map.second) {
        errs() << *l << "\n";
      }
      }
    }
  #endif
  map<int,inst_vec> allConSets = collectCon(conVars, inputInfo);
  inst_vec_vec allFresh  = collectFresh(freshVars, inputInfo);

  
  
  #if PRINTMAPS
    errs () << "Fresh is: \n";
    for (inst_vec item : allFresh) {
      for (Instruction* item2 : item) {
        errs() << *item2 << "\n";
      }
    }
    errs() << "End fresh\n";
  #endif

  #if PRINTMAPS
    errs () << "Consistent is: \n";
    for (auto map : allConSets) {
      for (Instruction* item2 : map.second) {
        errs() << *item2 << "\n";
      }
    }
    errs() << "End Consistent\n";
  #endif

  
  
  //will do consistency first
  ConsistentInference* ci = new ConsistentInference(this, &M, atomStart, atomEnd);
  
  ci->inferConsistent(allConSets);
  ci->inferFresh(allFresh);
  
  //delete annotations
  removeAnnotations(&toDelete);
  
  return true;
}


/**This function finds annotated variables)**/
void InferAtomicModulePass::getAnnotations(std::map<int,inst_vec>* conSets, inst_vec_vec* freshVars, 
  inst_insts_map inputMap, inst_vec* toDelete) 
{
  //note: delete the annotation functions afterwards
  map<Instruction*, int> recallSet;
  
  for (Function& f : *m) {
    for (BasicBlock& bb : f) {
      for (Instruction& inst : bb) {
        if(CallInst* ci = dyn_cast<CallInst>(&inst)) {
          Function* called = ci->getCalledFunction();
          //various empty or null checks
          if (called==NULL) {
            continue;
          }
          if (called->empty()||!called->hasName()) {
            continue;
          }
          //covers both Consistent and FreshConsistent
          if (called->getName().contains("Consistent")) {
            //first para is var, second is id
            toDelete->push_back(ci);
            int setID;
            //v.push_back(ai); <<-- don't actually need this?
            //bit cast use of x, then value operand of store
            Instruction* var = dyn_cast<Instruction>(ci->getOperand(0));
            
            if (var==NULL) {
              //errs() << "error casting with " << *ci <<"\n";
              continue;
            }
	    // errs() << "New consistent annot. with " << *var<<"\n";
            Value* id = ci->getOperand(1);
            if(ConstantInt* cint = dyn_cast<ConstantInt>(id)) {
              setID = cint->getSExtValue();
            }
            queue<Value*> customUsers;
            set<Instruction*> v;
            //v.emplace(ci);
            //in case var itself is iOp
            for (Instruction* iOp : inputMap[var]) {
              v.emplace(iOp);
            }
	    
            //customUsers.push(var);
            for (Value* use : var->users()) {
              //don't push the annotation
              if (use == ci) {
                continue;
              }
              //errs() << "DEBUG: pushing use of var: " << *use << "\n";
              customUsers.push(use);
            }
            while(!customUsers.empty()) {
              Value* use = customUsers.front();
              customUsers.pop();
        //errs() << "DEBUG: use is " << *use << " of var " << *var<<"\n";
              if (Instruction* instUse = dyn_cast<Instruction>(use)) {
                for (Instruction* iOp : inputMap[instUse]) {
                      v.emplace(iOp);
            //  errs() << "DEBUG: adding to v  " << *iOp << "\n";
                }  
              }
              if(isa<BitCastInst>(use)||isa<ZExtInst>(use)) {
                for (Value* use2 : use->users()) {
                 // errs() << "DEBUG: use2 is " << *use2 << "\n";
                  if(StoreInst* si = dyn_cast<StoreInst>(use2)){
                    for (Instruction* iOp : inputMap[si]) {
                      v.emplace(iOp);
                  //    errs() << "DEBUG: adding to v  " << *iOp << "\n";
                    }
                  }
                //  errs() << "DEBUG: pushing use2 of var: " << *use2 << "\n";
                  customUsers.push(use2);
                }
              }

              if(isa<GetElementPtrInst>(use)) {
                for (Value* use2 : use->users()) {
              //    errs() << "DEBUG: use2 is " << *use2 << "\n";
                  if(StoreInst* si = dyn_cast<StoreInst>(use2)){
                      //v.push_back(si);
                    for (Instruction* iOp : inputMap[si]) {
                      v.emplace(iOp);
                //      errs() << "DEBUG: adding to v  " << *iOp << "\n";
                    }
                  }
              //    errs() << "DEBUG: pushing use2 of var: " << *use2 << "\n";
                  customUsers.push(use2);
                }
              }
            }
	    //last case
	    if (v.empty()) {
	      //some entries have a first link with ci, not var
	    
	      for (Instruction* iOp : inputMap[ci]) {
		if (inputMap[ci].size() == 1) {
		  for (Instruction* origLink : inputMap[iOp]) {
		    v.emplace(origLink);
		  }
		} else {
		  v.emplace(iOp);
		}
	      
	      }
	     

	    }
	     //for later deletion purposes
	    inputMap.erase(ci);
            
              
            if (!v.empty()) {
              inst_vec temp;
              for (Instruction* item : v) {
                temp.push_back(item);
              }
              //add the collected list to the map
              if(conSets->find(setID)!=conSets->end()) {
                conSets->at(setID).insert(conSets->at(setID).end(), temp.begin(), temp.end());
              } else {
                conSets->emplace(setID, temp);
              }
            }
            
          }
          if (called->getName().contains("Fresh")) {
            set<Instruction*> v;
            toDelete->push_back(ci);
            inputMap.erase(ci);
            Value* var = ci->getOperand(0);
            if (Instruction* inst = dyn_cast<Instruction>(var)) {
              v.emplace(inst);
            } else {
              //errs() << "error casting\n";
            }
	    //errs() << "New Fresh annot. with " << *var<<"\n";
           // v.push_back(ci);
              
            for(Value* use : var->users()) {
              if(StoreInst* si = dyn_cast<StoreInst>(use)){
            //     errs() << "DEBUG: pushing " << *use << "\n";
                v.emplace(si);
              }
              if(isa<GetElementPtrInst>(use)) {
                for (Value* use2 : use->users()) {
                //   errs() << "DEBUG: pushing " << *use2 << "\n";
                  if(StoreInst* si = dyn_cast<StoreInst>(use2)){
                    v.emplace(si);
                  }
                }
              }
            }
            if (!v.empty()) {
              inst_vec temp;
              for (Instruction* item : v) {
                temp.push_back(item);
              }
              freshVars->push_back(temp);
            }
          }
            
        }

      }
    }
  }

}
  



/*Given the starting point annotations of conSets, find the 
deepest unique point of the call chain*/
map<int, inst_vec> InferAtomicModulePass::collectCon(map<int, inst_vec> startingPoints, inst_insts_map inputMap)
{
  map<int, inst_vec> toReturn;
  for (pair<int, inst_vec> iv : startingPoints ) {
    set<Instruction*> unique;
    map<Instruction*,set<Instruction*>> callChains;
    //each item should be the starting point from a different annot
    for(Instruction* item : iv.second) {
      #if FRESHDEBUG
        errs() << "Starting point: " << *item << "\n";
      #endif
      //add self to call chain
      callChains[item].insert(item);

      for (Instruction* iOp : inputMap[item]) {
	//    unique.insert(iOp);
        callChains[item].insert(iOp);
        queue<Instruction*> toExplore;
        toExplore.push(iOp);
        while (!toExplore.empty()) {
          Instruction* curr = toExplore.front();
          toExplore.pop();
          for (Instruction* intermed : inputMap[curr]) {
            if (! (find(callChains[item].begin(), callChains[item].end(), intermed)
            !=callChains[item].end())) {
              callChains[item].insert(intermed);
              toExplore.push(intermed);
            }
          }
        }

      }// finish constructing call chain for one annot. in the set      
      
    }//constructed call chains for ALL annot. in the set.
    //now check the call chain
    
    //int index = 0;
    //map<Instruction*,bool> foundUniquePoint;
    //clean up the call chains
    
    for(auto ccmap : callChains) {
      for (Instruction* possibility : ccmap.second) {
        //if the link is in the same function, then continue
	//errs() << "examining possibility: " << *possibility << "\n";
	bool sf = false;
	for (Instruction* link : inputMap[possibility]) {
	  //errs() << "next link is" << *link << "\n";
	  if ((link!=possibility) && link->getFunction() == possibility->getFunction()) {
	      sf = true;
	      
	  }
	}
	if (sf) {
	  continue;
	}
        bool isUnique = true;
        for (auto ccmapNest : callChains) {
          //if self then skip
          if (ccmapNest == ccmap) {
            continue;
          }
          //otherwise check if this map also contains the possibility
          if (find(ccmapNest.second.begin(), ccmapNest.second.end(), possibility)
          != ccmapNest.second.end())
          {
            isUnique = false;
            break;
          }
        }
        if (isUnique){
          unique.insert(possibility);
	  //  errs() << "Found unique!" << *possibility << "\n";
	} else {
          //try another poss.
          continue;
        }
      }
    }
    

    inst_vec v;
    for (Instruction* item2 : unique) {
      if (!isa<AllocaInst>(item2)) {
        v.push_back(item2);
      }
    }
    toReturn[iv.first] = v;  
  }//end starting point check

  return toReturn;
}

/*This function collects the input srcs and uses off of the fresh annotated vars*/
inst_vec_vec InferAtomicModulePass::collectFresh(inst_vec_vec startingPoints, inst_insts_map inputMap)
{
  inst_vec_vec toReturn;
  
  for (inst_vec iv : startingPoints ) {
    set<Instruction*> unique;
    set<Instruction*> callChain;
    for(Instruction* item : iv) {
      #if FRESHDEBUG
        errs() << "Starting point: " << *item << "\n";
      #endif
      //uses (forwards) are direct only (might need a little chaining for direct in rs to be direct in IR)
      inst_vec uses = traverseDirectUses(item);

      for (Instruction* use : uses) {
        #if FRESHDEBUG
        errs() << "Starting point use: " << *use << "\n";
      #endif
       // if (isa<StoreInst>(use)||isa<CallInst>(use)) {
          unique.insert(use);
        //}
        for (Instruction* iOp : inputMap[use]) {
          unique.insert(iOp);
        }
      }

      for (Instruction* iOp : inputMap[item]) {
        unique.insert(iOp);
        callChain.insert(iOp);
        queue<Instruction*> toExplore;
        toExplore.push(iOp);
        while (!toExplore.empty()) {
          Instruction* curr = toExplore.front();
          toExplore.pop();
          for (Instruction* intermed : inputMap[curr]) {
            if (! (find(callChain.begin(), callChain.end(), intermed)!=callChain.end())) {
              callChain.insert(intermed);
              toExplore.push(intermed);
            }
          }
        }

      }
      //don't forget the item itself
      if (isa<StoreInst>(item)||isa<CallInst>(item)) {
        unique.insert(item);
      }
      
      
    }
    //now construct the call chain
    for (Instruction* vv : callChain) {
      //   errs() << "call chain val: " << *vv <<"\n";
      unique.insert(vv);
    }
    inst_vec v;
    for (Instruction* item2 : unique) {
      if (!isa<AllocaInst>(item2)) {
        v.push_back(item2);
      }
    }
    toReturn.push_back(v);  
  }

  
  return toReturn;
}

char InferAtomicModulePass::ID = 0;

RegisterPass<InferAtomicModulePass> X("atomize", "Infer Atomic Pass");
