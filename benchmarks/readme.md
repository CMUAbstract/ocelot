Along with the folders for the benchmarks, we show examples of other files necessary to 
create Ocelot applications:
* **intermittent.rs** - provides the foreign functions that the inference pass and runtime hook into, along with 
some macros for initializing non-volatile memory, and the annotation definitions. This should be included in the rust library code. 
* **main.c** - provides an example of the c main stub needed for the runtime and drivers. The goal is that eventually everything should be in Rust, but the not all the necessary tooling support and crates exist yet for the MSP430. 
* **test_lib.h** - stub header that must include the name of the "main" rust function, for foreign function calling from the C main stub into Rust. 
