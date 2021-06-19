#include "include/global.h"

uint64_t getSize(Value* val){
  //errs() << "Val contained type is sizable: " << val->getType()->getContainedType(0)->isSized() <<"\n";

  if(val->getType()->getContainedType(0)->getTypeID() 
     == Type::ArrayTyID){
    return cast<ArrayType>(val->getType()->getContainedType(0))->getNumElements();
  }
  else if(val->getType()->getContainedType(0)->getTypeID() 
	  == Type::StructTyID){
    return dyn_cast<StructType>(val->getType()->getContainedType(0))->getNumElements();
  } 
  else {
    return 1;
  }
}

bool isTask(Function* F) {
	return F->getName().str().find("task_") != std::string::npos;
}

bool isArray(Value* v) {
  bool ret = (v->getType()->getContainedType(0)->getTypeID() == Type::ArrayTyID);
	return ret;
}

bool isMemcpy(Instruction* I){
	if (CallInst* ci = dyn_cast<CallInst>(I)){
		Function* F = ci->getCalledFunction();
		if (F != NULL){ //func == NULL means it is from gcc built lib function. we never need to apply pass on such
			std::string funcName = F->getName().str();
			if(funcName.find("llvm.memcpy") != std::string::npos){ //this is memcpy. it can be read or write
				return true;
			}
		}
	}
	return false;
}


/*Returns 1 if atomic_start, 2 if atomic_end, and 0 otherwise*/
int is_atomic_boundary(Instruction* i)
{
  if (CallInst* ci = dyn_cast<CallInst>(i)) {
  	Function* func = ci->getCalledFunction();
  	if (func!=NULL) {
      if(func->getName().contains("atomic_start")) {
        return 1;
      } else if(func->getName().contains("atomic_end")) {
        return 2;
      } 
    }
  }
  return 0;
}
