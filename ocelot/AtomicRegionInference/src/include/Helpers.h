#ifndef __HELPERS__
#define __HELPERS__

#include <string>

#include "HelperTypes.h"

using namespace llvm;

std::string getSimpleNodeLabel(const Value* Node);
bool isAnnot(const StringRef annotName);
void printInstInsts(const inst_insts_map& iim, bool onlyCalls = false);
void printInsts(const inst_vec& iv);

#endif