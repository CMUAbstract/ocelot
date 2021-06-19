# region-inference-pass

LLVM Pass for inferring atomic regions

Build:

	$ mkdir build
	$ cd build
	$ cmake ..
	$ make

Run:

	$ opt -load build/src/libInferAtomicPass.so -atomize something.bc
