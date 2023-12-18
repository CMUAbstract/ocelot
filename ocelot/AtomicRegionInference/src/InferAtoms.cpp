#include "include/InferAtoms.h"

#define CAPSIZE 1000

// Top-level pass for atomic region inference
PreservedAnalyses InferAtomsPass::run(Module& M, ModuleAnalysisManager& AM) {
  PassBuilder PB;
  FunctionAnalysisManager FAM;
  PB.registerFunctionAnalyses(FAM);

  setModule(&M);

  for (auto& F : M) {
    auto FName = F.getName();
    if (FName.equals("atomic_start")) {
#if DEBUG
      errs() << "Found atomic_start\n";
#endif
      atomStart = &F;
    } else if (FName.equals("atomic_end")) {
#if DEBUG
      errs() << "Found atomic_end\n";
#endif
      atomEnd = &F;
    }
  }

  // Build the consistent set and fresh lists here,
  // to only go through all the declarations once.
  std::map<int, inst_vec> consVars;
  inst_vec_vec freshVars;
  inst_insts_map inputMap = buildInputs(this->M);
  inst_vec toDelete;
  getAnnotations(&consVars, &freshVars, inputMap, &toDelete);
  // TODO: need to add unique point of call chain prefix to cons set

#if DEBUG
  errs() << "Initial Fresh:\n";
  for (auto& insts : freshVars)
    for (auto* inst : insts) errs() << *inst << "\n";
#endif

#if DEBUG
  errs() << "Initial Consistent:\n";
  for (auto& [_, insts] : consVars) {
    for (auto* inst : insts) errs() << *inst << "\n";
  }
#endif

#if DEBUG
  errs() << "Print inputMap CallInst entries:\n";
  printInstInsts(inputMap, true);
#endif

  auto allConsSets = collectCons(consVars, inputMap);
  auto allFresh = collectFresh(freshVars, inputMap);

#if DEBUG
  errs() << "Fresh after collect: \n";
  for (auto& varSet : allFresh)
    for (auto* var : varSet) errs() << *var << "\n";
#endif

#if DEBUG
  errs() << "Consistent after collect: \n";
  for (auto& [_, insts] : allConsSets)
    for (auto* inst : insts) errs() << *inst << "\n";
#endif

  // Consistent first
  InferFreshCons* ci = new InferFreshCons(&FAM, &M, atomStart, atomEnd);

  ci->inferConsistent(allConsSets);
  ci->inferFresh(allFresh);

  // Delete annotations
  removeAnnotations(&toDelete);

  return PreservedAnalyses::none();
}

// This function finds annotated variables
void InferAtomsPass::getAnnotations(std::map<int, inst_vec>* consVars, inst_vec_vec* freshVars,
                                    inst_insts_map inputMap, inst_vec* toDelete) {
#if DEBUG
  errs() << "=== getAnnotations ===\n";
#endif
  for (auto& F : *this->M) {
    for (auto& B : F) {
      for (auto& I : B) {
        if (auto* ci = dyn_cast<CallInst>(&I)) {
#if DEBUG
          errs() << "[Loop Inst] cur inst = CallInst\n";
#endif
          auto* fun = ci->getCalledFunction();
          // Various empty or null checks
          if (fun == NULL || fun->empty() || !fun->hasName()) continue;
          // Consistent and FreshConsistent
          if (isAnnot(fun->getName()) && !fun->getName().equals("Fresh")) {
#if DEBUG
            errs() << "[Loop Inst] Calls Consistent/FreshConsistent\n";
#endif
            toDelete->push_back(ci);
            // First para is var, second is id
            int setID;
            // Bit cast use of x, then value operand of store
            Instruction* var = dyn_cast<Instruction>(ci->getOperand(0));

            if (var == NULL) continue;
            // errs() << "New consistent annot. with " << *var<<"\n";
            Value* id = ci->getOperand(1);
            if (ConstantInt* cint = dyn_cast<ConstantInt>(id)) {
              setID = cint->getSExtValue();
            }
            std::queue<Value*> customUsers;
            std::set<Instruction*> v;
            // v.emplace(ci);
            // in case var itself is iOp
            for (Instruction* iOp : inputMap[var]) {
              v.emplace(iOp);
            }

            // customUsers.push(var);
            for (Value* use : var->users()) {
              // don't push the annotation
              if (use == ci) {
                continue;
              }
              // errs() << "DEBUG: pushing use of var: " << *use << "\n";
              customUsers.push(use);
            }
            while (!customUsers.empty()) {
              Value* use = customUsers.front();
              customUsers.pop();
              // errs() << "DEBUG: use is " << *use << " of var " << *var<<"\n";
              if (Instruction* instUse = dyn_cast<Instruction>(use)) {
                for (Instruction* iOp : inputMap[instUse]) {
                  v.emplace(iOp);
                  //  errs() << "DEBUG: adding to v  " << *iOp << "\n";
                }
              }
              if (isa<BitCastInst>(use) || isa<ZExtInst>(use)) {
                for (Value* use2 : use->users()) {
                  // errs() << "DEBUG: use2 is " << *use2 << "\n";
                  if (StoreInst* si = dyn_cast<StoreInst>(use2)) {
                    for (Instruction* iOp : inputMap[si]) {
                      v.emplace(iOp);
                      //    errs() << "DEBUG: adding to v  " << *iOp << "\n";
                    }
                  }
                  //  errs() << "DEBUG: pushing use2 of var: " << *use2 << "\n";
                  customUsers.push(use2);
                }
              }

              if (isa<GetElementPtrInst>(use)) {
                for (Value* use2 : use->users()) {
                  //    errs() << "DEBUG: use2 is " << *use2 << "\n";
                  if (StoreInst* si = dyn_cast<StoreInst>(use2)) {
                    // v.push_back(si);
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
            // last case
            if (v.empty()) {
              // some entries have a first link with ci, not var

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
            // for later deletion purposes
            inputMap.erase(ci);

            if (!v.empty()) {
              inst_vec temp;
              for (Instruction* item : v) {
                temp.push_back(item);
              }
              // add the collected list to the map
              if (consVars->find(setID) != consVars->end()) {
                consVars->at(setID).insert(consVars->at(setID).end(), temp.begin(), temp.end());
              } else {
                consVars->emplace(setID, temp);
              }
            }
          } else if (fun->getName().equals("Fresh")) {
#if DEBUG
            errs() << "[Loop Inst] Calls Fresh\n";
#endif
            std::set<Instruction*> v;
            toDelete->push_back(ci);

#if DEBUG
            errs() << "[Loop Inst] Print inputMap entries:\n";
            printInstInsts(inputMap);
#endif

            //* Can't actually remove, otherwise wrong result
            // #if DEBUG
            //             errs() << "[Loop Inst] Remove Fresh call from inputMap\n";
            // #endif
            //             inputMap.erase(ci);

            auto* arg = ci->getOperand(0);
#if DEBUG
            errs() << "[Loop Inst] Fresh arg: " << *arg << "\n";
#endif

            if (auto* inst = dyn_cast<Instruction>(arg)) {
#if DEBUG
              errs() << "[Loop Inst] arg = Instruction, add to v\n";
#endif
              v.emplace(inst);

              //* Actually collect all uses (e.g., log(x))
              if (auto* li = dyn_cast<LoadInst>(inst)) {
#if DEBUG
                errs() << "[Loop Inst] Further arg = LoadInst\n";
#endif
                auto* ptr = li->getPointerOperand();
#if DEBUG
                errs() << "[Loop Inst] Ptr operand: " << *ptr << "\n";
#endif
                for (auto* ptrUse : ptr->users()) {
#if DEBUG
                  errs() << "[Loop ptr users] ptrUse: " << *ptrUse << "\n";
#endif
                  if (ptrUse != inst) {
                    if (auto* liUse = dyn_cast<LoadInst>(ptrUse)) {
                      errs() << "[Loop ptr users] ptrUse diff from Fresh arg, add to v\n";
                      v.emplace(liUse);
                    }
                  }
                }
              }
            } else {
              // errs() << "error casting\n";
            }
            // errs() << "New Fresh annot. with " << *var<<"\n";
            // v.push_back(ci);

#if DEBUG
            errs() << "[Loop Inst] Go over arg users\n";
#endif
            for (auto* use : arg->users()) {
              if (auto* si = dyn_cast<StoreInst>(use)) {
#if DEBUG
                errs() << "[Loop Users] use = StoreInst, add to v: " << *si << "\n";
#endif
                v.emplace(si);
              } else if (isa<GetElementPtrInst>(use)) {
                for (auto* use2 : use->users()) {
                  if (auto* si = dyn_cast<StoreInst>(use2)) {
                    v.emplace(si);
                  }
                }
              }
            }

            if (!v.empty()) {
#if DEBUG
              errs() << "[Loop Inst] Add v's insts to a set in freshVars:\n";
#endif
              inst_vec tmp;
              for (auto* inst : v) {
#if DEBUG
                errs() << "[Loop v] " << *inst << "\n";
#endif
                tmp.push_back(inst);
              }
              freshVars->push_back(tmp);
            }
          }
        }
      }
    }
  }

#if DEBUG
  errs() << "*** getAnnotations ***\n";
#endif
}

void InferAtomsPass::removeAnnotations(inst_vec* toDelete) {
  std::vector<Function*> toDeleteF;

  // Delete all annotation function calls
  for (auto& F : *this->M) {
    if (F.hasName() && isAnnot(F.getName()))
      toDeleteF.push_back(&F);
    else
      for (auto& B : F) {
        auto I = B.begin();
        for (; I != B.end(); I++) {
          if (auto* ci = dyn_cast<CallInst>(I)) {
            // TODO: no need to confirm in toDelete?
            if (std::find(toDelete->begin(), toDelete->end(), &*I) != toDelete->end()) {
#if DEBUG
              errs() << "Remove call: " << *I << "\n";
#endif
              I->replaceAllUsesWith(UndefValue::get(I->getType()));
              I = I->eraseFromParent();

              //* Remove args and their uses as well
              for (auto& arg : ci->args()) {
                if (auto* argInst = dyn_cast<Instruction>(arg)) {
#if DEBUG
                  errs() << "Remove call arg: " << *argInst << "\n";
#endif
                  argInst->eraseFromParent();
                  argInst->replaceAllUsesWith(UndefValue::get(argInst->getType()));
                }
              }
            }
          }
        }
      }
  }

  // Delete all annotation function defs
  for (auto F : toDeleteF) {
#if DEBUG
    errs() << "Remove function " << F->getName() << "\n";
#endif
    F->replaceAllUsesWith(UndefValue::get(F->getType()));
    F->eraseFromParent();
  }
}

/*Given the starting point annotations of conSets, find the
deepest unique point of the call chain*/
std::map<int, inst_vec> InferAtomsPass::collectCons(std::map<int, inst_vec> startingPoints, inst_insts_map inputMap) {
  std::map<int, inst_vec> toReturn;
  for (std::pair<int, inst_vec> iv : startingPoints) {
    std::set<Instruction*> unique;
    std::map<Instruction*, std::set<Instruction*>> callChains;
    // each item should be the starting point from a different annot
    for (Instruction* item : iv.second) {
#if DEBUG
      errs() << "Starting point: " << *item << "\n";
#endif
      // add self to call chain
      callChains[item].insert(item);

      for (Instruction* iOp : inputMap[item]) {
        //    unique.insert(iOp);
        callChains[item].insert(iOp);
        std::queue<Instruction*> toExplore;
        toExplore.push(iOp);
        while (!toExplore.empty()) {
          Instruction* curr = toExplore.front();
          toExplore.pop();
          for (Instruction* intermed : inputMap[curr]) {
            if (!(find(callChains[item].begin(), callChains[item].end(), intermed) != callChains[item].end())) {
              callChains[item].insert(intermed);
              toExplore.push(intermed);
            }
          }
        }

      }  // finish constructing call chain for one annot. in the set

    }  // constructed call chains for ALL annot. in the set.
    // now check the call chain

    // int index = 0;
    // map<Instruction*,bool> foundUniquePoint;
    // clean up the call chains

    for (auto ccmap : callChains) {
      for (Instruction* possibility : ccmap.second) {
        // if the link is in the same function, then continue
        // errs() << "examining possibility: " << *possibility << "\n";
        bool sf = false;
        for (Instruction* link : inputMap[possibility]) {
          // errs() << "next link is" << *link << "\n";
          if ((link != possibility) && link->getFunction() == possibility->getFunction()) {
            sf = true;
          }
        }
        if (sf) {
          continue;
        }
        bool isUnique = true;
        for (auto ccmapNest : callChains) {
          // if self then skip
          if (ccmapNest == ccmap) {
            continue;
          }
          // otherwise check if this map also contains the possibility
          if (find(ccmapNest.second.begin(), ccmapNest.second.end(), possibility) != ccmapNest.second.end()) {
            isUnique = false;
            break;
          }
        }
        if (isUnique) {
          unique.insert(possibility);
          //  errs() << "Found unique!" << *possibility << "\n";
        } else {
          // try another poss.
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
  }  // end starting point check

  return toReturn;
}

// Collects the source inputs and uses of Fresh-annotated vars
inst_vec_vec InferAtomsPass::collectFresh(inst_vec_vec freshVars, inst_insts_map inputMap) {
#if DEBUG
  errs() << "=== collectFresh ===\n";
#endif
  inst_vec_vec toReturn;

#if DEBUG
  errs() << "Go over fresh var sets\n";
#endif
  for (auto varSet : freshVars) {
#if DEBUG
    errs() << "[Loop freshVars] Go over varSet:\n";
    printInsts(varSet);
#endif
    inst_set unique, callChain;
    for (auto* var : varSet) {
#if DEBUG
      errs() << "[Loop varSet] Cur var: " << *var << "\n";
#endif
      // Uses (forwards) are direct only (might need a little chaining for direct in rs to be direct in IR)
      inst_vec uses = traverseUses(var);

#if DEBUG
      errs() << "[Loop varSet] Go over uses of var\n";
#endif
      for (auto* use : uses) {
#if DEBUG
        errs() << "[Loop uses] Add use: " << *use << "\n";
#endif
        unique.insert(use);

        for (auto* input : inputMap[use]) {
#if DEBUG
          errs() << "[Loop inputMap[use]] Add src input of use to unique: " << *input << "\n";
#endif
          unique.insert(input);
        }
      }

#if DEBUG
      errs() << "[Loop varSet] Go over src inputs of var\n";
#endif
      for (auto* input : inputMap[var]) {
#if DEBUG
        errs() << "[Loop inputMap[var]] Cur src input: " << *input << "\n";
#endif
        unique.insert(input);
        callChain.insert(input);
        std::queue<Instruction*> toExplore;
        toExplore.push(input);
        while (!toExplore.empty()) {
          Instruction* curr = toExplore.front();
          toExplore.pop();
          for (Instruction* intermed : inputMap[curr]) {
            if (!(find(callChain.begin(), callChain.end(), intermed) != callChain.end())) {
              callChain.insert(intermed);
              toExplore.push(intermed);
            }
          }
        }
      }

      // Add the var itself
      if (isa<StoreInst>(var) || isa<CallInst>(var)) {
#if DEBUG
        errs() << "[Loop varSet] Cur var = StoreInst/CallInst, add to unique\n";
#endif
        unique.insert(var);
      }
    }
    // Now construct the call chain
    for (auto* vv : callChain) {
      unique.insert(vv);
    }
    inst_vec v;
#if DEBUG
    errs() << "[Loop freshVars] Go over unique\n";
#endif
    for (auto* inst : unique) {
      if (!isa<AllocaInst>(inst)) {
#if DEBUG
        errs() << "[Loop unique] Cur inst != AllocaInst, add to v: " << *inst << "\n";
#endif
        v.push_back(inst);
      }
    }

#if DEBUG
    errs() << "[Loop FreshVars] Add v to toReturn\n";
#endif
    toReturn.push_back(v);
  }

#if DEBUG
  errs() << "*** collectFresh ***\n";
#endif
  return toReturn;
}
