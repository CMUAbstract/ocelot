#include "include/BackwardSearcher.h"

void BackwardSearcher::calculatePossiblePointee(Value* pointer, Instruction* I) {
	// iterate within block
	BasicBlock::iterator BI = BasicBlock::iterator(I);
	BasicBlock* curBlock = I->getParent();
	while(&(*BI) != &curBlock->front()) {
		--BI;
		if (StoreInst* st = dyn_cast<StoreInst>(&(*BI))) {
			if (st->getOperand(1) == pointer) {
				possiblePointees.push_back(std::make_pair(st->getOperand(0), &(*BI)));
			}
		}
	}

	// go to prev block
	for (auto PI = pred_begin(curBlock); PI != pred_end(curBlock); ++PI) {
		// visit only non-visited block
		if(std::find(visitedBB.begin(), visitedBB.end(), *PI) == visitedBB.end()){
			visitedBB.push_back(*PI);
			calculatePossiblePointee(pointer, &(*PI)->back());
		}
	}
}

// returns true if first precede second
bool BackwardSearcher::isPreceding(Instruction* first, Instruction* second) {
	// iterate within block
	BasicBlock::iterator BI = BasicBlock::iterator(second);
	BasicBlock* curBlock = second->getParent();
	while(&(*BI) != &curBlock->front()) {
		--BI;
		//If we see an atomic region start inst, return false
		if (is_atomic_boundary(&(*BI))) {
		  return false;
		}
		if (first == &(*BI)) {
			return true;
		}
	}

	// go to prev block
	for (auto PI = pred_begin(curBlock); PI != pred_end(curBlock); ++PI) {
		// visit only non-visited block
		if(std::find(visitedBB.begin(), visitedBB.end(), *PI) == visitedBB.end()){
			visitedBB.push_back(*PI);
			if (isPreceding(first, &(*PI)->back())) {
				return true;
			}
		}
	}
	return false;
}
