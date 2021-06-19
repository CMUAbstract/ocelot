// Adapted from 15-745 S18 Assignment 2: dataflow.h
// Group: milijans, eruppel
////////////////////////////////////////////////////////////////////////////////

#ifndef __CLASSICAL_DATAFLOW_H__
#define __CLASSICAL_DATAFLOW_H__

#include <stdio.h>
#include <iostream>
#include <queue>
#include <vector>
#include <map>

#include "llvm/IR/Instructions.h"
#include "llvm/ADT/BitVector.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/IR/CFG.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AliasSetTracker.h"
#include "llvm/Analysis/CFLSteensAliasAnalysis.h"

using namespace std;


namespace llvm {

  typedef void (*mop_t)(Function* f, vector<Value*>* out_dir, map<Function*, vector<Value*>*>* in_dir);
  typedef void (*tf_t)(Function* f, int old_in, vector<Value*>* in, vector<Value*>* out, 
  vector<Function*> io_name, AliasAnalysis& aa);

// Add definitions (and code, depending on your strategy) for your dataflow
// abstraction here.
  map<Function*, vector<Value*>*> iterate(Module* M, tf_t t_func, mop_t meet_op, map<Function*, vector<Value*>*>* in_dir,
				    map<Function*, vector<Value*>*>* out_dir, vector<Function*> io_name, AliasAnalysis& aa);
	

}

#endif
