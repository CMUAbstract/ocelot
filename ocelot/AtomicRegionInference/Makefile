.PHONY: clean_tests clean eg1 eg2 eg3 eg4 eg5 eg6 eg7 eg8 eg9 eg10 egr run_eg1 run_eg2 run_eg3 run_eg4 run_eg5 run_eg6 run_eg7 run_eg8 run_eg9 run_eg10

all:
	make eg1
	make eg2
	make eg3
	make eg4
	make eg5
	make eg6
	make eg7
	make eg8
	make eg9
	make eg10
	make egr
	make eg11
	
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
eg7:
	TEST=example07 make test
eg8:
	TEST=example08 make test
eg9:
	TEST=example09 make test
eg10:
	TEST=example10 make test
egr:
	TEST=example make testr
eg11:
	TEST=example11 make testr
eg12:
	TEST=example12 make testr

run_eg1:
	TEST=example01 make run && ../../benchmarks/tests/example01.out
run_eg2:
	TEST=example02 make run && ../../benchmarks/tests/example02.out
run_eg3:
	TEST=example03 make run && ../../benchmarks/tests/example03.out
run_eg4:
	TEST=example04 make run && ../../benchmarks/tests/example04.out
run_eg5:
	TEST=example05 make run && ../../benchmarks/tests/example05.out
run_eg6:
	TEST=example06 make run && ../../benchmarks/tests/example06.out
run_eg7:
	TEST=example07 make run && ../../benchmarks/tests/example07.out
run_eg8:
	TEST=example08 make run && ../../benchmarks/tests/example08.out
run_eg9:
	TEST=example09 make run && ../../benchmarks/tests/example09.out
run_eg10:
	TEST=example10 make run && ../../benchmarks/tests/example10.out

test:
	$(MAKE) -C build
	clang -S -emit-llvm\
		-fno-discard-value-names\
		../../benchmarks/tests/$(TEST).c\
		-o ../../benchmarks/tests/$(TEST).orig.ll
	clang -S -emit-llvm\
		-fpass-plugin=build/src/InferAtomsPass.dylib\
		-fno-discard-value-names\
		../../benchmarks/tests/$(TEST).c\
		-o ../../benchmarks/tests/$(TEST).ll

testr:
	$(MAKE) -C build
	rustc ../../benchmarks/tests/$(TEST).rs --emit llvm-bc -o ../../benchmarks/tests/$(TEST).bc
	clang -S -emit-llvm\
		-fno-discard-value-names\
		../../benchmarks/tests/$(TEST).bc\
		-o ../../benchmarks/tests/$(TEST).orig.ll
	clang -S -emit-llvm\
		-fpass-plugin=build/src/InferAtomsPass.dylib\
		-fno-discard-value-names\
		../../benchmarks/tests/$(TEST).bc\
		-o ../../benchmarks/tests/$(TEST).ll

run:
	$(MAKE) -C build
	clang -fpass-plugin=build/src/InferAtomsPass.dylib\
		../../benchmarks/tests/$(TEST).c\
		-o ../../benchmarks/tests/$(TEST).out

clean_tests:
	find ../../benchmarks/tests -name "*.ll" -exec rm -rf {} \;

clean:
	rm -rf build
