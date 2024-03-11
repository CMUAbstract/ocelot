#ifndef __HELPERS__
#define __HELPERS__

#include <string>

#include "HelperTypes.h"

using namespace llvm;

#define DEBUG 1
#define OPT 1

std::string getSimpleNodeLabel(const Value* Node);
bool isAnnot(const StringRef annotName);
void printInstInsts(const inst_insts_map& iim, bool onlyCalls = false);
void printInsts(const inst_vec& iv);
void printIntInsts(const std::map<int, inst_vec>& iim);
void patchClonedBlock(BasicBlock* block, inst_inst_map clonedInsts);

#endif