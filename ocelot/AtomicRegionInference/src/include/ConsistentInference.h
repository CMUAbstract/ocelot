#ifndef __CONSISTENTINFERENCE__
#define __CONSISTENTINFERENCE__

#include "HelperTypes.h"
using namespace llvm;
using namespace std;

class ConsistentInference {
public:
  ConsistentInference(Pass* _pass, Module* _m, Function* _as, Function* _ae) { 
    pass = _pass;
    m = _m; 
    atomStart = _as;
    atomEnd = _ae;
  }
  void inferConsistent(map<int, inst_vec> allSets);
  void inferFresh(inst_vec_vec allSets); 
  void addRegion(inst_vec conSet, int regType);
  Function* commonPredecessor(map<Instruction*, BasicBlock*> blocks, Function* root);
  Instruction* insertRegionInst(int regInst, Instruction* insertBefore);
  bool sameFunction(map<Instruction*, BasicBlock*> blockMap);
  Instruction* truncate(BasicBlock* bb, bool forwards, inst_vec conSet, set<Function*> nested);
  vector<Function*> deepCaller(Function* root, vector<Function*> funcList, Function** goal);
  inst_inst_pair findSmallest(vector<inst_inst_pair>regionsFound);
  BasicBlock* getLoopEnd(BasicBlock* bb);
  bool loopCheck(BasicBlock* bb);
  int getSubLength(BasicBlock* bb, Instruction* end, vector<BasicBlock*> visited);



private:
  Pass* pass;
  Module* m;
  Function* atomStart;
  Function* atomEnd;
};

#endif
