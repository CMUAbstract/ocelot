#include "include/AnalyzeRegions.h"
#include "include/BackwardSearcher.h"

//*Change from module to function level in order to be recursive*//
void AnalyzeRegions::runRegionAnalysis(Function* f, int reach, Instruction* reg_start)
{

  //make this a queue of bb, each tagged with whether in an atomic region or not.
  map<BasicBlock*, int> in_region;
  map<BasicBlock*, int> ever_in_region;
  map<BasicBlock*, Instruction*> regStartMap;
  //errs() <<"Starting new func w reach " << reach << "\n";
  if (reg_start!=NULL) {
    //errs() << "and w reg start" << *reg_start<<" \n";
  } else {
    //errs() << "and w NULL reg start\n";
  }
  Function* F = f;
  int reaching_cp = reach;
  bool first = true;
  // Instruction* region_start = NULL;
  if (!F->empty()) {
    map<Instruction*,val_insts_map> Writelist;
    map<Instruction*,val_vec> WARlist;
      // search for WAR
      /*for(Value* nvarg : knownAliases) {
	WARlist.push_back(nvarg);
	}*/
    
      // search for write to nonvolatile, same as in exmwt
    for (auto &B : *F) {
      if (first) {
	in_region[&B] = reaching_cp;
	
	first = false;
      } else {
	in_region[&B] = 0;
	
      }
      regStartMap[&B] = reg_start;
      //errs() << "setting reg from arg\n";
      for(BasicBlock* pred : predecessors(&B)) {
	//  errs () << *pred << "is pred with cp "<< in_region[pred]<<"\n";
	if(in_region[pred] >= in_region[&B]) {
	  in_region[&B] = in_region[pred];
	  
	  if (regStartMap[pred]!=NULL) {
	    regStartMap[&B] = regStartMap[pred];
	    //  errs() << "setting reg from pred " << *pred<<"\n";
	  }
	}
	
      }
      reaching_cp = in_region[&B];
      ever_in_region[&B] = reaching_cp;
#if DEBUG
      if (regStartMap[&B]!=NULL) {
	errs() << "BB  w reg start" << *regStartMap[&B]<<" \n";
      } else {
	errs() << "BB w NULL reg start\n";
      }

      errs() << B <<"\n";
#endif
      //errs() << B <<" with reach "<< in_region[&B] << "\n";
      for (auto &I : B) {
	//	errs () << "inst: " << I <<" reaching cp: " << reaching_cp<<"\n";
	if(reaching_cp!=0) {
	  assert(regStartMap[&B]!=NULL);
	}
	if (isa<StoreInst>(&I)&&reaching_cp) {
	  //errs() << "found a write: "<< I <<"\n";
	  Value* p_op = dyn_cast<StoreInst>(&I)->getPointerOperand();
	  //chase the pointer back, if it's not alloca or arg
	  bool finished = false;
	  while(!finished) {
	    if (emw->is_nonvolatile(p_op, regStartMap[&B], F)) {
	      //errs() << "found an nv write"<< I <<"\n";
	      GlobalVariable* gv = emw->get_backing_static(p_op, regStartMap[&B]);
	      //errs() << "added " << *gv <<"to write list\n";
	      addToWritelist(gv, &I, &Writelist[regStartMap[&B]]);
	    }
	    if (isa<Argument>(p_op)||isa<AllocaInst>(p_op)||!isa<Instruction>(p_op)) {
	      finished = true;
	    } else {
	      if (GetElementPtrInst* gepi = dyn_cast<GetElementPtrInst>(p_op)) {
		p_op = gepi->getPointerOperand();
	      } else if (BitCastInst* bci = dyn_cast<BitCastInst>(p_op)) {
		p_op = bci->getOperand(0);
	      } else if (LoadInst* li = dyn_cast<LoadInst>(p_op)) {
		p_op = li->getPointerOperand();
	      }else {
		//errs () << "Pointer inst " << *p_op << "not dealt with\n";
	      }
	    }
	  }
	}
	else if(CallInst* ci = dyn_cast<CallInst>(&I)) {
	  Function* called = ci->getCalledFunction();
	  if (called != NULL) {
	    //TODO: still relevant?
	    if (isMemcpy(ci)&&reaching_cp) {
	      // memcpy is a write
	      //errs() << "DEBUG: found a memcpy" << I<< "\n";
	      //findWriteToGlobal(ci->getArgOperand(0), &I, &Writelist);
	      //findReadPrecedingWrite(I.getOperand(1), &I, &Writelist, &WARlist);
	      Value* p_op = ci->getOperand(1);
	      bool finished = false;
	      while(!finished) {
		if (emw->is_nonvolatile(p_op, regStartMap[&B], F)) {
		  //errs() << "found an nv write" << I <<"\n";
		  GlobalVariable* gv = emw->get_backing_static(p_op, regStartMap[&B]);
		  //errs() << "added " << *gv <<"to write list\n";
		  addToWritelist(gv, &I, &Writelist[regStartMap[&B]]);
		}
		if (isa<Argument>(p_op)||isa<AllocaInst>(p_op)||!isa<Instruction>(p_op)) {
		  finished = true;
		} else {
		  if (GetElementPtrInst* gepi = dyn_cast<GetElementPtrInst>(p_op)) {
		    p_op = gepi->getPointerOperand();
		  } else if (BitCastInst* bci = dyn_cast<BitCastInst>(p_op)) {
		    p_op = bci->getOperand(0);
		  } else if (LoadInst* li = dyn_cast<LoadInst>(p_op)) {
		    p_op = li->getPointerOperand();
		  } else {
		    errs () << "Pointer inst " << *p_op << "not dealt with\n";
		  }
		}
	      }
	    }
	    else if (called->getName().contains("atomic_start")) {
	      //true start
	      if (reaching_cp==0) {
		regStartMap[&B] = ci;
	      }
	      reaching_cp += 1;
	      in_region[&B] = reaching_cp;
	      ever_in_region[&B] = reaching_cp;
	      //region_start = ci;
	    }
	    else if (called->getName().contains("atomic_end")) {
	      if (reaching_cp == 0) {
		//in_region[&B] = reaching_cp;
		errs() << "ERROR: orphan region end\n";
	      } else { //correct region
		reaching_cp--;
		in_region[&B] = reaching_cp;
		//true end
		
	      }//region well-formed check end
	    } else {
	      //recurse for called WAR, but only if reaching cp is 1, otherwise it will be called top level
	      
	      if(reaching_cp >= 1){
		
		runRegionAnalysis(called, reaching_cp, regStartMap[&B]);
	      }
	    }
	  }//null check for called
	  else {
	    //unknown func in atomic region
	    if(reaching_cp >= 1){
		// if unknown function takes a pointer to a GV, it is added to WAR
	      for (unsigned i = 0; i < ci->getNumArgOperands(); ++i) {
		
		if (emw->is_nonvolatile(ci->getArgOperand(i),regStartMap[&B], F)) {
		  // add to WAR
		  if (std::find(WARlist[regStartMap[&B]].begin(), WARlist[regStartMap[&B]].end(), ci->getArgOperand(i)) == WARlist[regStartMap[&B]].end()) {
		    WARlist[regStartMap[&B]].push_back(ci->getArgOperand(i));
		  }
		}//nv check
		
	      }//num operands
	    }//reaching cp check
	  }//null cf check
	}// call inst
	else if (isa<LoadInst>(&I)&&reaching_cp) {
	  //need to make sure  this handles called functions
	  findReadPrecedingWrite(I.getOperand(0), &I, regStartMap[&B], &Writelist[regStartMap[&B]], &WARlist[regStartMap[&B]]);
	} 
      }
    }


    //now to iterate through loads
    for (auto &B : *F) {
      reaching_cp = ever_in_region[&B];
      for (auto &I : B) {
	//errs () << "inst: " << I <<" reaching cp: " << reaching_cp<<"\n";
	if (isa<LoadInst>(&I)&&reaching_cp) {
	  //need to make sure  this handles called functions
	  findReadPrecedingWrite(I.getOperand(0), &I, regStartMap[&B], &Writelist[regStartMap[&B]], &WARlist[regStartMap[&B]]);
	} 
      }
    }
    // calculate commit size
    for (auto map : WARlist) {
      uint64_t commitSize = calcCommitSize(map.second);
      if (commitSize > maxCommitSize) {
	maxCommitSize = commitSize;
      }
      // save the result
      for (auto item : map.second) {
	//errs() << "pushing war " << *item << "for region " << *map.first<< "\n"; 
	WARinRegion[map.first].push_back(item);
      }
    }
      
  }
}
   
  



uint64_t AnalyzeRegions::calcCommitSize(val_vec WARlist) {
  uint64_t commitSize = 0;
  for (val_vec::iterator VI = WARlist.begin(); 
       VI != WARlist.end(); ++VI) {
    		errs() << "calc commit size! " << *(*VI) << "\n";
		commitSize += getSize(*VI);
  }
  return commitSize;
}

/*TODO: make a backing_global function*/
void AnalyzeRegions::addToWritelist(GlobalVariable* gv,Instruction* I, val_insts_map* Writelist) {
  
  val_insts_map::iterator IT = Writelist->find(gv);
  if (IT != Writelist->end()) {
    // map for GV already exists; append
    inst_vec write_insts = IT->second;
    assert(write_insts.size() != 0);
    write_insts.push_back(I);
    (*Writelist)[gv] = write_insts;
  }
  else {
    // first time writing to GV
    inst_vec write_insts;
    write_insts.push_back(I);
    (*Writelist)[gv] = write_insts;
  }
}
/*First two paras: Load p_op, LoadInst*/
void AnalyzeRegions::findReadPrecedingWrite(Value* v, Instruction* I,  Instruction* reg_start, val_insts_map* Writelist, val_vec* WARlist) {
  bool nv = emw->is_nonvolatile(v, reg_start, I->getFunction());
  //  errs () << "examining load " << *v<<"\n";
  if(nv) {
	  //errs() << "Load was nonvol \n";
    GlobalVariable* gv = emw->get_backing_static(v, reg_start);
    val_insts_map::iterator IT = Writelist->find(gv);
    if (IT != Writelist->end()) {
      // this function wrote to a backing static. Check if Write is after Read
      inst_vec write_insts = IT->second;
      assert(write_insts.size() != 0);
      for (inst_vec::iterator IIT = write_insts.begin(); IIT != write_insts.end(); ++IIT) {
	BackwardSearcher* BS = new BackwardSearcher();
	if (BS->isPreceding(I, (*IIT))) {
	  // if read before write, it is a WAR
	  //errs() << "The load" << *I <<" was in a block preceding a write "<<*(*IIT) <<"\n";
	  //errs() << "Backing static is " << *gv <<"\n";
	  
	  if (!(find(WARlist->begin(), WARlist->end(), gv) != WARlist->end())) {
	    //for (Value* war : WARlist) {
	    //errs() << "This is a WAR: " << *gv << "\n";
	    WARlist->push_back(gv);
	  }
	}
      }
    }
  }
  
}
