#ifndef __EXMWT__
#define __EXMWT__
#include "llvm/Pass.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AliasSetTracker.h"
#include "llvm/Analysis/CFLSteensAliasAnalysis.h"
#include "llvm/Analysis/MemoryLocation.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/Metadata.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include <stack>
#include <algorithm>
#include <vector>
#include <map>
#include <queue>
#include <set>
#include <fstream>
#include <limits>
#include <chrono>

using namespace llvm;
using namespace std;

struct xm_pair {
  set<Value*> exset;
  set<Value*> mset;
};

class exmwt {
    public:
    
    
    //static char ID;
    ///exmwt() : ModulePass(ID){}
    exmwt(Pass* _pass, Module* mod) {
      M = mod;
      pass = _pass;
    }

    //instance vars
    map<Instruction*, vector<Value*>> res;

    GlobalVariable* get_backing_static(Value* p_op, Instruction* region_start);
    
    bool is_nonvolatile(Value* p_op, Instruction* reg_start, Function* f);
    
    
    map<Instruction*, vector<Value*>> getResult() {
      using namespace chrono;
      high_resolution_clock::time_point curr_time, run_time, total_time;
      duration<double> total_span, run_span; 
      curr_time = high_resolution_clock::now();
      //note: llvm documentation on how to get the aa results is quite out of date
      Function* func = dyn_cast<Function>(M->begin());
      //is it correct to just call it on one function? unclear
      AliasAnalysis &aa = pass->getAnalysis<AAResultsWrapperPass>(*func).getAAResults();
      
      res = search_functions(*M, aa);
      //for alpaca, we only care about globals
      errs() << "starting to print\n";
      for (auto mapping : RIOinRegion) {
	errs() << "in print loop\n";
	errs() << "RegionStart: "<< *mapping.first<< "\n";
	for (Value* item : mapping.second) {
	  //todo: deleted items are causing nullptr, find a way to resize obj
	  if(item == nullptr) {
	    continue;
	  }
	  errs() << *item << "\n";
	}
      }
      run_time = high_resolution_clock::now();
      run_span = duration_cast<duration<double>>(run_time - curr_time);
     
      
      errs() << "Runtime: " << run_span.count() << "\n";
      return res;
    }

    /*
    virtual void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.addRequired<AAResultsWrapperPass>();
   }*/
   private:

    
    /*Functions go here*/
    map<Instruction*, vector<Value*>> search_functions(Module &M, AliasAnalysis &aa);
    map<Function*, vector<Instruction*>> get_func_wr_sets(Module &M); 
    struct xm_pair find_exclusive(BasicBlock* start_point, map<Function*,vector<Value*>*> taint_list, vector<BasicBlock*> visit, int reaching_cp, Instruction* start);
    void union_of(vector<Value*> combo, set<Value*>* orig);
    void union_of(set<Value*> combo, set<Value*>* orig);
    
    void intersect(set<Value*> combo, set<Value*>* orig);
    Value* get_definition(Value* store);
    bool compare_values(Value* wrtset, Value* filtered);
    Value* val_from_inst(Instruction* inst);
    int filter_global(Value* glob, Function* func);
    

    map<Instruction*, vector<Value*>> nv_in_region;
    map<GlobalVariable*, vector<Value*>> gv_aliases;
    map<Instruction*, vector<GlobalVariable*>> backing_statics;
    map<Instruction*, vector<Value*>> RIOinRegion;
    /* Any instance variables*/
    
    Module* M;
    Pass* pass;

};//end class
 
#endif

