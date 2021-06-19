#ifndef __INFERPASS__
#define __INFERPASS__

#include "HelperTypes.h"
#include "ConsistentInference.h"
#include "llvm/ADT/APInt.h"
#include "llvm/IR/Verifier.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/ExecutionEngine/MCJIT.h"
#include "llvm/IR/Argument.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include <algorithm>
#include <cstdlib>
#include <memory>
#include <string>
#include <vector>

using namespace llvm;

class InferAtomicModulePass : public ModulePass {
	public:
		static char ID;
		InferAtomicModulePass() : ModulePass(ID) {}

		virtual bool runOnModule(Module &M);
		int getMaxCost(Function* f);
		void mergeRegions(Function* f);
		void getAnnotations(map<int, inst_vec>* conSets, inst_vec_vec* freshVars, inst_insts_map inputs, inst_vec* toDelete); 
		inst_vec_vec collectFresh(inst_vec_vec startingPoints, inst_insts_map info);
		map<int, inst_vec> collectCon(map<int, inst_vec> startingPointa, inst_insts_map inputMap);
		void removeAnnotations(inst_vec* toDelete); 


		virtual void getAnalysisUsage(AnalysisUsage& AU) const {
			AU.setPreservesAll();
			//AU.addRequired<AAResultsWrapperPass>();
			//AU.addRequired<CallGraphWrapperPass>();
			AU.addRequired<PostDominatorTreeWrapperPass>();
			AU.addRequired<DominatorTreeWrapperPass>();
		}
		Module* getModule() {
			return m;
		}
		Module* setModule(Module* _m) {
			return m = _m;
		}
	private:
		Module* m;
		int capacitorSize;
		Function* atomStart;
		Function* atomEnd;
		
		
};

#endif
