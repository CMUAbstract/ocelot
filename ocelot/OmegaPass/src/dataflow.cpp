// Adapted from 15-745 S18 Assignment 2: dataflow.cpp
// Group: Milijana Surbatovich & Emily Ruppel
////////////////////////////////////////////////////////////////////////////////

#include "include/dataflow.h"
#include "include/taint_tracker.h"
#include <map>
#include <queue>
#include "llvm/Support/raw_ostream.h"

using namespace std;

namespace llvm {
  /* parameters:  Module* M - the LLVM module we're examining,
     void* t_func - the transfer function
     void* meet_op - the meet operator
     map<Function*, vector<Instruction*>> in_dir - initialized in edge structure (might not need)
     map<Function*, vector<Instruction*>> out_dir - initialized out edge structure (might not need)
     returns map of Func -> instruction list (or parent bb?) 
	*/
map<Function*, vector<Value*>*>  iterate(Module* M, tf_t t_func, mop_t meet_op,
		   map<Function*, vector<Value*>*>* in_dir, map<Function*, vector<Value*>*>* out_dir, 
       vector<Function*> io_name, AliasAnalysis& aa)
{
  //map<Instruction*, char*> in;
  //map<Instruction*, char*> out;
  queue<Function*> to_visit;
  map<Function*, int> temp;
  map<Function*, int> in_queue;
  //map<Function*,vector<Function*>> called_func_graph;
  
  //initialize the working set with all the (non-empty) funcs in the module
  for (Function& func : *M) {
    if(! func.empty()) {
      to_visit.push(&func);
      
    }
    temp[&func] = 0;
    in_queue[&func] = 1;
  }
  
  //Now we start the working set algorithm
  while(!to_visit.empty()) {
    Function* curr_f = to_visit.front();
    to_visit.pop();
    in_queue[curr_f] = 0;

    //errs() << curr_f->getName() <<" temp, in sizes: " << temp[curr_f] <<" " <<in_dir->at(curr_f)->size() <<"\n";
    
    //the transfer func does the actual intra-proc taint prop.
    //errs() <<"out size: "  <<out_dir->at(curr_f)->size() <<"\n";
    int out_length = out_dir->at(curr_f)->size();
    t_func(curr_f, temp[curr_f],in_dir->at(curr_f), out_dir->at(curr_f), io_name, aa);

    //empty temp and store the old in edge list.
    temp[curr_f] = in_dir->at(curr_f)->size();
    //this should find any interproc tainted ints from the current functions

    //if out length didn't change, no need to call interproc
    if(out_length==out_dir->at(curr_f)->size()) {
      continue;
    }
    
    //errs() << curr_f->getName() <<" temp, in sizes: " << temp[curr_f] <<" " <<in_dir->at(curr_f)->size() <<"\n";
    meet_op(curr_f, out_dir->at(curr_f), in_dir);
    //a reverse meet op, as it were
    
    for(auto map : *in_dir) {
      int changed = 0;
      //new items will be pushed back on to the end, so if any new items the length would have changed
      if(temp[map.first]!=in_dir->at(map.first)->size()) {
	changed = 1;
	//errs() << map.first->getName() << " changed\n";
      }
      if (changed) {
	//if it's not already in the list.
	if(!in_queue[map.first]) {
	  to_visit.push(map.first);
	}
      }
      
    }//end for map
  }

  return *out_dir;
}//end iterate

}//end namespace
