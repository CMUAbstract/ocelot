add_llvm_pass_plugin(InferAtomsPass
    # List your source files here.
    InferAtoms.cpp
    TaintTracker.cpp
    InferFreshCons.cpp
    Helpers.cpp
)
