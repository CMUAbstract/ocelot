#ifndef __INFERATOMS__
#define __INFERATOMS__

#include <algorithm>
#include <cstdlib>
#include <iostream>
#include <memory>
#include <string>
#include <vector>

#include "Helpers.h"
#include "InferFreshCons.h"
#include "TaintTracker.h"
#include "llvm/ADT/APInt.h"
#include "llvm/Analysis/PostDominators.h"
#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

struct InferAtomsPass : public PassInfoMixin<InferAtomsPass> {
 public:
  InferAtomsPass() {}
  PreservedAnalyses run(Module& M, ModuleAnalysisManager& AM);

  void getAnnotations(std::map<int, inst_vec>* consVars, inst_vec_vec* freshVars, inst_insts_map inputMap, inst_vec* toDelete);
  inst_vec_vec collectFresh(inst_vec_vec startingPoints, inst_insts_map info);
  std::map<int, inst_vec> collectCons(std::map<int, inst_vec> startingPointa, inst_insts_map inputMap);
  void removeAnnotations(inst_vec* toDelete);
  void setModule(Module* _M) { M = _M; }

 private:
  Module* M;
  Function* atomStart;
  Function* atomEnd;
};

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
      .APIVersion = LLVM_PLUGIN_API_VERSION,
      .PluginName = "Atomic Region Inference Pass",
      .PluginVersion = "v0.1",
      .RegisterPassBuilderCallbacks = [](PassBuilder& PB) {
        PB.registerPipelineStartEPCallback(
            [](ModulePassManager& MPM, OptimizationLevel Level) {
              MPM.addPass(InferAtomsPass());
            });
      }};
}

#endif
