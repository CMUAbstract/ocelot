#ifndef __INSTRUMENTREGIONS__
#define __INSTRUMENTREGIONS__

#include "global.h"
#include "exmwt.h"
//#include "CustomAlias.h"

class InstrumentRegions {
public:
  InstrumentRegions(Pass* _pass, Module* _m, Function* _lb, exmwt* _emw) { 
    pass = _pass;
    m = _m; 
    log_backup = _lb;
    emw = _emw;
  }
  void runTransformation(inst_vals_map WARinRegion);
  void backup(Instruction* firstInst, Value* v);
  inst_vec getArrWritePoint(Value* val, Function* F);
  void insertDynamicBackup(Instruction* I, Value* orig, Value* priv);
  Instruction* insertLogBackup(Value* oldVal, Value* newVal, Instruction* insertBefore);
private:
  Pass* pass;
  Module* m;
  Function* log_backup;
  exmwt* emw;
};

#endif
