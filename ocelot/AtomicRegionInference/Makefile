.PHONY: clean_tests clean eg1 eg2

all:
	make eg1
	make eg2
	make eg3
	make eg4
	make eg5
	make eg6

eg1:
	TEST=example01 make test
eg2:
	TEST=example02 make test
eg3:
	TEST=example03 make test
eg4:
	TEST=example04 make test
eg5:
	TEST=example05 make test
eg6:
	TEST=example06 make test

run_eg1:
	TEST=example01 make run
run_eg2:
	TEST=example02 make run
run_eg3:
	TEST=example03 make run
run_eg4:
	TEST=example04 make run
run_eg5:
	TEST=example05 make run
run_eg6:
	TEST=example06 make run

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
