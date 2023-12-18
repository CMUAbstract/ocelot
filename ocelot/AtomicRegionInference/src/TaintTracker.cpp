#include "include/TaintTracker.h"

// Main dataflow function to construct map of store (TODO: not just stores) insts to vars (inputs?) they depend on
inst_insts_map buildInputs(Module* M) {
#if DEBUG
  errs() << "=== buildInputs ===\n";
#endif

  inst_vec inputInsts = findInputInsts(M);
  inst_insts_map taintedInsts;
  inst_vec promotedInputs;

  for (auto inputInst : inputInsts) {
#if DEBUG
    errs() << "[Loop inputInst] orig input: " << *inputInst << "\n";
#endif

    // Add self to map
    taintedInsts[inputInst].insert(inputInst);
    std::queue<Value*> toExplore;
#if DEBUG
    errs() << "[Loop inputInst] Add orig input to toExplore\n";
#endif
    toExplore.push(inputInst);

#if DEBUG
    errs() << "[Loop inputInst] Explore flows from orig input\n";
#endif

    // Iterate until no more inter-proc flows found
    while (!toExplore.empty()) {
#if DEBUG
      errs() << "=== Loop toExplore ===\n";
#endif
      auto* curVal = toExplore.front();
      toExplore.pop();

      if (curVal == NULL) continue;

#if DEBUG
      errs() << "[Loop toExplore] cur inst: " << *curVal << "\n";
#endif

      val_vec interProcFlows;
      if (curVal == inputInst) {
#if DEBUG
        errs() << "[Loop toExplore] cur inst = orig input\n";
        errs() << "[Loop toExplore] Call traverseLocal with cur inst (tainted), orig input (srcInput), caller (none)\n";
#endif
        interProcFlows = traverseLocal(curVal, inputInst, &taintedInsts, nullptr);
#if DEBUG
        errs() << "[Loop toExplore] [cur inst = orig input] Inspect interProcFlows:\n";
#endif
        for (auto* vipf : interProcFlows) {
          if (auto* iipf = dyn_cast<Instruction>(vipf)) {
            if (auto* anno_check = dyn_cast<CallInst>(iipf)) {
              // We delete these later... creates problems
              if (isAnnot(anno_check->getName())) continue;
            }

#if DEBUG
            errs() << "Adding orig input (" << *inputInst << ") to set at " << *iipf << "\n";
#endif
            taintedInsts[iipf].insert(inputInst);
          }
        }
      } else if (isa<CallInst>(curVal)) {
#if DEBUG
        errs() << "[Loop toExplore] cur inst = CallInst\n";
#endif
        // Note it will not be iop, even though iop is a call
        // This case handles both returns and pbref

        promotedInputs.push_back(dyn_cast<CallInst>(curVal));
        auto* next = toExplore.front();
        toExplore.pop();
        // If the next is a return, this was a return flow
        // Otherwise, if it's an arg, this was pbref
        //? pbref - pass by reference?
        if (isa<ReturnInst>(next)) {
#if DEBUG
          errs() << "[Loop toExplore] cur inst next = Return inst (return flow)\n";
#endif
          interProcFlows = traverseLocal(curVal, dyn_cast<CallInst>(curVal), &taintedInsts, nullptr);
          for (Value* vipf : interProcFlows) {
            if (Instruction* iipf = dyn_cast<Instruction>(vipf)) {
              // don't add self
              if (curVal == vipf) {
                continue;
              }
              if (CallInst* anno_check = dyn_cast<CallInst>(iipf)) {
                // we delete these later... creates problems
                if (anno_check->getName().contains("Fresh") ||
                    anno_check->getName().contains("Consistent")) {
                  continue;
                }
              }
              taintedInsts[iipf].insert(dyn_cast<CallInst>(curVal));
            }
          }
        } else if (isa<Argument>(next)) {
#if DEBUG
          errs() << "[Loop toExplore] cur inst next = Argument (pbref)\n";
#endif
          // Grab the para corresponding to the argument
          int index = -1;
          int i = 0;
          CallInst* ci = dyn_cast<CallInst>(curVal);

          if (ci->getCalledFunction() == NULL) continue;
          if (ci->getCalledFunction()->empty()) continue;

#if DEBUG
          errs() << "exploring function " << ci->getCalledFunction()->getName() << "\n";
#endif

          for (auto& arg : ci->getCalledFunction()->args()) {
            // errs() <<"arg is "<<arg<<"\n";
            if (dyn_cast<Value>(&arg) != next) {
              i++;
            } else {
              index = i;
            }
          }
          if (index == -1) {
#if DEBUG
            errs() << "couldn't find pass by ref " << *next << "\n";
#endif
            continue;
          }

          Value* tArg = ci->getArgOperand(index);
          // errs() << "arg_op: "<< *arg_op<<"\n";
          // check if reference is part of an array
          if (GEPOperator* gep = dyn_cast<GEPOperator>(tArg)) {
            tArg = gep->getPointerOperand();
          }
          // if bitcast inst,
          else if (BitCastInst* bci = dyn_cast<BitCastInst>(tArg)) {
            tArg = bci->getOperand(0);
          }
          // need to actually find the first use *after* the callInst
          Instruction* fstUse = ptrAfterCall(tArg, ci);
          if (fstUse != nullptr && fstUse != tArg) {
#if DEBUG
            errs() << "First use after call: " << *fstUse << "\n";
#endif
            // if the first use is itself a callinst, then treat as a tainted para case,
            val_vec visited_fstuse;
            visited_fstuse.push_back(ci);

            while (CallInst* ci_fstuse = dyn_cast<CallInst>(fstUse)) {
              // already visited, as in loop
              if (find(visited_fstuse.begin(), visited_fstuse.end(), ci_fstuse) != visited_fstuse.end()) {
                // no non-call uses
                fstUse = nullptr;
                break;
              }
              if (CallInst* anno_check = dyn_cast<CallInst>(ci_fstuse)) {
                // we delete these later... creates problems
                if (anno_check->getName().contains("Fresh") ||
                    anno_check->getName().contains("Consistent")) {
                  continue;
                }
              }
              visited_fstuse.push_back(ci_fstuse);

              unsigned int arg_num = ci_fstuse->arg_size();

#if DEBUG
              errs() << "[Loop customUsers] Find index of tainted arg:\n";
#endif
              // Find the index of the tainted argument
              for (unsigned int i = 0; i < arg_num; i++) {
                // TODO
#if DEBUG
                errs() << "comparing " << *tArg << " and " << *(ci_fstuse->getArgOperand(i)) << "\n";
#endif
                if (ci_fstuse->getArgOperand(i) == tArg) {
#if DEBUG
                  // errs() << "pushing arg of "<< calledFunc->getName() <<"\n";
#endif
                  interProcFlows.push_back((ci_fstuse->getCalledFunction()->arg_begin() + i));
                  // MUST also push back the call inst.
                  interProcFlows.push_back(ci_fstuse);
                  // and the srcOp
                  interProcFlows.push_back(ci);

                  break;
                }
              }
              // find next local use
              // promoted_inputs.push_back(ci);
              taintedInsts[ci_fstuse].insert(ci);
              fstUse = ptrAfterCall(tArg, ci_fstuse);

              if (fstUse == nullptr) {
                break;
              }
            }
            // re nullptr check
            if (fstUse != nullptr) {
              interProcFlows = traverseLocal(fstUse, dyn_cast<CallInst>(curVal), &taintedInsts, nullptr);
              for (Value* vipf : interProcFlows) {
                if (Instruction* iipf = dyn_cast<Instruction>(vipf)) {
                  if (CallInst* anno_check = dyn_cast<CallInst>(iipf)) {
                    // we delete these later... creates problems
                    if (anno_check->getName().contains("Fresh") ||
                        anno_check->getName().contains("Consistent")) {
                      continue;
                    }
                  }
                  taintedInsts[iipf].insert(dyn_cast<CallInst>(curVal));
                }
              }
            }
          }
        }
      } else if (isa<Argument>(curVal)) {
#if DEBUG
        errs() << "[Loop toExplore] cur inst = Argument (tainted arg)\n";
#endif

        auto* caller = dyn_cast<CallInst>(toExplore.front());
        toExplore.pop();
#if DEBUG
        errs() << "[Loop toExplore] Caller: " << *caller << "\n";
#endif
        // promoted_inputs.push_back(caller);

        auto* innerInputInst = dyn_cast<Instruction>(toExplore.front());
        toExplore.pop();
#if DEBUG
        errs() << "[Loop toExplore] orig input: " << *innerInputInst << "\n";
        errs() << "[Loop toExplore] Call traverseLocal with cur inst (tainted), orig input (srcInput), caller\n";
#endif

        interProcFlows = traverseLocal(curVal, innerInputInst, &taintedInsts, caller);

#if DEBUG
        errs() << "[Loop toExplore] Inspect interProcFlows:\n";
#endif
        for (auto* vipf : interProcFlows) {
          if (auto* iipf = dyn_cast<Instruction>(vipf)) {
            if (auto* anno_check = dyn_cast<CallInst>(iipf)) {
              // We delete these later... creates problems
              if (isAnnot(anno_check->getName())) continue;
            }
            taintedInsts[iipf].insert(innerInputInst);
#if DEBUG
            errs() << "Adding innerInputInst (" << *innerInputInst << ") to set at " << *iipf << "\n";
#endif
          }
        }
      }  // end elsif chain

      for (auto* item : interProcFlows) {
        if (item != NULL) {
#if DEBUG
          errs() << "Add to toExplore: " << *item << "\n";
#endif
          toExplore.push(item);
        } else {
          errs() << "ERROR: encountered null interproc item\n";
        }
      }

#if DEBUG
      errs() << "*** Loop toExplore ***\n";
#endif
    }  // end while queue not empty
  }    // end for all inputInsts

#if DEBUG
  errs() << "*** buildInputs ***\n";
#endif
  return taintedInsts;
}

val_vec traverseLocal(Value* tainted, Instruction* srcInput, inst_insts_map* taintedInsts, Instruction* caller) {
#if DEBUG
  errs() << "=== traverseLocal ===\n";
#endif

  val_vec interProcSinks;
  std::queue<Value*> localDeps;

#if DEBUG
  errs() << "Add cur inst to localDeps\n";
#endif
  localDeps.push(tainted);
  while (!localDeps.empty()) {
#if DEBUG
    errs() << "=== Loop localDeps ===\n";
#endif
    auto* curVal = localDeps.front();
    localDeps.pop();
#if DEBUG
    errs() << "[Loop localDeps] cur inst: " << *curVal << "\n";
#endif
    val_vec customUsers;
    if (auto* si = dyn_cast<StoreInst>(curVal)) {
#if DEBUG
      errs() << "[Loop localDeps] cur inst = StoreInst\n";
#endif
      // Add the pointer to deps, as stores have no uses
      // Add info on the store to the map
      if (taintedInsts->find(si) != taintedInsts->end()) {
        auto insts = taintedInsts->at(si);
        if (std::find(insts.begin(), insts.end(), srcInput) != insts.end()) continue;
        taintedInsts->at(si).insert(srcInput);
      } else {
        std::set<Instruction*> seti;
        seti.insert(srcInput);
        taintedInsts->emplace(si, seti);
      }
#if DEBUG
      errs() << "[Loop localDeps] Adding orig input (" << *srcInput << ") to set at cur inst (" << *si << ")\n";
#endif
      // See if it is (or aliases?) one of the function arguments (PBRef comp)
      for (auto& arg : si->getFunction()->args()) {
        auto* storePtr = si->getPointerOperand()->stripPointerCasts();
#if DEBUG
        errs() << "[Loop localDeps] Is ptr being stored to (" << *storePtr << ") = fun arg (" << arg << ")\n";
#endif
        if (storePtr == &arg) {
          // if taint came from inside any callsite is potentially tainted
          if (caller == nullptr) {
            for (auto calls : si->getFunction()->users()) {
              interProcSinks.push_back(calls);
              interProcSinks.push_back(dyn_cast<Value>(&arg));
              if (auto key = dyn_cast<Instruction>(calls)) {
                // check to make sure not already visited
                //   taintedInsts->at(key).insert(srcOp);
              }
            }
          } else {
            // otherwise, just the caller's
            interProcSinks.push_back(caller);
            interProcSinks.push_back(dyn_cast<Value>(&arg));
            if (auto key = dyn_cast<Instruction>(caller)) {
              // check to make sure not already visited
              //        taintedInsts->at(key).insert(srcOp);
            }
          }
        }
      }
      // Construct "users" of the store
#if DEBUG
      errs() << "[Loop localDeps] Add users (loads) of store to customUsers:\n";
#endif
      // Add in loads that are reachable from the tainted store.
      auto* ptr = si->getPointerOperand();
      // If bci, get the operand, as that's the useful ptr
      if (auto bciptr = dyn_cast<BitCastInst>(ptr)) ptr = bciptr->getOperand(0);
      for (auto* use : ptr->users()) {
        if (auto* useOfStore = dyn_cast<Instruction>(use)) {
          if (storePrecedesUse(useOfStore, si)) {
#if DEBUG
            errs() << "[Loop Store Users] store precedes this use, add:" << *useOfStore << "\n";
#endif
            customUsers.push_back(useOfStore);
          }
        }
      }
      // Update curVal to be the pointer
      curVal = si->getPointerOperand();

      // If it's a gepi, see if there are others that occur afterwards
      if (isa<GetElementPtrInst>(si->getPointerOperand())) {
        inst_vec matching = couldMatchGEPI(dyn_cast<GetElementPtrInst>(si->getPointerOperand()));
        for (auto item : matching) {
          localDeps.push(item);
        }
        // check pbref, need to compare op of the gepi, not gepi itself
        for (auto& arg : si->getFunction()->args()) {
#if DEBUG
          errs() << " PBRef comp: " << *dyn_cast<Instruction>(curVal)->getOperand(0) << " and " << arg << "\n";
#endif
          if (dyn_cast<Instruction>(curVal)->getOperand(0) == &arg) {
            // if taint came from inside any callsite is potentially tainted
            if (caller == nullptr) {
              for (Value* calls : si->getFunction()->users()) {
                interProcSinks.push_back(calls);
                interProcSinks.push_back(dyn_cast<Value>(&arg));
                if (Instruction* key = dyn_cast<Instruction>(calls)) {
                  //         taintedInsts->at(key).insert(srcOp);
                }
              }
            } else {
              // otherwise, just the caller's
              interProcSinks.push_back(caller);
              interProcSinks.push_back(dyn_cast<Value>(&arg));
              if (Instruction* key = dyn_cast<Instruction>(caller)) {
                //  taintedInsts->at(key).insert(srcOp);
              }
            }
          }
        }
      }

    } else {
#if DEBUG
      errs() << "[Loop localDeps] cur inst != StoreInst\n";
      errs() << "[Loop localDeps] Add users of cur inst to customUsers:\n";
      for (auto* use : curVal->users()) errs() << *use << "\n";
#endif
      // If not a store, do normal users of curVal
      customUsers.insert(customUsers.end(), curVal->user_begin(), curVal->user_end());
    }

#if DEBUG
    errs() << "[Loop localDeps] Go over uses\n";
#endif
    //* Here we may cross over to another procedure
    for (auto* use : customUsers) {
      // Check that the use of a tainted pointer is really tainted

      // This is checking if the use is a tainted store

      if (auto ri = dyn_cast<ReturnInst>(use)) {
#if DEBUG
        errs() << "[Loop customUsers] use = ReturnInst\n";
#endif
        if (caller == nullptr) {
#if DEBUG
          errs() << "[Loop customUsers] No caller\n";
#endif
          for (auto calls : ri->getFunction()->users()) {
            if (auto ci = dyn_cast<CallInst>(calls)) {
              interProcSinks.push_back(calls);
              // extra for bookkeeping
              interProcSinks.push_back(use);
            }
          }
        } else {
#if DEBUG
          errs() << "[Loop customUsers] Some caller\n";
#endif
          // otherwise, just the caller's
          interProcSinks.push_back(caller);
          // extra for bookkeeping
          interProcSinks.push_back(use);
        }
      } else if (auto* ci = dyn_cast<CallInst>(use)) {
#if DEBUG
        errs() << "[Loop customUsers] use = CallInst\n";
#endif
        // Add the right argument to the list
        auto* calledFun = ci->getCalledFunction();
        if (calledFun == NULL || calledFun->empty()) {
          // special case for llvm.memcpy
          // See if it is (or aliases?) one of the function arguments
          if (calledFun != NULL && calledFun->hasName() &&
              calledFun->getName().contains("llvm.memcpy")) {
            // errs() << "memcpy " << *ci << "\n";
            Value* src = ci->getOperand(1)->stripPointerCasts();
            Value* dest = ci->getOperand(0);
            // errs() << "with dest " << *dest << "\n";
            if (BitCastInst* bci = dyn_cast<BitCastInst>(dest)) {
              dest = bci->getOperand(0);
            }
            if (GetElementPtrInst* gepi = dyn_cast<GetElementPtrInst>(dest)) {
              dest = gepi->getOperand(0);
              //    errs() << "and gepi dest " << *dest << "\n";
            }
            bool found = false;
            for (Argument& arg : ci->getFunction()->args()) {
// Value* to_comp =
#if DEBUG
              errs() << " PBRef comp: " << *dest << " and " << arg << "\n";
#endif
              if (dest == &arg) {
                found = true;
                // if taint came from inside any callsite is potentially tainted
                if (caller == nullptr) {
                  for (Value* calls : ci->getFunction()->users()) {
                    interProcSinks.push_back(calls);
                    interProcSinks.push_back(dyn_cast<Value>(&arg));
                    if (Instruction* key = dyn_cast<Instruction>(calls)) {
                      //        taintedInsts->at(key).insert(srcOp);
                    }
                  }
                } else {
                  // otherwise, just the caller's
                  interProcSinks.push_back(caller);
                  interProcSinks.push_back(dyn_cast<Value>(&arg));
                  if (Instruction* key = dyn_cast<Instruction>(caller)) {
                    //      taintedInsts->at(key).insert(srcOp);
                  }
                }
              }
            }
            // it wasn't pbref, just "store", so find fst ptr after call
            // and also put in taintedInsts
            if (!found) {
              Value* destFst = ptrAfterCall(dest, ci);

              // in case of loop
              if (destFst != ci->getOperand(0)) {
                // errs () << "found a memcpy store " << *destFst <<"\n";
                if (taintedInsts->find(ci) != taintedInsts->end()) {
                  if (find(taintedInsts->at(ci).begin(), taintedInsts->at(ci).end(), srcInput) != taintedInsts->at(ci).end()) {
                    continue;
                  } else {
                    taintedInsts->at(ci).insert(srcInput);
                  }
                } else {
                  std::set<Instruction*> seti;
                  seti.insert(srcInput);
                  taintedInsts->emplace(ci, seti);
                }
                localDeps.push(destFst);
              }
            }
          }  // end memcpy check

          // conservative tainting decision
          if (calledFun->empty()) {
            // if it's empty but declared in our mod (one of the passed in C ones)
            // and it returns a value, then consider the taint passed to the
            // return
            if (!calledFun->getName().contains("llvm") &&
                !calledFun->getName().contains("core")) {
#if DEBUG
              errs() << "pushing presumed c lib func " << calledFun->getName() << "\n";
#endif
              localDeps.push(ci);
            }
          }
          continue;
        }

        unsigned int arg_num = ci->arg_size();
#if DEBUG
        errs() << "[Loop customUsers] Find tainted arg of " << calledFun->getName() << "\n";
#endif
        // Find the index of the tainted argument
        for (unsigned int i = 0; i < arg_num; i++) {
          auto* arg = ci->getArgOperand(i);
          if (arg == curVal) {
            auto funArg = calledFun->arg_begin() + i;
#if DEBUG
            errs() << "Found tainted arg: " << *arg << ", add fun arg (" << *funArg << "), the use (" << *ci << "), and orig input (" << *srcInput << ") to interProcFlows\n";
#endif
            interProcSinks.push_back(funArg);
            // MUST also push back the call inst.
            interProcSinks.push_back(ci);
            // MUST also push back the current srcInput
            interProcSinks.push_back(srcInput);
            if (auto* key = dyn_cast<Instruction>(ci)) {
              //  taintedInsts->at(key).insert(srcOp);
            }
            break;
          }
        }
      } else if (auto* iUse = dyn_cast<Instruction>(use)) {
#if DEBUG
        errs() << "[Loop customUsers] use != ReturnInst & use != CallInst\n";
#endif
        if (iUse->isTerminator()) {
          if (iUse->getNumSuccessors() > 1) {
// Add control deps off of a branch.
#if DEBUG
            errs() << "adding condeps case\n";
#endif
            val_vec controlDeps = getControlDeps(iUse);
            // for all condep, add any reached loads, and add the store to the map
            for (auto* item : controlDeps) {
              if (auto* siCon = dyn_cast<StoreInst>(item)) {
                localDeps.push(siCon);
              }
            }
          }
        }

#if DEBUG
        errs() << "[Loop customUsers] Add use to localDeps\n";
#endif
        //* Here we may push inst from another procedure, crossing boundaries
        localDeps.push(iUse);
      }
    }
#if DEBUG
    errs() << "*** Loop localDeps ***\n";
#endif
  }

#if DEBUG
  errs() << "*** traverseLocal ***\n";
#endif
  return interProcSinks;
}

inst_vec findInputInsts(Module* M) {
#if DEBUG
  errs() << "findInputInsts\n";
#endif
  inst_vec inputInsts;

  // Find IO_NAME annotations
  for (auto& gv : M->globals()) {
    if (gv.getName().starts_with("IO_NAME")) {
      if (auto* fp = dyn_cast<Function>(gv.getInitializer())) {
#if DEBUG
        errs() << "Found IO fun: " << fp->getName() << "\n";
#endif
        // Now, search for calls to those functions
        for (auto& F : *M) {
          for (auto& B : F) {
            for (auto& I : B) {
              if (auto* ci = dyn_cast<CallInst>(&I)) {
                if (fp == ci->getCalledFunction()) {
#if DEBUG
                  errs() << "Found IO call: " << I << "\n";
#endif
                  inputInsts.push_back(&I);
                  break;
                }
              }
            }
          }
        }
      } else {
        // TODO: Say something else
        errs() << "[ERROR] Could not unwrap function pointer from annotation\n";
      }
    }
  }

  return inputInsts;
}

// See if a particular store is exposed to a use -- possibly replace couldLoadTainted
bool storePrecedesUse(Instruction* use, StoreInst* toMatch) {
  std::queue<BasicBlock*> to_visit;
  std::vector<BasicBlock*> visited;
  BasicBlock* current;
  std::vector<Value*> possible;
  int found = 0;
  int skip = 1;

  to_visit.push(use->getParent());

  while (!to_visit.empty()) {
    current = to_visit.front();
    to_visit.pop();

    for (BasicBlock::reverse_iterator i = current->rbegin(), e = current->rend(); i != e; ++i) {
      Instruction* inst = &*i;
      // don't look at li block before li
      if ((current == use->getParent()) && (skip)) {
        // errs() << "skipping" << *inst <<"\n";
        if (use == inst) {
          skip = 0;
        }
        continue;
      }
      // if(BI!=nullptr) {
      // errs() << "looking at" << *BI <<"\n";
      if (StoreInst* si = dyn_cast<StoreInst>(inst)) {
        // errs() << "found a store" << *si <<"\n";
        if (si->getPointerOperand() == toMatch->getPointerOperand()) {
          possible.push_back(si);
          found = 1;
          break;
        }
      }
    }
    // we found a store in this node
    if (found) {
      found = 0;
      continue;
    }
    /*add pred. blocks to our queue*/
    for (auto PI = pred_begin(current); PI != pred_end(current); ++PI) {
      // if it's new
      if (!(find(visited.begin(), visited.end(), *PI) != visited.end())) {
        visited.push_back(*PI);
        to_visit.push(*PI);
      }
    }
  }
  /*Was one of the preceding writes the store in question?*/
  for (Value* poss : possible) {
    if (poss == toMatch) {
      return true;
    }
  }
  // this use does not consume the tainted store
  return false;
}

/*See if the same EP is used in multiple GEPI, check if exposed*/
inst_vec couldMatchGEPI(GetElementPtrInst* tGEPI) {
  std::queue<BasicBlock*> to_visit;
  std::vector<BasicBlock*> visited;
  BasicBlock* current;
  std::vector<Value*> possible;
  inst_vec matching;
  int found = 0;
  int skip = 1;

  to_visit.push(tGEPI->getParent());

  while (!to_visit.empty()) {
    current = to_visit.front();
    to_visit.pop();

    // forwards exploration
    for (Instruction& i : *current) {
      Instruction* inst = &i;
      // don't look at gepi block before gepi
      if ((current == tGEPI->getParent()) && (skip)) {
        // errs() << "skipping" << *inst <<"\n";
        if (tGEPI == inst) {
          skip = 0;
        }
        continue;
      }
      // if(BI!=nullptr) {
      // errs() << "looking at" << *BI <<"\n";
      if (GetElementPtrInst* another = dyn_cast<GetElementPtrInst>(inst)) {
        // errs() << "found a store" << *si <<"\n";
        // check if the ops match
        if (another->getPointerOperand() == tGEPI->getPointerOperand()) {
          // check if used in load or store
          for (Value* pUse : another->users()) {
            if (isa<StoreInst>(pUse)) {
              found = 1;
              break;
            }
          }
          // no store
          if (!found) {
#if DEBUG
            errs() << "matching GEPS: " << *another << " and " << *tGEPI << "\n";
#endif
            matching.push_back(another);
          }
        }
      }
    }
    // we found a store in this node
    if (found) {
      found = 0;
      continue;
    }
    /*add succ. blocks to our queue*/
    for (auto SI = succ_begin(current); SI != succ_end(current); ++SI) {
      // if it's new
      if (!(find(visited.begin(), visited.end(), *SI) != visited.end())) {
        visited.push_back(*SI);
        to_visit.push(*SI);
      }
    }
  }

  return matching;
}

/*Find first use of a pointer after a callInst, for pass-by-ref*/
Instruction* ptrAfterCall(Value* ptr, CallInst* ci) {
  std::queue<BasicBlock*> to_visit;
  std::vector<BasicBlock*> visited;
  BasicBlock* current;

  int found = 0;
  int skip = 1;

  to_visit.push(ci->getParent());

  while (!to_visit.empty()) {
    current = to_visit.front();
    to_visit.pop();

    // forwards exploration
    for (Instruction& i : *current) {
      Instruction* inst = &i;
      // don't look at gepi block before gepi
      if ((current == ci->getParent()) && (skip)) {
        // errs() << "skipping" << *inst <<"\n";
        if (ci == inst) {
          skip = 0;
        }
        continue;
      }
      // if the inst is a use of the pointer
      if (std::find(ptr->user_begin(), ptr->user_end(), inst) != ptr->user_end()) {
        return inst;
      }
    }
    /*add succ. blocks to our queue*/
    for (auto SI = succ_begin(current); SI != succ_end(current); ++SI) {
      // if it's new
      if (!(find(visited.begin(), visited.end(), *SI) != visited.end())) {
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
val_vec getControlDeps(Instruction* ti) {
  val_vec deps;
  int succ_i = 0;
  while (succ_i < ti->getNumSuccessors()) {
    BasicBlock* bb = ti->getSuccessor(succ_i);
    succ_i++;
    for (Instruction& inst : *bb) {
      // if we encounter a store, add to deps
      if (isa<StoreInst>(&inst)) {
        deps.push_back(&inst);
      }  // if we encounter a multi succ branch, recursive call, if we encouter a join, continue to next succ
      else if (inst.isTerminator()) {
        if (ti->getNumSuccessors() > 1) {
          std::vector<Value*> intermed = getControlDeps(&inst);
          for (Value* item : intermed) {
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

// Get direct uses (at src level, not IR) of a fresh var
inst_vec traverseDirectUses(Instruction* root) {
#if DEBUG
  errs() << "=== traverseDirectUses ===\n";
#endif
  inst_vec uses;
  std::queue<Instruction*> localDeps;
#if DEBUG
  errs() << "Add root to localDeps: " << *root << "\n";
#endif
  localDeps.push(root);

  // Edge case: check if return is an internally allocated stack var
  Value* retPtr;
  auto* last = &(root->getFunction()->back().back());
  if (auto* ri = dyn_cast<ReturnInst>(last)) {
    for (auto& op : ri->operands()) {
      if (auto* li = dyn_cast<LoadInst>(op.get())) {
        retPtr = li->getPointerOperand();
#if DEBUG
        errs() << "retPtr: " << *retPtr << "\n";
#endif
      }
    }
  }

  while (!localDeps.empty()) {
    auto* curVal = localDeps.front();
#if DEBUG
    errs() << "[Loop localDeps] Add curVal to uses: " << *curVal << "\n";
#endif
    uses.push_back(curVal);
    localDeps.pop();

#if DEBUG
    errs() << "[Loop localDeps] Go over curVal users\n";
#endif
    for (auto* use : curVal->users()) {
#if DEBUG
      errs() << "[Loop users] use: " << *use << "\n";
#endif
      // If it's a gepi, see if there are others that occur afterwards
      //       errs() << *use <<" is a direct use of " << *currVal<<"\n";
      if (isa<GetElementPtrInst>(use)) {
        auto matching = couldMatchGEPI(dyn_cast<GetElementPtrInst>(use));
        for (auto* item : matching) {
          //  errs() << "pushing to local deps " << *item <<"\n";
          localDeps.push(item);
        }
      } else if (ReturnInst* ri = dyn_cast<ReturnInst>(use)) {
        for (Value* calls : ri->getFunction()->users()) {
          if (isa<CallInst>(calls)) {
            uses.push_back(dyn_cast<Instruction>(calls));
          }
        }
      } else if (StoreInst* si = dyn_cast<StoreInst>(use)) {
#if DEBUG
        errs() << "[Loop users] use = StoreInst\n";
#endif
        // If stores into ret pointer, treat as above
        if (si->getPointerOperand() == retPtr) {
#if DEBUG
          errs() << "[Loop users] ptr operand = retPtr\n";
#endif
          for (Value* calls : si->getFunction()->users()) {
            if (isa<CallInst>(calls)) {
              uses.push_back(dyn_cast<Instruction>(calls));
            }
          }
        }
      } else if (BranchInst* bi = dyn_cast<BranchInst>(use)) {
        // If a use is a branch inst the atomic region needs to
        // dominate the successors
        for (BasicBlock* bbInterior : bi->successors()) {
          // Skip panic blocks, otherwise there will be no post dom
          if (bbInterior->getName().equals("panic")) {
            continue;
          }
          uses.push_back(&(bbInterior->front()));
        }
      } else if (CallInst* ci = dyn_cast<CallInst>(use)) {
#if DEBUG
        errs() << "[Loop users] use = CallInst\n";
#endif
        if (ci->hasName() && ci->getName().startswith("_")) {
          // Fall through
        } else {
#if DEBUG
          errs() << "[Loop users] Add CallInst to uses\n";
#endif
          uses.push_back(ci);
          continue;
        }
      }

      if (auto* iUse = dyn_cast<Instruction>(use)) {
        // See if load is to another var or just internal ssa
        if (auto* li = dyn_cast<LoadInst>(iUse)) {
          if (li->hasName()) {
            // Hacky -- verify that this is always true
            if (!li->getName().startswith("_"))
              continue;
          }
        }

#if DEBUG
        errs() << "[Loop users] Add use to localDeps\n";
#endif
        localDeps.push(iUse);
      }
    }
  }

#if DEBUG
  errs() << "*** traverseDirectUses ***\n";
#endif
  return uses;
}

inst_vec traverseUses(Instruction* root) {
#if DEBUG
  errs() << "=== traverseUses ===\n";
#endif
  auto directUses = traverseDirectUses(root);
  inst_set uses(directUses.begin(), directUses.end());

  for (auto* directUse : directUses) {
#if DEBUG
    errs() << "[directUses] directUse: " << *directUse << "\n";
#endif

    if (auto* si = dyn_cast<StoreInst>(directUse)) {
#if DEBUG
      errs() << "[directUses] directUse = StoreInst\n";
#endif

      auto* ptr = si->getPointerOperand();
#if DEBUG
      errs() << "[directUses] ptr operand: " << *ptr << "\n";
#endif

      for (auto* ptrUse : ptr->users()) {
        if (auto* li = dyn_cast<LoadInst>(ptrUse)) {
#if DEBUG
          errs() << "[ptrUsers] Add ptrUse (LoadInst) to uses: " << *ptrUse << "\n";
#endif
          uses.emplace(li);

          for (auto* liUse : li->users()) {
            if (auto* ci = dyn_cast<CallInst>(liUse)) {
#if DEBUG
              errs() << "[liUsers] Add liUse (CallInst) to uses: " << *liUse << "\n";
#endif
              uses.emplace(ci);
            }
          }
        }
      }
    }
  }

#if DEBUG
  errs() << "=== traverseUses ===\n";
#endif
  inst_vec uses_vec(uses.begin(), uses.end());
  return uses_vec;
}
