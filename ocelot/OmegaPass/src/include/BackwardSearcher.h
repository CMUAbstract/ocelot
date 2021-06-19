#ifndef __BACKSEARCH__
#define __BACKSEARCH__

#include "global.h"

class BackwardSearcher {
	public:
		void calculatePossiblePointee(Value* pointer, Instruction* I);	
		bool isPreceding(Instruction* first, Instruction* second);
		val_inst_vec* getPossiblePointees() {
			return &possiblePointees;
		}
	private:
		bb_vec visitedBB;
		val_inst_vec possiblePointees;
};

#endif
