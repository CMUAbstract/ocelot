#ifndef __INFERFRESHCONS__
#define __INFERFRESHCONS__

#include "Helpers.h"

using namespace llvm;

struct InferFreshCons {
 public:
  InferFreshCons(FunctionAnalysisManager* _FAM, Module* _m, Function* _as, Function* _ae) {
    FAM = _FAM;
    m = _m;
    atomStart = _as;
    atomEnd = _ae;
  }

  enum RegionKind { Fresh,
                    Consistent };

  enum InsertKind { Start,
                    End };

  void inferConsistent(std::map<int, inst_vec> allSets);
  void inferFresh(inst_vec_vec allSets);
  void addRegion(inst_vec conSet, RegionKind regionKind);
  Function* findCandidate(std::map<Instruction*, BasicBlock*> blocks, Function* root);
  Instruction* insertRegionInst(InsertKind insertKind, Instruction* insertBefore);
  bool sameFunction(std::map<Instruction*, BasicBlock*> blockMap);
  Instruction* truncate(BasicBlock* bb, bool forwards, inst_vec conSet, std::set<Function*> nested);
  std::vector<Function*> deepCaller(Function* root, std::vector<Function*>& funcList, Function** goal);
  inst_inst_pair findShortest(inst_inst_vec regionsFound);
  BasicBlock* getLoopEnd(BasicBlock* bb);
  bool loopCheck(BasicBlock* bb);
  int getSubLength(BasicBlock* bb, Instruction* end, std::vector<BasicBlock*> visited);

 private:
  FunctionAnalysisManager* FAM;
  Module* m;
  Function* atomStart;
  Function* atomEnd;
};

#endif
