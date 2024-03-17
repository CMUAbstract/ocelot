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

  void inferCons(std::map<int, inst_vec> consSets, inst_vec_vec* freshSets, inst_vec* toDeleteAnnots, std::set<CallInst*>* inputInsts);
  void inferFresh(inst_vec_vec freshSets, std::map<int, inst_vec>* consSets, inst_vec* toDeleteAnnots, std::set<CallInst*>* inputInsts);
  void addRegion(inst_vec conSet, inst_vec_vec* other, inst_vec* toDeleteAnnots, std::set<CallInst*>* inputInsts);
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
