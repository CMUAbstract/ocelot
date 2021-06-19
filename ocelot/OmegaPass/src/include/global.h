#ifndef __GLOBAL__
#define __GLOBAL__

#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/ADT/ilist.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/SymbolTableListTraits.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/BasicAliasAnalysis.h"
#include <map>
#include <algorithm>

using namespace llvm; 

typedef std::vector<Value*> val_vec;
typedef std::vector<BasicBlock*> bb_vec;
typedef std::vector<Instruction*> inst_vec;
typedef std::map<Value*, inst_vec> val_insts_map;
typedef std::vector<GlobalVariable*> gv_vec;
typedef std::vector<std::pair<Value*, Instruction*>> val_inst_vec;
typedef std::vector<std::pair<Instruction*, Instruction*>> inst_inst_vec;
typedef std::map<Instruction*, val_vec> inst_vals_map;
typedef std::vector<Function*> func_vec;

extern gv_vec gv_list;

bool isArray(Value* v);
bool isTask(Function* F);
bool isMemcpy(Instruction* I);
uint64_t getSize(Value* val);
int is_atomic_boundary(Instruction* ci);
#define OVERHEAD 0

#endif
