#include "include/Helpers.h"

std::string getSimpleNodeLabel(const Value* node) {
  if (node->hasName()) {
    // #if DEBUG
    //     errs() << "Node has name\n";
    // #endif
    return node->getName().str();
  }

  std::string str;
  raw_string_ostream OS(str);

  node->printAsOperand(OS, false);
  return str;
}

bool isAnnot(const StringRef annotName) {
  return annotName.equals("Fresh") || annotName.equals("Consistent") || annotName.equals("FreshConsistent");
}

void printInstInsts(const inst_insts_map& iim, bool onlyCalls) {
  for (auto& [inst, inputs] : iim) {
    if (!onlyCalls || isa<CallInst>(inst)) {
      errs() << *inst << " ->\n";
      for (auto* input : inputs) errs() << *input << "\n";
      errs() << "\n";
    }
  }
}

void printInsts(const inst_vec& iv) {
  for (auto& inst : iv) {
    errs() << *inst << "\n";
  }
}

void printIntInsts(const std::map<int, inst_vec>& iim) {
  for (auto& [id, insts] : iim) {
    errs() << id << " ->\n";
    printInsts(insts);
    errs() << "\n";
  }
}
