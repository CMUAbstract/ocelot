#include "include/ConsistentInference.h"

#define DEBUGINFER 0
//Come back to this. it can crash and if pass not run with debug, shouldn't be needed
#if 0
namespace {

 // Find closest debug info. Note that LLVM throws fatal error if we don't add debug info
// to call instructions that we insert (if the parent function has debug info).
DebugLoc findClosestDebugLoc(Instruction *instr)
{

  DIScope *scope = instr->getFunction()->getSubprogram();
  Instruction *instrWithDebugLoc = instr;
  while (!instrWithDebugLoc->getDebugLoc() && instrWithDebugLoc->getPrevNode() != NULL)
    instrWithDebugLoc = instrWithDebugLoc->getPrevNode();
  if (instrWithDebugLoc->getDebugLoc()) // if found an instruction with info, use that info
    return DebugLoc(instrWithDebugLoc->getDebugLoc());
  else // use the parent function's info (can't see any better source)
    return DebugLoc::get(instr->getFunction()->getSubprogram()->getLine(), /* col */ 0, scope);
}

} // namespace anon
#endif
using namespace std;
using namespace llvm;
Instruction* ConsistentInference::insertRegionInst(int toInsertType, Instruction* insertBefore) {

  Instruction* call;
  IRBuilder<> builder(insertBefore);
  //build and insert a region start inst
  if (toInsertType == 0) {
    //Constant* c = M->getOrInsertFunction("");
    call = builder.CreateCall(atomStart);
    #if DEBUGINFER
    errs() << "create start\n";
    #endif
  } else {
  //build and insert a region start inst
    #if DEBUGINFER
      errs() << "Inserting end at: "<< *insertBefore<<"\n";
    #endif
    call = builder.CreateCall(atomEnd);
    #if DEBUGINFER
    errs() << "create end\n";
    #endif
  }
  return call;
}

//if a direct pred is also a successor, then it's a for loop block
bool ConsistentInference::loopCheck(BasicBlock* bb) {
  StringRef bbname = bb->getName().drop_front(2);
  if (!bb->hasNPredecessors(1)) {
    for (auto it = pred_begin(bb), et = pred_end(bb); it != et; ++it) {
       BasicBlock* predecessor = *it;
       StringRef pname = predecessor->getName().drop_front(2);
      // errs() << "comparing " << pname<< " and " <<bbname <<"\n";
        if (pname.compare_numeric(bbname) > 0) {
       //   errs() << "comparison is true\n";
          return true;
        }
    }
  }
  return false;
}


//find the first block after a for loop
BasicBlock* ConsistentInference::getLoopEnd(BasicBlock* bb) {
  Instruction* ti = bb->getTerminator();
  BasicBlock* end = ti->getSuccessor(0);
  ti = end->getTerminator();
 // errs() << "end is " << end->getName() << "\n";
  //for switch inst, succ 0 is the fall through
  end = ti->getSuccessor(1);
 // errs() << "end is " << end->getName() << "\n";
  return end;
}

/*Top level region inference function -- could flatten later*/
void ConsistentInference::inferConsistent(std::map<int, inst_vec> allSets) 
{
  //TODO: start with pseudo code structure  from design doc
  for( auto map : allSets ) {
    #if DEBUGINFER
    errs() << "DEBUGINFER: starting set " << map.first << "\n";
    #endif
    addRegion(map.second, 0);
  }
  
}

/*The only difference is outer map vs outer vec*/
void ConsistentInference::inferFresh(inst_vec_vec allSets) 
{
  //TODO: start with pseudo code structure  from design doc
  for( auto singleVec : allSets ) {
    addRegion(singleVec, 1);
  }
  
}

//Region type: 0 for Con, 1 for fresh
void ConsistentInference::addRegion(inst_vec conSet, int regionType) 
{
  //construct a map of set item to bb
  map<Instruction*, BasicBlock*> blocks;
  //a queue for regions that still need to be processed 
  queue<map<Instruction*, BasicBlock*>> regionsNeeded;
  
  for(Instruction* item : conSet) {
    blocks[item] = item->getParent();
  }

  regionsNeeded.push(blocks);

  Function* root;
  for (Function& f : *m) {
    if (f.getName().equals("app")) {
      root = &f;
    }
  }
  
  //iterate until no more possible regions
  //THEN pick the best one 
  vector<pair<Instruction*, Instruction*>> regionsFound;
  while (!regionsNeeded.empty()) {
    //need to raise all blocks in the map until 
    //they are the same
    map<Instruction*, BasicBlock*> blockMap = regionsNeeded.front();
    regionsNeeded.pop();
    //record which functions have been travelled through 
    set<Function*> nested; 
    
    while (!sameFunction(blockMap)) {
      //to think on: does this change?
      Function* goal = commonPredecessor(blockMap, root);
      for (Instruction* item : conSet) {
        //not all blocks need to be moved up
        Function* currFunc = blockMap[item]->getParent();
        nested.insert(currFunc);
        if(currFunc!=goal) {
          
          //if more than one call:
          //callChain info is already in the starting set
          //so only explore a caller if it's in conSet
          bool first = true;
          for(User* use : currFunc->users()) {
            //if (regionType == 1) {
              if(! (find(conSet.begin(), conSet.end(), use)!=conSet.end())) {
                continue;
              }
              //errs() << "Use: "<< *use << " is in call chain\n"; 
            //}  
            Instruction* inst = dyn_cast<Instruction>(use);
            #if DEBUGINFER
            errs() << "DEBUGINFER: examining use: "<< *inst<<"\n";
            #endif
            if (inst == NULL) {
              //errs () <<"ERROR: use " << *use << "not an instruction\n";
              break;
            }
            //update the original map
            if (first) {
              blockMap[item] = inst->getParent();
              first = false;
            } else {
              //copy the blockmap, update, add to queue
              Instruction* inst = dyn_cast<Instruction>(use);
              map<Instruction*, BasicBlock*> copy;
              for(auto map : blockMap) {
                copy[map.first] = map.second;
              }
              copy[item] = inst->getParent();
              regionsNeeded.push(copy);
            }
          }//end forall uses
        }//end currFunc check  
      }//end forall items
    }//end same function check
    
  
  
    /**Now, all bb in the map are in the same function, so we can run 
     * dom or post-dom analysis on that function**/
    #if DEBUGINFER
    errs() << "DEBUGINFER: start dom tree analysis\n";
    #endif
    Function* home = blockMap.begin()->second->getParent();
    if(home == nullptr) {
      #if DEBUGINFER
        errs() << "DEBUGINFER: no function found\n";
      #endif
      continue;
    }
    DominatorTree& domTree =  pass->getAnalysis<DominatorTreeWrapperPass>(*home).getDomTree();
    //Find the closest point that dominates 
    BasicBlock* startDom = blockMap.begin()->second;
    for (auto map : blockMap) {
      startDom = domTree.findNearestCommonDominator(map.second, startDom);
    }
    //TODO: if an inst in the set is in the bb, we can truncate?
    #if DEBUGINFER
    errs() << "DEBUGINFER: start post dom tree analysis\n";
    #endif
    //Flip directions for the region end
    PostDominatorTree& postDomTree =  pass->getAnalysis<PostDominatorTreeWrapperPass>(*home).getPostDomTree();
    //Find the closest point that dominates 
    BasicBlock* endDom = blockMap.begin()->second;
    for (auto map : blockMap) {
      #if DEBUGINFER
      if (endDom!=nullptr) {
        errs() << "finding post dom of:" << map.second->getName()<< " and " << endDom->getName()<< "\n"; 
      } else {
        errs() << "endDom is null\n";
      }
      #endif
      endDom = postDomTree.findNearestCommonDominator(map.second, endDom);
    }
    if (startDom==nullptr) {
      errs() << "ERROR: null start\n";
    } else if (endDom==nullptr) {
      errs() << "ERROR: null end\n";
    }
    #if DEBUGINFER
    errs() << "DEBUGINFER: match scope\n";
    #endif
    //need to make the start and end dominate each other as well.
    startDom = domTree.findNearestCommonDominator(startDom, endDom);
    endDom = postDomTree.findNearestCommonDominator(startDom, endDom);

    //extra check to disallow loop conditional block as the end
    if(loopCheck(endDom)) {
      endDom = getLoopEnd(endDom);
    }

    

    if (startDom==nullptr) {
      errs() << "ERROR: null start after scope merge\n";
    } else if (endDom==nullptr) {
      errs() << "ERROR: null end after scope merge\n";
    }
#if DEBUGINFER
    errs() << "DEBUGINFER: insert insts\n";
#endif
    //TODO: fallback if endDom is null? Need hyper-blocks, I think
    //possibly can do a truncation check, to lessen the size a little, but could that interfere with compiler optimizations?
    Instruction* regionStart = truncate(startDom, true, conSet, nested);
    Instruction* regionEnd = truncate(endDom, false, conSet, nested);
     if (regionStart==nullptr) {
      errs() << "ERROR: null start after truncation\n";
    } else if (regionEnd==nullptr) {
      errs() << "ERROR: null end after truncation\n";
    } else {
       //errs() << "Region start is before " << *regionStart<<" and region end is before " << *regionEnd<<"\n";
    }

    //insert into regions found
    regionsFound.push_back(make_pair(regionStart, regionEnd));
  }//end while regions needed

    //now see which region is smallest -- instruction count? they must dominate 
    //each other, so there's no possibility of not running into the start from 
    //the end
    pair<Instruction*, Instruction*> smallestReg = findSmallest(regionsFound);
    //errs() << "Smallest Region was " << *smallestReg.first<< " and " << *smallestReg.second <<"\n";
    Instruction* regionStart = smallestReg.first;
    Instruction* regionEnd = smallestReg.second;
    insertRegionInst(0, regionStart);
    insertRegionInst(1, regionEnd);
  //}//end while regions needed
}

/*Function to truncate a bb if the instruction is in the bb */
Instruction* ConsistentInference::truncate(BasicBlock* bb, bool forwards, inst_vec conSet, set<Function*> nested)
{
  //truncate the front
  if(forwards) {
    for (Instruction& inst : *bb) {
      //stop at first inst in the basic block that is in the set.
      if (find(conSet.begin(), conSet.end(), &inst)!=conSet.end()){
        return &inst;
      }
      //need to stop at relevant callIsnsts as well
      else if (CallInst* ci = dyn_cast<CallInst>(&inst)){
        if (nested.find(ci->getCalledFunction())!=nested.end()) {
          return &inst;
        }
      }

    }
    //otherwise just return the last inst
    return &bb->back();
  } 
  //reverse directions if not forwards
  Instruction* prev = NULL;
  for(BasicBlock::reverse_iterator i = bb->rbegin(), e = bb->rend(); i!=e;++i) {
		Instruction* inst = &*i;
    if (find(conSet.begin(), conSet.end(), inst)!=conSet.end()){
      //need to return the previous inst (next in fowards), as it should be inserted before the returned inst
      
      if (prev == NULL) {
        //only happens if use is a ret inst, which is a scope use to make the branching 
        //work, not an actual one, so this is safe
        return inst;
      } 
      return prev;
    }
    else if (CallInst* ci = dyn_cast<CallInst>(inst)){
      if (nested.find(ci->getCalledFunction())!=nested.end()) {
        return prev;
      }
    }
    prev = inst;
  }
  //otherwise just return first inst of the block
  //errs() << "truncate returning " << bb->front() << "\n";
  return &bb->front();
}


Function* ConsistentInference::commonPredecessor(map<Instruction*, BasicBlock*> blockMap, Function* root)
{
  vector<Function*> funcList;
  //add the parents, without duplicates
  for (auto map : blockMap) {
    if(!(find(funcList.begin(), funcList.end(), map.second->getParent())!=funcList.end())) {
      funcList.push_back(map.second->getParent());
      #if DEBUGINFER
      errs() << "DEBUGINFER: adding: " << map.second->getParent()->getName()<<"\n";
      #endif
    }
  }
  //easy case: everything is already in the same function
  if(funcList.size()==1) {
    return funcList.at(0);
  }
  /* Algo Goal: get the deepest function that still calls (or is) all funcs in funcList.
   * Consider: multiple calls? Should be dealt with in the add region function -- eventually each caller
   * gets its own region
  */
   Function* goal = nullptr;
   //Function* root = m->getFunction("app");
   #if DEBUGINFER
   errs() << "DEBUGINFER: starting from " << root->getName() << "\n";
   #endif
   deepCaller(root, funcList, &goal);
   if(goal == nullptr) {
     errs() << "ERROR: deepCaller failed\n";
   }
   return goal;
}

/*Recursive: from a root, returns list of called funcs. */
vector<Function*> ConsistentInference::deepCaller(Function* root, vector<Function*> funcList, Function** goal)
{
  vector<Function*> calledFuncs;
  bool mustIncludeSelf = false;
  
  for (inst_iterator inst = inst_begin(root), E = inst_end(root); inst != E; ++inst) {
    if(CallInst* ci = dyn_cast<CallInst>(&(*inst))) {
      calledFuncs.push_back(ci->getCalledFunction());
    }
  }
  vector<Function*> explorationList;
  for (Function* item : funcList) {
    
    //skip over root or called funcs
    if ((find(calledFuncs.begin(), calledFuncs.end(), item)!=calledFuncs.end()) || item == root) {
      if (item == root) {
        mustIncludeSelf = true;
      }
      continue;
    }
    explorationList.push_back(item);
    #if DEBUGINFER
    errs() << "need to find " << item->getName() <<"\n";
    #endif
  }
  //this function is a root of a call tree that calls everything in the func List
  if (explorationList.empty()) {
    #if DEBUGINFER
    errs() << "empty list\n";
    #endif
    *goal = root;
    return calledFuncs;
  }
  //otherwise recurse
  Function* candidate = nullptr;
  for (Function* called : calledFuncs) {
    vector<Function*> partial = deepCaller(called, explorationList, &candidate);
    //if candidate is set, it means called is a root for everything in the explorationList
    if (candidate!=nullptr) {
      *goal = candidate;
      #if DEBUGINFER
      errs() << "New candidate: " << (*goal)->getName() << "\n";
      #endif
    }
    //remove from explorationList, but add to calledFuncs
    for (Function* item : partial) {
      func_vec::iterator place = find(explorationList.begin(), explorationList.end(), item);
      if(place!=explorationList.end()) {
        explorationList.erase(place);
      }
      calledFuncs.push_back(item);
    }

  }
  //current point is a root
  if(explorationList.empty()) {
    //not the deepest
    if (candidate!=nullptr && !mustIncludeSelf) {
      *goal = candidate;
    } else {
    //is the deepest  
      *goal = root;
    }
  }
  return calledFuncs;
}




/*Recursive: get the min of the maximum length of each regions*/
inst_inst_pair ConsistentInference::findSmallest(vector<inst_inst_pair>regionsFound)
{
  inst_inst_pair best;
  int best_count = 2147483647;

  for (inst_inst_pair candidate : regionsFound) {
    Function* root = candidate.first->getFunction();
    int pre = 0 ;
    int found = 0;
    for (Instruction& inst : *candidate.first->getParent()) {
      pre++;
      if (&inst==candidate.first) {
        break;
        
      }
    }
    //get the max length from the bb to the end instruction
    vector<BasicBlock*> v;
    int length = getSubLength(candidate.first->getParent(), candidate.second, v);
    //substract the prefix before the start inst
    length -= pre;
    if (length < best_count) {
      best_count = length;
      best = candidate;
      //errs() << "best candidate is " << *candidate.first << " and " <<
      // *candidate.second << " with length " << length << "\n";
    }

  }
  return best;
}
//helper func, recursive
int ConsistentInference::getSubLength(BasicBlock* bb, Instruction* end, vector<BasicBlock*> visited){
  int count = 0;
  int max_ret = 0;
  visited.push_back(bb);
  for (Instruction& inst : *bb) {
    count++;
    if (&inst == end){
      return count;
    }
    if(CallInst* ci = dyn_cast<CallInst>(&inst)){
      Function* cf = ci->getCalledFunction();
      if (!cf->empty() && cf!=NULL) {
        //errs() <<"attempting function " << cf->getName() << "\n";
        count+= cf->getInstructionCount();
      }
    }
    if (inst.isTerminator()) {
      int numS = inst.getNumSuccessors();
      for (int i = 0; i < numS; i++) {
        BasicBlock* next = inst.getSuccessor(i);
        //already counted -- do something more fancy for loops?
        if (find(visited.begin(), visited.end(), next)!=visited.end()) {
          continue;
        }
        int intermed = getSubLength(inst.getSuccessor(i), end, visited);
        if (intermed > max_ret) {
          max_ret = intermed;
        }
      }
    }
  }
  return count + max_ret;
} 

bool ConsistentInference::sameFunction(map<Instruction*, BasicBlock*> blockMap)
{
  Function* comp = blockMap.begin()->second->getParent();
  for (auto map : blockMap) {
    if (map.second->getParent()!= comp) {
      return false;
    }
  }
  return true;
}


