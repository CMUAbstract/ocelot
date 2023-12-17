.PHONY: clean_tests clean eg1 eg2

eg1:
	TEST=example01 make test
eg2:
	TEST=example02 make test

test:
	$(MAKE) -C build all
	clang -S -emit-llvm\
		-fpass-plugin=build/src/InferAtomsPass.dylib\
		-fno-discard-value-names\
		../../benchmarks/ctests/$(TEST).c\
		-o ../../benchmarks/ctests/$(TEST).ll

clean_tests:
	find ../../benchmarks/ctests -name "*.ll" -exec rm -rf {} \;

clean:
	rm -rf build
