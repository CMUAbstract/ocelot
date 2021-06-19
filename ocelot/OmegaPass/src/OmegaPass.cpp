#include "include/OmegaPass.h"

gv_vec gv_list;

/*only add variables with the .nv_vars section*/
void get_gv_list(Module* m) {
  for (Module::global_iterator GI = m->global_begin(); GI != m->global_end(); ++GI) {
    if ((GI)->getSection().contains(".nv_vars")) {
      gv_list.push_back(&(*GI));
    }
  }
}

void OmegaModulePass::declare_priv_buffers(inst_vals_map WARinFunc) {
  for (inst_vals_map::iterator IIT = WARinFunc.begin(); IIT != WARinFunc.end(); ++IIT) {
    val_vec WARs = (IIT)->second;
    for (val_vec::iterator VIT = WARs.begin(); VIT != WARs.end(); ++VIT) {
      // if _bak not already declared
      //make sure WAR list only has backing statics
      GlobalVariable* gv = cast<GlobalVariable>(*VIT);
      Value* bak = m->getNamedValue(gv->getName().str()+"_bak");
      // if not declared before
      if (bak == NULL){
	// declare bak
	GlobalVariable* priv_buffer = new GlobalVariable(*m, 
							 gv->getType()->getContainedType(0), false, 
							 gv->getLinkage(), 0, gv->getName()+"_bak", gv);
	priv_buffer->copyAttributesFrom(gv);
	priv_buffer->setSection(".nv_vars");
	priv_buffer->setInitializer(gv->getInitializer());	
	// in case of arrays, also init isDirty
	if(isArray(gv)) {
	  GlobalVariable* global_isDirty = new GlobalVariable(*m, 
							      ArrayType::get(Type::getInt16Ty(m->getContext()), 
									     gv->getType()->getContainedType(0)->getArrayNumElements()), 
							      false, gv->getLinkage(), 0, gv->getName()+"_isDirty", gv);
	  global_isDirty->copyAttributesFrom(gv);
	  global_isDirty->setSection(".nv_vars");
	  ConstantAggregateZero* zeroInit = 
	    ConstantAggregateZero::get(global_isDirty->getType()->getContainedType(0));
	  global_isDirty->setInitializer(zeroInit);
	}
      }
    }
  }
}

/*
 * Brief: Top pass for Omega Collection
 */
bool OmegaModulePass::runOnModule(Module &M) {
  m = &M;
  // Declare functions and globals in library for access
  set_ulog();
  set_my_memset();
  declare_globals();
  
  get_gv_list(m);
  //Get ExclusiveMayWrite of Regions.
  exmwt* emw = new exmwt(this, &M);
  inst_vals_map RIOinRegion = emw->getResult();
  //errs() << "Finished getExclusive\n";
  // Analyze tasks
  AnalyzeRegions* ar = new AnalyzeRegions(this, emw);
  //errs() << "Finished AnalyzeRegions\n";
  for (Function& F : M) {
    ar->runRegionAnalysis(&F, 0, NULL); 
  }
  inst_vals_map WARinRegion = ar->getWARinRegion();

  inst_vals_map OMEGAinRegion;

  errs() << "printing OMEGA\n";
  for(auto map : RIOinRegion) {
    for (Value* item : map.second) {
      if (!(find(OMEGAinRegion[map.first].begin(),OMEGAinRegion[map.first].end(),item )!=OMEGAinRegion[map.first].end())) {
        OMEGAinRegion[map.first].push_back(item);
        errs () << *item << "\n";
      }
    }
    
  }

  for(auto map : WARinRegion) {
    for (Value* item : map.second) {
      if (!(find(OMEGAinRegion[map.first].begin(),OMEGAinRegion[map.first].end(),item )!=OMEGAinRegion[map.first].end())) {
        OMEGAinRegion[map.first].push_back(item);
         errs () <<*item << "\n";
      }
    }

  }

  unsigned int max = ar->getMaxCommitSize();
  for(auto map : OMEGAinRegion) {
    uint64_t commitSize = ar->calcCommitSize(map.second);
	  if (commitSize > max) {
		   max = commitSize;
	 }
  }

  
  
  // declare _baks
  declare_priv_buffers(OMEGAinRegion);
  errs() << "Declared baks\n";
  InstrumentRegions* ireg = new InstrumentRegions(this, m, log_backup, emw);
  // Transform tasks and non-tasks
  ireg->runTransformation(OMEGAinRegion);
  errs() << "Ran transformation\n";
  set_commit_buffer(max);
  set_clear_isDirty_function();
   errs() << "Finished clear_isDirty\n";
  return true;
}

void OmegaModulePass::set_commit_buffer(uint64_t commitSize) {
  errs() << "max commit size: " << commitSize << "\n";
  
  // declare commit list 1) priv location list
  GlobalVariable* data_src = new GlobalVariable(*m, 
						ArrayType::get(Type::getInt8PtrTy(m->getContext()), commitSize),
						false, GlobalValue::ExternalLinkage, 0, "data_src",
						m->getNamedGlobal("data_base"));
  data_src->setAlignment(2);
  data_src->setSection(".nv_vars");
  std::vector<Constant*> arr;
  Constant* initData = ConstantArray::get(ArrayType::get(
							 Type::getInt8PtrTy(m->getContext()), commitSize),
					  ArrayRef<Constant*>(arr));
  data_src->setInitializer(initData);
	
// declare commit list 2) orig location list
  GlobalVariable* data_dest = new GlobalVariable(*m,
						 ArrayType::get(Type::getInt8PtrTy(m->getContext()), commitSize),
						 false, GlobalValue::ExternalLinkage, 0, "data_dest",
						 m->getNamedGlobal("data_base"));
  data_dest->setAlignment(2);
  Constant* init_data_dest = ConstantArray::get(ArrayType::get(
							       Type::getInt8PtrTy(m->getContext()), commitSize),
						ArrayRef<Constant*>(arr));
  data_dest->setInitializer(init_data_dest);
  data_dest->setSection(".nv_vars");

// declare commit list 3) buffer size list
  GlobalVariable* data_size = new GlobalVariable(*m,
						 ArrayType::get(Type::getInt16Ty(m->getContext()), commitSize),
						 false, GlobalValue::ExternalLinkage, 0, "data_size",
						 m->getNamedGlobal("data_base"));
  data_size->setAlignment(2);
  Constant* init_data_size = ConstantArray::get(ArrayType::get(
							       Type::getInt16Ty(m->getContext()), commitSize),
						ArrayRef<Constant*>(arr));
  data_size->setInitializer(init_data_size);
  data_size->setSection(".nv_vars");
}

/*
 * Define function clear_isDirty()
 */
void OmegaModulePass::set_clear_isDirty_function() {
  // insert function named clear_isDirty
  Value* c = m->getOrInsertFunction("clear_isDirty",
				       Type::getVoidTy(m->getContext())).getCallee();
  Function* clear_isDirty = cast<Function>(c);
  clear_isDirty->setCallingConv(CallingConv::C);

  // create basic block inside the function
  BasicBlock* block = BasicBlock::Create(m->getContext(),
					 "entry", clear_isDirty);

	// insert memset for every isDirty
  for (gv_vec::iterator GI = gv_list.begin(); GI != gv_list.end(); ++GI){	
    if ((*GI)->getName().str().find("_isDirty") != std::string::npos) {
      // This part is a hacky way of calculating sizeof()
      BitCastInst* arraybc = new BitCastInst(*GI, 
					     Type::getInt8PtrTy(m->getContext()), "", block);
      val_vec arrayRef;
      arrayRef.push_back(ConstantInt::get(
					  Type::getInt16Ty(m->getContext()), 1, false));
      Value* size = GetElementPtrInst::CreateInBounds(
						      Constant::getNullValue((*GI)->getType()), 
						      ArrayRef<Value*>(arrayRef), "", block);
      Value* sizei = CastInst::Create(CastInst::getCastOpcode(size, false, 
							      Type::getInt16Ty(m->getContext()),false), size,
				      Type::getInt16Ty(m->getContext()), "", block);
      
      // insert custom fast memset (because mspgcc memset is slow)
      Value* zero = ConstantInt::get(Type::getInt16Ty(m->getContext()), 0);
      val_vec args;
      args.push_back(arraybc);
      args.push_back(zero);
      args.push_back(sizei);
      CallInst::Create(array_memset, ArrayRef<Value*>(args), "", block);
    }
  }
  // insert return inst
  ReturnInst::Create(m->getContext(), block);
}

/*
 * Declare undo_log function (TODO: this can get inlined)
 */
//todo: make sure this function name still matches the runtime
void OmegaModulePass::set_ulog() {
  Value* fc = m->getOrInsertFunction("log_entry",
			      FunctionType::get(
						Type::getVoidTy(m->getContext()),
						ArrayRef<Type*>({Type::getInt8PtrTy(m->getContext()),
								 Type::getInt8PtrTy(m->getContext()),
								 Type::getInt16Ty(m->getContext())}), false)).getCallee();
  log_backup = cast<Function>(fc);
}

/*
 *	Declare custom memset function
 */


void OmegaModulePass::set_my_memset() {
  Value* fc = m->getOrInsertFunction("my_memset",
				FunctionType::get(
				Type::getVoidTy(m->getContext()),
				ArrayRef<Type*>({Type::getInt8PtrTy(m->getContext()),
								   Type::getInt16Ty(m->getContext()),
								   Type::getInt16Ty(m->getContext())}), false)).getCallee();
  array_memset = cast<Function>(fc);
}

/*
 * Declaring library globals that we will access
 */
void OmegaModulePass::declare_globals() {
  Constant* zeroVal = ConstantInt::get(Type::getInt16Ty(m->getContext()) , 0);

  GlobalVariable* num_dirty_gv = new GlobalVariable(*m, 
				 Type::getInt16Ty(m->getContext()), false, GlobalValue::CommonLinkage, 
						    0, Twine("num_dirty_gv"), 
						    // insert after data_src_base
						    m->getNamedGlobal("data_src_base"), 
						    GlobalValue::ThreadLocalMode::NotThreadLocal, 0, true);
  num_dirty_gv->setInitializer(zeroVal);	

  GlobalVariable* numBoots = new GlobalVariable(*m, 
			Type::getInt16Ty(m->getContext()), false, GlobalValue::CommonLinkage, 
						0, Twine("_numBoots"), 
						// insert after data_src_base
						m->getNamedGlobal("data_src_base"), 
						GlobalValue::ThreadLocalMode::NotThreadLocal, 0, true);
  numBoots->setInitializer(zeroVal); 
}


char OmegaModulePass::ID = 0;

RegisterPass<OmegaModulePass> X("omega", "Omega Pass");
