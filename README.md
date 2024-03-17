The folder **benchmarks**  contains the rust source code of the benchmarks. 
The subfolders are titled with the name of the contained application, and each subfolder 
has the files:

* **unaltered.rs** - the unadorned rust application code
* **annotated.rs** - a version with fresh and consistent annotations added and comments 
  indicating where the bounds of the inferred regions would go (to the nearest source line, since regions 
  are inferred at the IR level and could be in, e.g., a loop latch basic block.) To quickly find the annotations, search for "Fresh", "Consistent", or "FreshConsistent" (used when a variable has both constraints). To find the comments marking the region boundaries, seach for "Inferred".
* **<name_of_app>_post.ll** - the LLVM IR representation of the program after region inferrence and 
logging code instrumentation. Search for "atomic_start" or "atomic_end" to see the region beginning and ending respectively. 
* **readme.md** - a small description of the benchmark and the timing constraints enforced by the annotations.
Note that each folder does not contain all the dependencies necessary to compile and run the benchmark 
(e.g., the 'C' main stub or any other external functions), but is organized so that one is able to quickly compare the annotated and unnotated code versions and see the inferred regions. We provide example of such a main stub in the top level of the **benchmarks** directory.

## Ocelot compiler code 

The core component of Ocelot is a compiler pass that analyzes a program annotated 
with Fresh and Consistentcy constraints, then inferrs and instruments atomic region boundaries 
that satisfy the constraints. The code of this pass is located in the **ocelot/AtomicRegionInferrence** folder. 
To run an Ocelot program, there must also be some sort of logging for atomic regions, and 
a runtime that supports both atomic and just-in-time execution. Our implementation of 
these components are in **ocelot/OmegaPass** and **ocelot/jit_atomics** respectively, but the details 
of these are not critical to the core functionality.  
The Ocelot inference pass makes very few assumptions on how these are implemented to allow the core component to be 
used modularly, with different intermittent system implementations. The **benchmarks/intermittent.rs** file 
contains Rust wrapper functions for the beginning and end of an atomic regions that call the external C functions used in the runtime code. Ocelot inserts the Rust function call. 
To use another implementation, the wrapper functions can be made to call a different implementation of atomic regions. 


## Guide on building Ocelot applications for the MSP430

To build an application with Ocelot, the inference pass must be run first, on the LLVM-bc of the application. The 
Omega pass should then be run on that generated code to instrument the atomic regions with logging code. Finally, the C main and runtime and driver libraries should be linked to the intrumented .bc file. 

Linking an application to run on the cabybara hardware platform presents some difficulties due to quirks of LLVM 
and MSP430 ISA support. A more detailed tutorial on end-to-end compilation and linking will come soon.

