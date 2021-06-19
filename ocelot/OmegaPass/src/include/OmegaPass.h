#ifndef __OMEGAPASS__
#define __OMEGAPASS__

#include "AnalyzeRegions.h"
#include "InstrumentRegions.h"
#include "exmwt.h"
#include "global.h"
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

class OmegaModulePass : public ModulePass {
	public:
		static char ID;
		OmegaModulePass() : ModulePass(ID) {}

		virtual bool runOnModule(Module &M);
		void set_ulog();
		void set_my_memset();
		void set_clear_isDirty_function();
		void set_commit_buffer(uint64_t commitSize);
		void declare_globals();
		void declare_priv_buffers(inst_vals_map WARinRegion);

		virtual void getAnalysisUsage(AnalysisUsage& AU) const {
			AU.setPreservesAll();
			AU.addRequired<AAResultsWrapperPass>();
		}
		Module* getModule() {
			return m;
		}
		Module* setModule(Module* _m) {
			return m = _m;
		}
	private:
		Module* m;
		Function* log_backup;
		Function* array_memset;
};

#endif
