#include "include/InstrumentRegions.h"

/*Based on Intrumentation of the Alpaca System: https://github.com/CMUAbstract/alpaca-oopsla by Kiwan Maeng*/
namespace {

 // Find closest debug info. Note that LLVM throws fatal error if we don't add debug info
// to call instructions that we insert (if the parent function has debug info).
DebugLoc findClosestDebugLoc(Instruction *instr)
{

  DIScope *scope = instr->getFunction()->getSubprogram();
  Instruction *instrWithDebugLoc = instr;
  while (!instrWithDebugLoc->getDebugLoc() && instrWithDebugLoc->getPrevNode() != NULL)
    instrWithDebugLoc = instrWithDebugLoc->getPrevNode();
  if (instrWithDebugLoc->getDebugLoc()) // if found an instruction with info, use that info
    return DebugLoc(instrWithDebugLoc->getDebugLoc());
  else // use the parent function's info (can't see any better source)
    return DebugLoc::get(instr->getFunction()->getSubprogram()->getLine(), /* col */ 0, scope);
}

} // namespace anon

Instruction* InstrumentRegions::insertLogBackup(Value* oldVal, Value* newVal, Instruction* insertBefore) {
  BitCastInst* oldbc = new BitCastInst(oldVal, Type::getInt8PtrTy(m->getContext()), "", insertBefore);
  BitCastInst* newbc = new BitCastInst(newVal, Type::getInt8PtrTy(m->getContext()), "", insertBefore);	

 //errs() << "finish bitcast inst\n";
  // This part is a hacky way of calculating sizeof()
  std::vector<Value*> arrayRef;
  arrayRef.push_back(ConstantInt::get(Type::getInt16Ty(m->getContext()), 1, false));
  Value* size = GetElementPtrInst::CreateInBounds(Constant::getNullValue(oldVal->getType()), ArrayRef<Value*>(arrayRef), "", insertBefore);
  Value* sizei = CastInst::Create(CastInst::getCastOpcode(size, false, Type::getInt16Ty(m->getContext()),false), size, Type::getInt16Ty(m->getContext()), "", insertBefore);

  //errs() << "finish sizeof\n";
  std::vector<Value*> args;
  args.push_back(oldbc);
  args.push_back(newbc);
  args.push_back(sizei);

//errs() << "push back args\n";
  IRBuilder<> builder(insertBefore);
  //builder.SetCurrentDebugLocation(findClosestDebugLoc(insertBefore));
  auto call = builder.CreateCall(log_backup, args);
 // errs() << "create call\n";

  return oldbc;
}

/*
 * Inserts dynamic privatization code before array read
 * 1) Compare isDirty and numBoots
 * 2) if not same, privatize
 */
/*I is the insert before point*/
void InstrumentRegions::insertDynamicBackup(Instruction* I, Value* orig, Value* priv) {
  // get index of the array getting read
  std::vector<Value*> arrayRef;
  GEPOperator* gep;
  if (!(gep = dyn_cast<GEPOperator>(I))) {
    // hacky temporary bug fix
    gep = cast<GEPOperator>(I->getOperand(1));
  }
  //	auto gep = cast<GEPOperator>(I);
  for (User::op_iterator OI = gep->idx_begin(); OI != gep->idx_end(); ++OI){
    arrayRef.push_back(OI->get());
  }	
  // load correspoinding isDirty Array
  GetElementPtrInst* isDirtyValPtr = GetElementPtrInst::CreateInBounds(m->getNamedGlobal(orig->getName().str()+"_isDirty"), arrayRef, "", I);
  LoadInst* isDirtyVal = new LoadInst(isDirtyValPtr, "", I);	
  
  // load numBoots val
  LoadInst* numBoots = new LoadInst(m->getNamedGlobal("_numBoots"), "", true, I);	

  // check if isDirty == numBoots?				
  ICmpInst* cond = new ICmpInst(I, CmpInst::Predicate::ICMP_NE, isDirtyVal, numBoots);	
  
  // privatization code
  GetElementPtrInst* nonPrivatizedValPtr = GetElementPtrInst::CreateInBounds(orig, arrayRef, "", I);
  LoadInst* nonPrivatizedVal = new LoadInst(nonPrivatizedValPtr, "", I);	
  GetElementPtrInst* privatizedValPtr = GetElementPtrInst::CreateInBounds(priv, arrayRef, "", I);
  StoreInst* str = new StoreInst(nonPrivatizedVal, privatizedValPtr, I);

  // insert backup log
  insertLogBackup(nonPrivatizedValPtr, privatizedValPtr, I); 
  // set isDirty
  StoreInst* storeNumDirtyGv = new StoreInst(numBoots, isDirtyValPtr, I); 
  
  // insert branch
  BasicBlock* curBb = I->getParent();
  BasicBlock* ifFalse = SplitBlock(curBb, I);
  BasicBlock* ifTrue = SplitBlock(curBb, nonPrivatizedValPtr);
  BranchInst* branch = BranchInst::Create(ifTrue, ifFalse, cond);
  ReplaceInstWithInst(curBb->getTerminator(), branch);

}

inst_vec InstrumentRegions::getArrWritePoint(Value* val, Function* F) {
  AliasAnalysis* AAA = &pass->getAnalysis<AAResultsWrapperPass>(*(F)).getAAResults();
  inst_vec writePoint;
  int reaching_cp = 0;
  Instruction* reg_start = NULL;
  for (auto &B : *F) {
    for (auto &I : B) {
      int region_layout = is_atomic_boundary(&I); 
      if (region_layout==2) {
	   //region end, then finish
	    return writePoint;
      } else if (region_layout == 1) {
	reaching_cp = 1;
	reg_start = &I;
      }

      if (reaching_cp==0) {
	//not atomic yet
	continue;
      } 
	  
     
      //only reach here if in atomic region
      if (StoreInst* si = dyn_cast<StoreInst>(&I)) {
	//if nv or alias with our array
	if (emw->is_nonvolatile(si->getPointerOperand(), reg_start, si->getFunction())){
	  if(emw->get_backing_static(si->getPointerOperand(), reg_start)==val) {
	    //	    inst_vec a = CA->alias(I.getOperand(1), cast<GlobalVariable>(val), &I);
	    //assert(a.size() == 1);
	    //TODO: what should this first argument be?
	    //writePoint.push_back(std::make_pair(a.at(0), &I));
	    writePoint.push_back(&I);
	  }
	}
      }
    }
  }
  return writePoint;
}

void InstrumentRegions::backup(Instruction* firstInst, Value* v) {
  Value* orig = new LoadInst(v, "", false, firstInst);
  Value* priv = m->getNamedValue(v->getName().str()+"_bak");
  StoreInst* st = new StoreInst(orig, priv, firstInst);
}

void InstrumentRegions::runTransformation(inst_vals_map WARinRegion) {
  //each map is an atomic_start call inst linked to the vec of WARs
  for (auto map : WARinRegion) {
    val_vec WARs = map.second;

    //get the instruction *after* the atomic_start call inst
    Instruction* insertBefore = (map.first)->getNextNonDebugInstruction();
    
    for (val_vec::iterator VI = WARs.begin(); VI != WARs.end(); ++VI) {
      if (!isArray(*VI)) {
	//add after the atomic_start call inst
	backup(insertBefore, *VI);
	
	// log the backup
	insertLogBackup(*VI, m->getNamedValue((*VI)->getName().str()+"_bak"), insertBefore);
	
      } else {
	//For array, after every write, insert some ops
	GlobalValue* gv_bak = m->getNamedValue((*VI)->getName().str()+"_bak");
	
	inst_vec writePoint = getArrWritePoint(*VI, insertBefore->getFunction());
	for (Instruction* item : writePoint) {
	  insertDynamicBackup(item, *VI, gv_bak);
	}
      }
    }//finish iterating through WARS


    //make a branch guarded by a check that atomic_depth == 0
    // load atomic depth val
    Instruction* newNextInst = (map.first)->getNextNonDebugInstruction();
     LoadInst* atom = new LoadInst(m->getNamedGlobal("atomic_depth"), "", true, newNextInst);	

    // check if atomic depth is equal to 0				
    ICmpInst* cond = new ICmpInst(newNextInst, CmpInst::Predicate::ICMP_EQ, ConstantInt::get(Type::getInt16Ty(m->getContext()), 0, false), atom);	
   
    
    // insert branch
    BasicBlock* curBb = newNextInst->getParent();
    BasicBlock* ifFalse = SplitBlock(curBb, insertBefore);
    BasicBlock* ifTrue = SplitBlock(curBb, newNextInst);
    BranchInst* branch = BranchInst::Create(ifTrue, ifFalse, cond);
    ReplaceInstWithInst(curBb->getTerminator(), branch);

    
  }
}

