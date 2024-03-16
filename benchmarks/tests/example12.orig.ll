; ModuleID = '../../benchmarks/tests/example12.bc'
source_filename = "example12.2ec73fdcc3bed253-cgu.0"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

@vtable.0 = private unnamed_addr constant <{ ptr, [16 x i8], ptr, ptr, ptr }> <{ ptr @"_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h47ea1b16ba3e87a4E", [16 x i8] c"\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h2a2856448793d4cbE", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h339710bdc8eea187E", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h339710bdc8eea187E" }>, align 8
@IO_NAME = constant <{ ptr }> <{ ptr @input }>, align 8
@atomic_depth = external global i16

; Function Attrs: noinline uwtable
define internal void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h9c77676ca687ad52E(ptr %f) unnamed_addr #0 {
start:
  call void @_ZN4core3ops8function6FnOnce9call_once17hc6a9dc29a00ac63eE(ptr %f)
  call void asm sideeffect "", "~{memory}"(), !srcloc !3
  ret void
}

; Function Attrs: uwtable
define hidden i64 @_ZN3std2rt10lang_start17h04742dcfd5f87c29E(ptr %main, i64 %argc, ptr %argv, i8 %sigpipe) unnamed_addr #1 {
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
define internal i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h339710bdc8eea187E"(ptr align 8 %_1) unnamed_addr #2 {
start:
  %_4 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
  call void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h9c77676ca687ad52E(ptr %_4)
  %self = call i8 @"_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17hc6cb452c4729c1f5E"()
  %_0 = zext i8 %self to i32
  ret i32 %_0
}

; Function Attrs: inlinehint uwtable
define internal i32 @"_ZN47_$LT$i32$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h3be66287c3fcbba4E"(i32 %start1, i64 %n) unnamed_addr #2 {
start:
  %rhs = trunc i64 %n to i32
  %_0 = add nsw i32 %start1, %rhs
  ret i32 %_0
}

; Function Attrs: inlinehint uwtable
define internal i32 @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h2a2856448793d4cbE"(ptr %_1) unnamed_addr #2 {
start:
  %_2 = alloca {}, align 1
  %0 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
  %_0 = call i32 @_ZN4core3ops8function6FnOnce9call_once17had97088f55991c2cE(ptr %0)
  ret i32 %_0
}

; Function Attrs: inlinehint uwtable
define internal i32 @_ZN4core3ops8function6FnOnce9call_once17had97088f55991c2cE(ptr %0) unnamed_addr #2 personality ptr @rust_eh_personality {
start:
  %1 = alloca { ptr, i32 }, align 8
  %_2 = alloca {}, align 1
  %_1 = alloca ptr, align 8
  store ptr %0, ptr %_1, align 8
  %_0 = invoke i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h339710bdc8eea187E"(ptr align 8 %_1)
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
define internal void @_ZN4core3ops8function6FnOnce9call_once17hc6a9dc29a00ac63eE(ptr %_1) unnamed_addr #2 {
start:
  %_2 = alloca {}, align 1
  call void %_1()
  ret void
}

; Function Attrs: inlinehint uwtable
define internal void @"_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h47ea1b16ba3e87a4E"(ptr align 8 %_1) unnamed_addr #2 {
start:
  ret void
}

; Function Attrs: inlinehint uwtable
define internal { i32, i32 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h3186fffc13203a36E"(ptr align 4 %self) unnamed_addr #2 {
start:
  %0 = call { i32, i32 } @"_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h1b9638ceb504bcf5E"(ptr align 4 %self)
  %_0.0 = extractvalue { i32, i32 } %0, 0
  %_0.1 = extractvalue { i32, i32 } %0, 1
  %1 = insertvalue { i32, i32 } poison, i32 %_0.0, 0
  %2 = insertvalue { i32, i32 } %1, i32 %_0.1, 1
  ret { i32, i32 } %2
}

; Function Attrs: inlinehint uwtable
define internal i8 @"_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17hc6cb452c4729c1f5E"() unnamed_addr #2 {
start:
  ret i8 0
}

; Function Attrs: inlinehint uwtable
define internal { i32, i32 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h9c831713eeb3e5efE"(i32 %self.0, i32 %self.1) unnamed_addr #2 {
start:
  %0 = insertvalue { i32, i32 } poison, i32 %self.0, 0
  %1 = insertvalue { i32, i32 } %0, i32 %self.1, 1
  ret { i32, i32 } %1
}

; Function Attrs: inlinehint uwtable
define internal { i32, i32 } @"_ZN89_$LT$core..ops..range..Range$LT$T$GT$$u20$as$u20$core..iter..range..RangeIteratorImpl$GT$9spec_next17h1b9638ceb504bcf5E"(ptr align 4 %self) unnamed_addr #2 {
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
  %_6 = call i32 @"_ZN47_$LT$i32$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h3be66287c3fcbba4E"(i32 %old, i64 1)
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
  %_5 = alloca { i32, i32 }, align 4
  %iter = alloca { i32, i32 }, align 4
  %_3 = alloca { i32, i32 }, align 4
  %x = call i32 @input()
  store i32 0, ptr %_3, align 4
  %0 = getelementptr inbounds { i32, i32 }, ptr %_3, i32 0, i32 1
  store i32 10, ptr %0, align 4
  %1 = getelementptr inbounds { i32, i32 }, ptr %_3, i32 0, i32 0
  %2 = load i32, ptr %1, align 4, !noundef !4
  %3 = getelementptr inbounds { i32, i32 }, ptr %_3, i32 0, i32 1
  %4 = load i32, ptr %3, align 4, !noundef !4
  %5 = call { i32, i32 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h9c831713eeb3e5efE"(i32 %2, i32 %4)
  %_2.0 = extractvalue { i32, i32 } %5, 0
  %_2.1 = extractvalue { i32, i32 } %5, 1
  %6 = getelementptr inbounds { i32, i32 }, ptr %iter, i32 0, i32 0
  store i32 %_2.0, ptr %6, align 4
  %7 = getelementptr inbounds { i32, i32 }, ptr %iter, i32 0, i32 1
  store i32 %_2.1, ptr %7, align 4
  br label %bb3

bb3:                                              ; preds = %bb5, %start
  %8 = call { i32, i32 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h3186fffc13203a36E"(ptr align 4 %iter)
  store { i32, i32 } %8, ptr %_5, align 4
  %9 = load i32, ptr %_5, align 4, !range !5, !noundef !4
  %_7 = zext i32 %9 to i64
  %10 = icmp eq i64 %_7, 0
  br i1 %10, label %bb7, label %bb5

bb7:                                              ; preds = %bb3
  call void @Fresh(i32 %x)
  ret void

bb5:                                              ; preds = %bb3
  call void @log(i32 1)
  call void @log(i32 %x)
  br label %bb3

bb6:                                              ; No predecessors!
  unreachable
}

; Function Attrs: uwtable
define internal void @_ZN9example124main17h35539225bd174e48E() unnamed_addr #1 {
start:
  call void @app()
  ret void
}

; Function Attrs: uwtable
define internal void @Fresh(i32 %_var) unnamed_addr #1 {
start:
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
  %3 = call i64 @_ZN3std2rt10lang_start17h04742dcfd5f87c29E(ptr @_ZN9example124main17h35539225bd174e48E, i64 %2, ptr %1, i8 0)
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
!3 = !{i32 1453225}
!4 = !{}
!5 = !{i32 0, i32 2}
