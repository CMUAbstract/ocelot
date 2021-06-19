# omega-pass

LLVM Pass for instrumentint atomic regions with logging for WAR and RIO-involved variables

Build:

	$ mkdir build
	$ cd build
	$ cmake ..
	$ make

Run:

	$ opt -load build/src/libOmegaPass.so -omega something_with_atomic_regions.bc
