#include "include/Helpers.h"

std::string getSimpleNodeLabel(const Value* node) {
  if (node->hasName()) {
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

/**
 * Given a freshly cloned basic block, repair references among its
 * instructions based on a mapping from the original instructions
 * to their clones.
 *
 * @param block The cloned basic block
 * @param clonedInsts The mapping from original to cloned instructions
 */
void patchClonedBlock(BasicBlock* block, inst_inst_map clonedInsts) {
  for (auto& I : *block) {
    if (isa<StoreInst>(I) || isa<CmpInst>(I)) {
      auto* inst = dyn_cast<Instruction>(&I);
      for (int i = 0; i < inst->getNumOperands(); i++) {
        auto* operand = dyn_cast<Instruction>(inst->getOperand(i));
        if (operand != nullptr) {
          inst_inst_map::iterator it = clonedInsts.find(operand);
          if (it != clonedInsts.end()) inst->setOperand(i, it->second);
        }
      }
    } else if (auto* li = dyn_cast<LoadInst>(&I)) {
      auto* ptr = dyn_cast<Instruction>(li->getPointerOperand());
      inst_inst_map::iterator it = clonedInsts.find(ptr);
      if (it != clonedInsts.end()) li->setOperand(0, it->second);
    } else if (auto* bi = dyn_cast<BinaryOperator>(&I)) {
      for (unsigned i = 0; i < bi->getNumOperands(); i++) {
        auto* operand = dyn_cast<Instruction>(bi->getOperand(i));
        inst_inst_map::iterator it = clonedInsts.find(operand);
        if (it != clonedInsts.end()) bi->setOperand(i, it->second);
      }
    } else if (auto* ci = dyn_cast<CallInst>(&I)) {
      // The last operand is the called function
      for (unsigned i = 0; i < ci->getNumOperands() - 1; i++) {
        auto* arg = dyn_cast<Instruction>(ci->getOperand(i));
        inst_inst_map::iterator it = clonedInsts.find(arg);
        if (it != clonedInsts.end()) ci->setOperand(i, it->second);
      }
    } else if (auto* ci = dyn_cast<BranchInst>(&I)) {
      auto* cond = dyn_cast<Instruction>(ci->getOperand(0));
      inst_inst_map::iterator it = clonedInsts.find(cond);
      if (it != clonedInsts.end()) ci->setOperand(0, it->second);
    } else if (auto* ei = dyn_cast<ExtractValueInst>(&I)) {
      auto* operand = dyn_cast<Instruction>(ei->getOperand(0));
      inst_inst_map::iterator it = clonedInsts.find(operand);
      if (it != clonedInsts.end()) ei->setOperand(0, it->second);
    }
  }
}
