# Atomic Region Inference

LLVM Pass for inferring atomic regions. Tested to work with LLVM 17.

To build the pass:

```sh
mkdir build
cd build
cmake ..
make
```

You may bootstrap Clang to use the pass to compile a C file like so:

```sh
clang -S -emit-llvm -fpass-plugin=src/InferAtomsPass.dylib -fno-discard-value-names ../../../benchmarks/ctests/example01.c
```
