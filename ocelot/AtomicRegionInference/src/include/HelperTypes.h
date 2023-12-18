#ifndef __HELPERTYPES__
#define __HELPERTYPES__

#include <algorithm>
#include <map>
#include <queue>
#include <set>

#include "llvm/ADT/ilist.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/BasicAliasAnalysis.h"
#include "llvm/Analysis/CallGraph.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/SymbolTableListTraits.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"

#define DEBUG 1

using namespace llvm;

typedef std::vector<Value*> val_vec;
typedef std::vector<BasicBlock*> bb_vec;
typedef std::vector<Instruction*> inst_vec;
typedef std::set<Instruction*> inst_set;
typedef std::map<Value*, inst_vec> val_insts_map;
typedef std::vector<GlobalVariable*> gv_vec;
typedef std::vector<std::pair<Value*, Instruction*>> val_inst_vec;
typedef std::pair<Instruction*, Instruction*> inst_inst_pair;
typedef std::vector<inst_inst_pair> inst_inst_vec;
typedef std::map<Instruction*, val_vec> inst_vals_map;
typedef std::map<Instruction*, inst_set> inst_insts_map;
typedef std::vector<Function*> func_vec;
typedef std::vector<inst_vec> inst_vec_vec;

extern gv_vec gv_list;

#endif
