#ifndef __TAINTTRACKER__
#define __TAINTTRACKER__

#include "Helpers.h"

using namespace llvm;

inst_insts_map buildInputs(Module* m);
val_vec traverseLocal(Value* tainted, Instruction* srcOp, inst_insts_map* buildMap, Instruction* caller);
inst_vec findInputInsts(Module* M);
Instruction* ptrAfterCall(Value* ptr, CallInst* ci);
bool storePrecedesUse(Instruction* use, StoreInst* toMatch);
inst_vec couldMatchGEPI(GetElementPtrInst* tGEPI);
val_vec getControlDeps(Instruction* ti);
inst_vec traverseDirectUses(Instruction* root);
inst_vec traverseUses(Instruction* root);

#endif
