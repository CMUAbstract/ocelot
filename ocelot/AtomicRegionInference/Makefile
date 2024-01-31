.PHONY: clean_tests clean eg1 eg2

all:
	make eg1
	make eg2
	make eg3

eg1:
	TEST=example01 make test
eg2:
	TEST=example02 make test
eg3:
	TEST=example03 make test

run_eg1:
	TEST=example01 make run
run_eg2:
	TEST=example02 make run
run_eg3:
	TEST=example03 make run

test:
	$(MAKE) -C build
	clang -S -emit-llvm\
		-fno-discard-value-names\
		../../benchmarks/ctests/$(TEST).c\
		-o ../../benchmarks/ctests/$(TEST).orig.ll
	clang -S -emit-llvm\
		-fpass-plugin=build/src/InferAtomsPass.dylib\
		-fno-discard-value-names\
		../../benchmarks/ctests/$(TEST).c\
		-o ../../benchmarks/ctests/$(TEST).ll

run:
	$(MAKE) -C build
	clang -fpass-plugin=build/src/InferAtomsPass.dylib\
		../../benchmarks/ctests/$(TEST).c\
		-o ../../benchmarks/ctests/$(TEST).out

clean_tests:
	find ../../benchmarks/ctests -name "*.ll" -exec rm -rf {} \;

clean:
	rm -rf build
