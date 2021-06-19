#include "llvm/Pass.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AliasSetTracker.h"
#include "llvm/Analysis/CFLSteensAliasAnalysis.h"
#include "llvm/Analysis/MemoryLocation.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include <stack>
#include <algorithm>
#include <vector>
#include <map>
#include <queue>
#include <set>
#include <fstream>
#include "HelperTypes.h"

using namespace llvm;
using namespace std;


inst_insts_map buildInputs(Module* m);
val_vec traverseLocal(Value* tainted, Instruction* srcOp, inst_insts_map* buildMap, Instruction* caller);

inst_vec findInputInsts(Module* M);  
Instruction* ptrAfterCall(Value* ptr, CallInst* ci); 
bool storePrecedesUse(Instruction* use, StoreInst* toMatch);
inst_vec couldMatchGEPI(GetElementPtrInst* tGEPI);
val_vec getControlDeps(Instruction* ti);
inst_vec traverseDirectUses(Instruction* root);
