#ifndef __ANALYZE_REGIONS__
#define __ANALYZE_REGIONS__

#include "global.h"
#include "exmwt.h"
using namespace llvm;

struct non_task {
  val_vec usedGlobal;
  std::vector<non_task*> callee;
};

class AnalyzeRegions {
public:
  AnalyzeRegions(Pass* _pass, exmwt* _emw) { 
    pass = _pass; 
    maxCommitSize = 0;
    emw = _emw;
  }
  
  void runRegionAnalysis(Function* f, int reaching_cp, Instruction* start);
  //void runNonTaskAnalysis(Module &M);
  void addToWritelist(GlobalVariable* gv, Instruction* i,  val_insts_map* Writelist);
  void findReadPrecedingWrite(Value* v, Instruction* I, Instruction* reg, val_insts_map* Writelist, val_vec* WARlist);
  //void addWARinNonTask(non_task* curTask, val_vec* WARlist);
  std::map<Instruction*, val_vec> getWARinRegion() {
    return WARinRegion;
  }
  uint64_t calcCommitSize(val_vec WARlist);
  uint64_t getMaxCommitSize() {
    return maxCommitSize;
  }
private:
  uint64_t maxCommitSize;
  exmwt* emw;
  Pass* pass;
  map<Function, val_vec> nvArgs;
  std::map<Instruction*, val_vec> WARinRegion;
  //std::map<Function*, non_task*> WARinNonTask;
  std::vector<non_task*> visitedFunc;
};

#endif
