#include "include/InferFreshCons.h"

#include "llvm/Analysis/PostDominators.h"

Instruction* InferFreshCons::insertRegionInst(InsertKind insertKind, Instruction* insertBefore) {
#if DEBUG
  errs() << "=== insertRegionInst ===\n";
#endif
  Instruction* call;
  IRBuilder<> builder(insertBefore);

  if (insertKind == Start) {
#if DEBUG
    errs() << "Insert start before: " << *insertBefore << "\n";
#endif
    call = builder.CreateCall(this->atomStart);
  } else {
#if DEBUG
    errs() << "Insert end before: " << *insertBefore << "\n";
#endif
    call = builder.CreateCall(this->atomEnd);
  }

#if DEBUG
  errs() << "*** insertRegionInst ***\n";
#endif
  return call;
}

// If a direct pred is also a successor, then it's a for loop block
bool InferFreshCons::loopCheck(BasicBlock* B) {
  auto BName = getSimpleNodeLabel(B);

  if (!B->hasNPredecessors(1)) {
    for (auto it = pred_begin(B), et = pred_end(B); it != et; ++it) {
      auto* predecessor = *it;
      auto pname = predecessor->getName().drop_front(2);
      // errs() << "comparing " << pname<< " and " <<bbname <<"\n";
      if (pname.compare_numeric(BName) > 0) {
        //   errs() << "comparison is true\n";
        return true;
      }
    }
  }

  return false;
}

// Find the first block after a for loop
BasicBlock* InferFreshCons::getLoopEnd(BasicBlock* bb) {
  auto* ti = bb->getTerminator();
  auto* end = ti->getSuccessor(0);
  ti = end->getTerminator();
  // errs() << "end is " << end->getName() << "\n";
  // for switch inst, succ 0 is the fall through
  end = ti->getSuccessor(1);
  // errs() << "end is " << end->getName() << "\n";
  return end;
}

// Top level region inference function -- could flatten later
void InferFreshCons::inferConsistent(std::map<int, inst_vec> consSets) {
  // TODO: start with pseudo code structure from design doc
  for (auto [id, set] : consSets) {
#if DEBUG
    errs() << "[InferConsistent] starting set " << id << "\n";
#endif
    addRegion(set, Consistent);
  }
}

// The only difference is outer map vs outer vec
void InferFreshCons::inferFresh(inst_vec_vec freshSets) {
#if DEBUG
  errs() << "=== inferFresh ===\n";
#endif
  // TODO: start with pseudo code structure from design doc
  for (auto freshSet : freshSets) addRegion(freshSet, Fresh);
#if DEBUG
  errs() << "*** inferFresh ***\n";
#endif
}

void InferFreshCons::addRegion(inst_vec targetInsts, RegionKind regionKind) {
#if DEBUG
  errs() << "=== addRegion ===\n";
#endif
  // A map from set item to bb
  std::map<Instruction*, BasicBlock*> targetBlocks;
  // A queue of regions that still need to be processed
  std::queue<std::map<Instruction*, BasicBlock*>> regionsNeeded;

#if DEBUG
  errs() << "Build map from inst to bb\n";
#endif
  for (auto* targetInst : targetInsts)
    targetBlocks[targetInst] = targetInst->getParent();

#if DEBUG
  errs() << "Add map to regionsNeeded\n";
#endif
  regionsNeeded.push(targetBlocks);

  auto* root = m->getFunction("app");

  // Iterate until no more possible regions, then pick the best one
  inst_inst_vec regionsFound;
  while (!regionsNeeded.empty()) {
    // Need to raise all blocks in the map until they are the same
    auto blocks = regionsNeeded.front();
    regionsNeeded.pop();
    // Record which functions have been traveled through
    std::set<Function*> seenFuns;

#if DEBUG
    errs() << "[Loop regionsNeeded] While blocks are in diff functions\n";
#endif
    while (!sameFunction(blocks)) {
      // To think on: does this change?
      auto* goal = findCandidate(blocks, root);
#if DEBUG
      errs() << "[Loop !sameFunction] Go over each targetInst\n";
#endif
      for (auto* targetInst : targetInsts) {
        // not all blocks need to be moved up
        auto* curFun = blocks[targetInst]->getParent();
        seenFuns.insert(curFun);
        if (curFun != goal) {
          // if more than one call:
          // callChain info is already in the starting set
          // so only explore a caller if it's in conSet
          bool first = true;
          for (auto* use : curFun->users()) {
            // if (regionKind == 1) {
            if (!(find(targetInsts.begin(), targetInsts.end(), use) != targetInsts.end()))
              continue;
            // errs() << "Use: "<< *use << " is in call chain\n";
            //}
            auto* inst = dyn_cast<Instruction>(use);
#if DEBUGINFER
            errs() << "DEBUGINFER: examining use: " << *inst << "\n";
#endif
            if (inst == NULL) {
              // errs () << "ERROR: use " << *use << "not an instruction\n";
              break;
            }
            // update the original map
            if (first) {
              blocks[targetInst] = inst->getParent();
              first = false;
            } else {
              // copy the blockmap, update, add to queue
              auto* inst = dyn_cast<Instruction>(use);
              std::map<Instruction*, BasicBlock*> copy;
              for (auto map : blocks) copy[map.first] = map.second;
              copy[targetInst] = inst->getParent();
              regionsNeeded.push(copy);
            }
          }  // end forall uses
        }    // end currFunc check
      }      // end forall items
    }        // end same function check

// Now, all bbs in the map are in the same function, so we can run
// dom or post-dom analysis on that function
#if DEBUG
    errs() << "[Loop regionsNeeded] Start dom tree analysis\n";
#endif

    auto* homeFun = blocks.begin()->second->getParent();
    if (homeFun == nullptr) {
#if DEBUG
      errs() << "[regionsNeeded] No function found\n";
#endif
      continue;
    }
#if DEBUG
    errs() << "[regionsNeeded] Found home fun: " << homeFun->getName() << "\n";
#endif

#if OPT
#if DEBUG
    errs() << "[regionsNeeded] Go over all block insts\n";
#endif
    std::set<BasicBlock*> seenBlocks;
    for (auto& [_, B] : blocks) {
      if (seenBlocks.find(B) == seenBlocks.end()) {
        seenBlocks.emplace(B);

        inst_vec toDelay;
        inst_set toDelete;

        for (auto& I : *B) {
#if DEBUG
          errs() << I << "\n";
#endif
          if (!isa<AllocaInst>(I) && find(targetInsts.begin(), targetInsts.end(), &I) == targetInsts.end()) {
#if DEBUG
            errs() << "Should be delayed\n";
#endif
            Instruction *prev, *clone;

            // Clone each untainted instruction to be inserted to
            // the end of the basic block
            if (isa<BinaryOperator>(I)) {
              if (I.getOpcode() == Instruction::Add)
                clone = BinaryOperator::Create(Instruction::Add, prev, I.getOperand(1));
              else
                clone = I.clone();
            } else if (auto* ci = dyn_cast<CallInst>(&I)) {
              if (prev != nullptr)
                clone = CallInst::Create(ci->getCalledFunction(), prev);
            } else if (auto* si = dyn_cast<StoreInst>(&I)) {
              if (prev != nullptr && find(targetInsts.begin(), targetInsts.end(), prev) == targetInsts.end()) {
                clone = I.clone();
                clone->setOperand(0, prev);
              } else
                clone = I.clone();
            } else
              clone = I.clone();

            // Keep track of the previous instruction to allow LLVM
            // to remap virtual registers (avoiding <badref>'s)
            prev = clone;

            toDelete.emplace(&I);
            toDelay.push_back(clone);
          }
        }

        IRBuilder builder(B);
        // Insert each delayed instruction to the end of the block
        for (auto* d : toDelay) builder.Insert(d);

        auto I = B->begin();
        // Delete their duplicates earlier in the block
        for (; I != B->end();) {
#if DEBUG
          errs() << *I << "\n";
#endif
          if (toDelete.find(&*I) != toDelete.end()) {
#if DEBUG
            errs() << "Delete\n";
#endif
            I = I->eraseFromParent();
          } else
            I++;
        }

#if DEBUG
        errs() << "After: " << *B << "\n";
#endif
      }
    }
#endif

    auto& domTree = FAM->getResult<DominatorTreeAnalysis>(*homeFun);
    // Find the closest point that dominates
    auto* startDom = blocks.begin()->second;
    for (auto& [_, B] : blocks)
      startDom = domTree.findNearestCommonDominator(B, startDom);
#if DEBUG
    errs() << "[Loop regionsNeeded] startDom: " << *startDom << "\n";
#endif

    // TODO: if an inst in the set is in the bb, we can truncate?

#if DEBUG
    errs() << "Start post dom tree analysis\n";
#endif

    // Flip directions for the region end
    auto& postDomTree = FAM->getResult<PostDominatorTreeAnalysis>(*homeFun);
    // Find the closest point that dominates
    auto* endDom = blocks.begin()->second;
    for (auto& [_, block] : blocks) {
#if DEBUGINFER
      if (endDom != nullptr) {
        errs() << "Finding post dom of: " << getSimpleNodeLabel(map.second) << " and " << getSimpleNodeLabel(endDom) << "\n";
      } else {
        errs() << "endDom is null\n";
      }
#endif
      endDom = postDomTree.findNearestCommonDominator(block, endDom);
    }

#if DEBUG
    errs() << "[Loop regionsNeeded] endDom: " << *endDom << "\n";
#endif

    if (startDom == nullptr) {
      errs() << "[Error] Null startDom\n";
    } else if (endDom == nullptr) {
      errs() << "[Error] Null endDom\n";
    }

    // Need to make the start and end dominate each other as well.
    startDom = domTree.findNearestCommonDominator(startDom, endDom);
    endDom = postDomTree.findNearestCommonDominator(startDom, endDom);

#if DEBUG
    errs() << "[Loop regionsNeeded] After matching scope\n";
    errs() << "[Loop regionsNeeded] startDom: " << *startDom << "\n";
    errs() << "[Loop regionsNeeded] endDom: " << *endDom << "\n";
#endif

    // Extra check to disallow loop conditional block as the end
    if (loopCheck(endDom)) {
#if DEBUG
      errs() << "[Loop regionsNeeded] Loop check passed\n";
#endif
      endDom = getLoopEnd(endDom);
    }

    if (startDom == nullptr) {
      errs() << "[Error] Null startDom after scope merge\n";
    } else if (endDom == nullptr) {
      errs() << "[Error] Null endDom after scope merge\n";
    }
#if DEBUG
    errs() << "[Loop regionsNeeded] Insert insts\n";
#endif
    // TODO: fallback if endDom is null? Need hyper-blocks, I think
    // possibly can do a truncation check, to lessen the size a little, but could that interfere with compiler optimizations?
    auto* regionStart = truncate(startDom, true, targetInsts, seenFuns);
    auto* regionEnd = truncate(endDom, false, targetInsts, seenFuns);
    if (regionStart == nullptr) {
      errs() << "[Error] Null startDom after truncation\n";
    } else if (regionEnd == nullptr) {
      errs() << "[Error] Null endDom after truncation\n";
    } else {
      // errs() << "Region start is before " << *regionStart<<" and region end is before " << *regionEnd<<"\n";
    }

#if DEBUG
    errs() << "[Loop regionsNeeded] Add to regionsFound: (" << *regionStart << ", " << *regionEnd << ")\n";
#endif
    // Insert into regionsFound
    regionsFound.emplace_back(regionStart, regionEnd);
  }  // end while regions needed

  // Now see which region is smallest -- instruction count? they must dominate
  // each other, so there's no possibility of not running into the start from
  // the end
  auto [regionStart, regionEnd] = findShortest(regionsFound);
  insertRegionInst(Start, regionStart);
  insertRegionInst(End, regionEnd);
  //}//end while regions needed

#if DEBUG
  errs() << "*** addRegion ***\n";
#endif
}

// Truncate a bb if the instruction is in the bb
Instruction* InferFreshCons::truncate(BasicBlock* B, bool forwards, inst_vec set, std::set<Function*> nested) {
#if DEBUG
  errs() << "=== truncate ===\n";
#endif

#if DEBUG
  errs() << "Set:\n";
  for (auto& inst : set)
    errs() << *inst << "\n";
#endif

  // Truncate the front
  if (forwards) {
#if DEBUG
    errs() << "Truncate startDom\n";
    errs() << "Go over each inst\n";
#endif
    for (auto& I : *B) {
      // Stop at first inst in bb that is in the set.
      if (find(set.begin(), set.end(), &I) != set.end()) {
#if DEBUG
        errs() << "[Loop B] Found first inst also in set: " << I << "\n";
#endif
        return &I;
      }
      // Need to stop at relevant CallInsts as well
      else if (auto* ci = dyn_cast<CallInst>(&I)) {
        if (nested.find(ci->getCalledFunction()) != nested.end())
          return &I;
      }
    }

#if DEBUG
    errs() << "Found no inst, return last inst\n";
#endif
    // Otherwise just return the last inst
    return &B->back();
  }

#if DEBUG
  errs() << "Truncate endDom\n";
  errs() << "Go over each inst in reverse\n";
#endif
  // Reverse directions if not forwards
  Instruction* prev = NULL;
  for (auto I = B->rbegin(), rend = B->rend(); I != rend; I++) {
    auto* inst = &*I;
    if (find(set.begin(), set.end(), inst) != set.end()) {
#if DEBUG
      errs() << "[Loop B] Found last inst also in set: " << *I << "\n";
#endif
      // Need to return the previous inst (next in forwards),
      // as it should be inserted before the returned inst
      if (prev == NULL) {
        // Only happens if use is a ret inst, which is a scope use to make the branching
        // work, not an actual one, so this is safe
        return inst;
      }

#if DEBUG
      errs() << "[Loop B] Return prev inst: " << *prev << "\n";
#endif
      return prev;
    } else if (auto* ci = dyn_cast<CallInst>(inst)) {
      if (nested.find(ci->getCalledFunction()) != nested.end()) {
        return prev;
      }
    }
    prev = inst;
  }

#if DEBUG
  errs() << "*** truncate ***\n";
#endif

#if DEBUG
  errs() << "Found no inst, return first inst\n";
#endif
  // Otherwise just return first inst of the block
  // errs() << "truncate returning " << bb->front() << "\n";
  return &B->front();
}

Function* InferFreshCons::findCandidate(std::map<Instruction*, BasicBlock*> blockMap, Function* root) {
#if DEBUG
  errs() << "== findCandidate ===\n";
#endif
  std::vector<Function*> funList;
  // Add the parents, without duplicates
  for (auto& [_, B] : blockMap) {
    if (!(find(funList.begin(), funList.end(), B->getParent()) != funList.end())) {
#if DEBUG
      errs() << "Add: " << B->getParent()->getName() << "\n";
#endif
      funList.push_back(B->getParent());
    }
  }

  // Easy case: everything is already in the same function
  if (funList.size() == 1) return funList.at(0);

  /* Algo goal: get the deepest function that still calls (or is) all funcs in funcList.
   * Consider: multiple calls? Should be dealt with in the addRegion -- eventually each caller
   * gets its own region
   */
  Function* goal = nullptr;
#if DEBUG
  errs() << "starting from " << root->getName() << "\n";
#endif
  deepCaller(root, funList, &goal);
  if (goal == nullptr) {
    errs() << "ERROR: deepCaller failed\n";
  }

#if DEBUG
  errs() << "*** findCandidate ***\n";
#endif
  return goal;
}

// From a root, returns list of called functions.
std::vector<Function*> InferFreshCons::deepCaller(Function* root, std::vector<Function*>& funList, Function** goal) {
  std::vector<Function*> calledFuncs;
  bool mustIncludeSelf = false;

  for (inst_iterator inst = inst_begin(root), E = inst_end(root); inst != E; ++inst) {
    if (CallInst* ci = dyn_cast<CallInst>(&(*inst))) {
      calledFuncs.push_back(ci->getCalledFunction());
    }
  }
  std::vector<Function*> explorationList;
  for (auto* item : funList) {
    // skip over root or called funcs
    if ((find(calledFuncs.begin(), calledFuncs.end(), item) != calledFuncs.end()) || item == root) {
      if (item == root) {
        mustIncludeSelf = true;
      }
      continue;
    }
    explorationList.push_back(item);
#if DEBUGINFER
    errs() << "need to find " << item->getName() << "\n";
#endif
  }
  // this function is a root of a call tree that calls everything in the func List
  if (explorationList.empty()) {
#if DEBUGINFER
    errs() << "empty list\n";
#endif
    *goal = root;
    return calledFuncs;
  }
  // otherwise recurse
  Function* candidate = nullptr;
  for (Function* called : calledFuncs) {
    std::vector<Function*> partial = deepCaller(called, explorationList, &candidate);
    // if candidate is set, it means called is a root for everything in the explorationList
    if (candidate != nullptr) {
      *goal = candidate;
#if DEBUGINFER
      errs() << "New candidate: " << (*goal)->getName() << "\n";
#endif
    }
    // remove from explorationList, but add to calledFuncs
    for (Function* item : partial) {
      func_vec::iterator place = find(explorationList.begin(), explorationList.end(), item);
      if (place != explorationList.end()) {
        explorationList.erase(place);
      }
      calledFuncs.push_back(item);
    }
  }
  // current point is a root
  if (explorationList.empty()) {
    // not the deepest
    if (candidate != nullptr && !mustIncludeSelf) {
      *goal = candidate;
    } else {
      // is the deepest
      *goal = root;
    }
  }
  return calledFuncs;
}

// Get the min of the max length of each region
inst_inst_pair InferFreshCons::findShortest(inst_inst_vec regionsFound) {
#if DEBUG
  errs() << "=== findShortest ===\n";
#endif
  inst_inst_pair best;
  int shortest = INT32_MAX;

#if DEBUG
  errs() << "Go over regionsFound\n";
#endif
  for (auto& [start, end] : regionsFound) {
    int prefixLength = 0, found = 0;
    auto* startParent = start->getParent();
#if DEBUG
    errs() << "[Loop regionsFound] startParent: " << *startParent << "\n";
    errs() << "Go over startParent insts\n";
#endif
    for (auto& I : *startParent) {
      prefixLength++;
      if (&I == start) break;
    }

    // Get the max length from the bb to the end instruction
    std::vector<BasicBlock*> v;
    int endLength = getSubLength(startParent, end, v);
    // Substract the prefix before the start inst
    endLength -= prefixLength;
#if DEBUG
    errs() << "[Loop regionsFound] Region length " << endLength << "\n";
#endif
    if (endLength < shortest) {
#if DEBUG
      errs() << "[Loop regionsFound] Shortest region: (" << *start << ", " << *end
             << ") at length " << endLength << "\n";
#endif
      shortest = endLength;
      best = std::make_pair(start, end);
    }
  }

#if DEBUG
  errs() << "*** findShortest ***\n";
#endif
  return best;
}

int InferFreshCons::getSubLength(BasicBlock* B, Instruction* end, std::vector<BasicBlock*> visited) {
#if DEBUG
  errs() << "=== getSubLength ===\n";
#endif

  int count = 0, max_ret = 0;
  visited.push_back(B);
#if DEBUG
  errs() << "Go over bb insts\n";
#endif
  for (auto& I : *B) {
    count++;

    if (&I == end) {
#if DEBUG
      errs() << "[Loop I] Cur inst = end, stop\n";
#endif
      return count;
    }

    if (auto* ci = dyn_cast<CallInst>(&I)) {
      auto* cf = ci->getCalledFunction();
      if (!cf->empty() && cf != NULL) {
#if DEBUG
        errs() << "[Loop I] Cur inst = CallInst, calling: " << cf->getName() << "\n";
#endif
        count += cf->getInstructionCount();
      }
    }

    if (I.isTerminator()) {
#if DEBUG
      errs() << "[Loop I] Cur inst = terminator\n";
#endif
      for (int i = 0; i < I.getNumSuccessors(); i++) {
        auto* next = I.getSuccessor(i);
        // already counted -- do something more fancy for loops?
        if (find(visited.begin(), visited.end(), next) != visited.end()) continue;
        int intermed = getSubLength(next, end, visited);
        if (intermed > max_ret) {
          max_ret = intermed;
        }
      }
    }
  }

#if DEBUG
  errs() << "*** getSubLength ***\n";
#endif
  return count + max_ret;
}

bool InferFreshCons::sameFunction(std::map<Instruction*, BasicBlock*> blockMap) {
  auto* BComp = blockMap.begin()->second->getParent();
  for (auto& [_, B] : blockMap)
    if (B->getParent() != BComp) return false;
  return true;
}
