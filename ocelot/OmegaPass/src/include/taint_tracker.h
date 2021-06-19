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

using namespace llvm;
using namespace std;



/*Function Declarations*/
void find_tainted(Function* f, int old_in_edge, vector<Value*>* in_edge,
		  vector<Value*>* out_edge, vector<Function*> io_name, AliasAnalysis& aa);
void interproc_flow(Function* f, vector<Value*> *out_dir, map<Function*, vector<Value*>*>* in_dir);
bool precedingWrite(LoadInst* li, vector<Value*> match);
vector<Value*> find_control_dep(Instruction* ti);
vector<Instruction*> scan_io(Function* f, vector<Function*> names);
bool is_io(Instruction* potential, vector<Function*> names);
Value* get_definition(Value* store);
Value* val_from_inst(Instruction* inst);

