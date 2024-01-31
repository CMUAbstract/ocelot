# Atomic Region Inference

LLVM Pass for inferring atomic regions. Tested to work with LLVM 17.

To build the pass:

```sh
mkdir build
cd build
cmake ..
make
```

You may bootstrap Clang to use the pass to compile a C file like so (run in the
same directory as this README):

```sh
clang -S -emit-llvm -fpass-plugin=build/src/InferAtomsPass.dylib -fno-discard-value-names ../../benchmarks/ctests/example03.c
```

Or, use the shortcuts provided in the Makefile (e.g., `make eg3`), which produce
two LLVM IRs with and without the pass enabled.

Actually link and produce executable by running:

```sh
clang -fpass-plugin=build/src/InferAtomsPass.dylib ../../benchmarks/ctests/example03.c -o ../../benchmarks/ctests/example03.out

../../benchmarks/ctests/example03.out
```

Or, use the equivalent shortcut `make run_eg3 && ../../benchmarks/ctests/example03.out`.
