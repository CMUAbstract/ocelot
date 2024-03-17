; ModuleID = '../../benchmarks/tests/example13.bc'
source_filename = "example13.a75a82856bfae51d-cgu.0"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

@vtable.0 = private unnamed_addr constant <{ ptr, [16 x i8], ptr, ptr, ptr }> <{ ptr @"_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hf0f1c0343a3d5304E", [16 x i8] c"\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h4dfc989e8a89cebeE", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h51a796a89a29b131E", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h51a796a89a29b131E" }>, align 8
@IO_NAME = constant <{ ptr }> <{ ptr @input }>, align 8
@atomic_depth = external global i16

; Function Attrs: noinline uwtable
define internal void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17hf4f9b68dd936cd73E(ptr %f) unnamed_addr #0 {
start:
  call void @_ZN4core3ops8function6FnOnce9call_once17h6b12a0453d0fac53E(ptr %f)
  call void asm sideeffect "", "~{memory}"(), !srcloc !3
  ret void
}

; Function Attrs: uwtable
define hidden i64 @_ZN3std2rt10lang_start17h431fe12d2c8c1de6E(ptr %main, i64 %argc, ptr %argv, i8 %sigpipe) unnamed_addr #1 {
start:
  %_8 = alloca ptr, align 8
  %_5 = alloca i64, align 8
  store ptr %main, ptr %_8, align 8
  %0 = call i64 @_ZN3std2rt19lang_start_internal17hadaf077a6dd0140bE(ptr align 1 %_8, ptr align 8 @vtable.0, i64 %argc, ptr %argv, i8 %sigpipe)
  store i64 %0, ptr %_5, align 8
  %v = load i64, ptr %_5, align 8, !noundef !4
  ret i64 %v
}

; Function Attrs: inlinehint uwtable
define internal i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h51a796a89a29b131E"(ptr align 8 %_1) unnamed_addr #2 {
start:
  %_4 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
  call void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17hf4f9b68dd936cd73E(ptr %_4)
  %self = call i8 @"_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h2db0f42e6485e7e4E"()
  %_0 = zext i8 %self to i32
  ret i32 %_0
}

; Function Attrs: inlinehint uwtable
define internal i32 @"_ZN47_$LT$i32$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h4944c1e1e44c8861E"(i32 %start1, i64 %n) unnamed_addr #2 {
start:
  %rhs = trunc i64 %n to i32
  %_0 = add nsw i32 %start1, %rhs
  ret i32 %_0
}

; Function Attrs: inlinehint uwtable
define internal i32 @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h4dfc989e8a89cebeE"(ptr %_1) unnamed_addr #2 {
start:
  %_2 = alloca {}, align 1
  %0 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
  %_0 = call i32 @_ZN4core3ops8function6FnOnce9call_once17hde4d0e94a62ddc18E(ptr %0)
  ret i32 %_0
}

; Function Attrs: inlinehint uwtable
define internal void @_ZN4core3ops8function6FnOnce9call_once17h6b12a0453d0fac53E(ptr %_1) unnamed_addr #2 {
start:
  %_2 = alloca {}, align 1
  call void %_1()
  ret void
}

; Function Attrs: inlinehint uwtable
define internal i32 @_ZN4core3ops8function6FnOnce9call_once17hde4d0e94a62ddc18E(ptr %0) unnamed_addr #2 personality ptr @rust_eh_personality {
start:
  %1 = alloca { ptr, i32 }, align 8
  %_2 = alloca {}, align 1
  %_1 = alloca ptr, align 8
  store ptr %0, ptr %_1, align 8
  %_0 = invoke i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h51a796a89a29b131E"(ptr align 8 %_1)
          to label %bb1 unwind label %cleanup

bb3:                                              ; preds = %cleanup
  %2 = load ptr, ptr %1, align 8, !noundef !4
  %3 = getelementptr inbounds { ptr, i32 }, ptr %1, i32 0, i32 1
  %4 = load i32, ptr %3, align 8, !noundef !4
  %5 = insertvalue { ptr, i32 } poison, ptr %2, 0
  %6 = insertvalue { ptr, i32 } %5, i32 %4, 1
  resume { ptr, i32 } %6

cleanup:                                          ; preds = %start
  %7 = landingpad { ptr, i32 }
          cleanup
  %8 = extractvalue { ptr, i32 } %7, 0
  %9 = extractvalue { ptr, i32 } %7, 1
  %10 = getelementptr inbounds { ptr, i32 }, ptr %1, i32 0, i32 0
  store ptr %8, ptr %10, align 8
  %11 = getelementptr inbounds { ptr, i32 }, ptr %1, i32 0, i32 1
  store i32 %9, ptr %11, align 8
  br label %bb3

bb1:                                              ; preds = %start
  ret i32 %_0
}

; Function Attrs: inlinehint uwtable
define internal void @"_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hf0f1c0343a3d5304E"(ptr align 8 %_1) unnamed_addr #2 {
start:
  ret void
}

; Function Attrs: inlinehint uwtable
define internal { i32, i32 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h81d1ae0fa0da4546E"(ptr align 4 %self) unnamed_addr #2 {
start:
  %0 = call { i32, i32 } @"_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h3a2fc0cbb86bcd54E"(ptr align 4 %self)
  %_0.0 = extractvalue { i32, i32 } %0, 0
  %_0.1 = extractvalue { i32, i32 } %0, 1
  %1 = insertvalue { i32, i32 } poison, i32 %_0.0, 0
  %2 = insertvalue { i32, i32 } %1, i32 %_0.1, 1
  ret { i32, i32 } %2
}

; Function Attrs: inlinehint uwtable
define internal i8 @"_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h2db0f42e6485e7e4E"() unnamed_addr #2 {
start:
  ret i8 0
}

; Function Attrs: inlinehint uwtable
define internal { i32, i32 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h80dc70a24d0c93edE"(i32 %self.0, i32 %self.1) unnamed_addr #2 {
start:
  %0 = insertvalue { i32, i32 } poison, i32 %self.0, 0
  %1 = insertvalue { i32, i32 } %0, i32 %self.1, 1
  ret { i32, i32 } %1
}

; Function Attrs: inlinehint uwtable
define internal { i32, i32 } @"_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h3a2fc0cbb86bcd54E"(ptr align 4 %self) unnamed_addr #2 {
start:
  %_0 = alloca { i32, i32 }, align 4
  %_4 = getelementptr inbounds { i32, i32 }, ptr %self, i32 0, i32 1
  %_3.i = load i32, ptr %self, align 4, !noundef !4
  %_4.i = load i32, ptr %_4, align 4, !noundef !4
  %_0.i = icmp slt i32 %_3.i, %_4.i
  br i1 %_0.i, label %bb2, label %bb4

bb4:                                              ; preds = %start
  store i32 0, ptr %_0, align 4
  br label %bb5

bb2:                                              ; preds = %start
  %old = load i32, ptr %self, align 4, !noundef !4
  %_6 = call i32 @"_ZN47_$LT$i32$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h4944c1e1e44c8861E"(i32 %old, i64 1)
  store i32 %_6, ptr %self, align 4
  %0 = getelementptr inbounds { i32, i32 }, ptr %_0, i32 0, i32 1
  store i32 %old, ptr %0, align 4
  store i32 1, ptr %_0, align 4
  br label %bb5

bb5:                                              ; preds = %bb2, %bb4
  %1 = getelementptr inbounds { i32, i32 }, ptr %_0, i32 0, i32 0
  %2 = load i32, ptr %1, align 4, !range !5, !noundef !4
  %3 = getelementptr inbounds { i32, i32 }, ptr %_0, i32 0, i32 1
  %4 = load i32, ptr %3, align 4
  %5 = insertvalue { i32, i32 } poison, i32 %2, 0
  %6 = insertvalue { i32, i32 } %5, i32 %4, 1
  ret { i32, i32 } %6
}

; Function Attrs: uwtable
define dso_local i32 @input() unnamed_addr #1 {
start:
  ret i32 0
}

; Function Attrs: uwtable
define dso_local void @log(i32 %i) unnamed_addr #1 {
start:
  ret void
}

; Function Attrs: uwtable
define dso_local void @app() unnamed_addr #1 {
start:
  %_6 = alloca { i32, i32 }, align 4
  %iter = alloca { i32, i32 }, align 4
  %_3 = alloca { i32, i32 }, align 4
  call void @atomic_start()
  %x = call i32 @input()
  store i32 %x, ptr %_3, align 4
  %0 = getelementptr inbounds { i32, i32 }, ptr %_3, i32 0, i32 1
  store i32 10, ptr %0, align 4
  %1 = getelementptr inbounds { i32, i32 }, ptr %_3, i32 0, i32 0
  %2 = load i32, ptr %1, align 4, !noundef !4
  %3 = getelementptr inbounds { i32, i32 }, ptr %_3, i32 0, i32 1
  %4 = load i32, ptr %3, align 4, !noundef !4
  %5 = call { i32, i32 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h80dc70a24d0c93edE"(i32 %2, i32 %4)
  %6 = extractvalue { i32, i32 } %5, 0
  %7 = extractvalue { i32, i32 } %5, 1
  %8 = getelementptr inbounds { i32, i32 }, ptr %iter, i32 0, i32 0
  store i32 %6, ptr %8, align 4
  %9 = getelementptr inbounds { i32, i32 }, ptr %iter, i32 0, i32 1
  store i32 %7, ptr %9, align 4
  br label %bb3

bb3:                                              ; preds = %start, %bb5, <null operand!>
  %10 = call { i32, i32 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h81d1ae0fa0da4546E"(ptr align 4 %iter)
  store { i32, i32 } %10, ptr %_6, align 4
  %11 = load i32, ptr %_6, align 4, !range !5, !noundef !4
  %_8 = zext i32 %11 to i64
  %12 = icmp eq i64 %_8, 0
  br i1 %12, label %bb7, label %bb5

bb7:                                              ; preds = %bb3
  call void @atomic_end()
  ret void

bb5:                                              ; preds = %bb3
  %13 = getelementptr inbounds { i32, i32 }, ptr %_6, i32 0, i32 1
  %i = load i32, ptr %13, align 4, !noundef !4
  call void @log(i32 %i)
  br label %bb3

bb6:                                              ; No predecessors!
  unreachable
}

; Function Attrs: uwtable
define internal void @_ZN9example134main17haba30008cc3025a3E() unnamed_addr #1 {
start:
  call void @app()
  ret void
}

; Function Attrs: uwtable
define dso_local void @atomic_start() unnamed_addr #1 {
start:
  %local = load i16, ptr @atomic_depth, align 2, !noundef !4
  call void @start_atomic()
  ret void
}

; Function Attrs: uwtable
define dso_local void @atomic_end() unnamed_addr #1 {
start:
  call void @end_atomic()
  ret void
}

; Function Attrs: uwtable
declare i64 @_ZN3std2rt19lang_start_internal17hadaf077a6dd0140bE(ptr align 1, ptr align 8, i64, ptr, i8) unnamed_addr #1

; Function Attrs: uwtable
declare i32 @rust_eh_personality(i32, i32, i64, ptr, ptr) unnamed_addr #1

; Function Attrs: uwtable
declare void @start_atomic() unnamed_addr #1

; Function Attrs: uwtable
declare void @end_atomic() unnamed_addr #1

define i32 @main(i32 %0, ptr %1) unnamed_addr #3 {
top:
  %2 = sext i32 %0 to i64
  %3 = call i64 @_ZN3std2rt10lang_start17h431fe12d2c8c1de6E(ptr @_ZN9example134main17haba30008cc3025a3E, i64 %2, ptr %1, i8 0)
  %4 = trunc i64 %3 to i32
  ret i32 %4
}

attributes #0 = { noinline uwtable "frame-pointer"="non-leaf" "target-cpu"="apple-m1" }
attributes #1 = { uwtable "frame-pointer"="non-leaf" "target-cpu"="apple-m1" }
attributes #2 = { inlinehint uwtable "frame-pointer"="non-leaf" "target-cpu"="apple-m1" }
attributes #3 = { "frame-pointer"="non-leaf" "target-cpu"="apple-m1" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 7, !"PIE Level", i32 2}
!2 = !{!"rustc version 1.73.0 (cc66ad468 2023-10-03)"}
!3 = !{i32 1453209}
!4 = !{}
!5 = !{i32 0, i32 2}
