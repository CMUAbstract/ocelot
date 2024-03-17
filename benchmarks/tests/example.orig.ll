; ModuleID = '../../benchmarks/tests/example.bc'
source_filename = "example.a08634fc28d17a86-cgu.0"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

@vtable.0 = private unnamed_addr constant <{ ptr, [16 x i8], ptr, ptr, ptr }> <{ ptr @"_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hd44a932dcf55a427E", [16 x i8] c"\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h06fb5f22a45b1729E", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he4a3bb6af4f8bfafE", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he4a3bb6af4f8bfafE" }>, align 8
@IO_NAME = constant <{ ptr }> <{ ptr @tmp }>, align 8
@atomic_depth = external global i16

; Function Attrs: noinline uwtable
define internal void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h11952cf61e1518ebE(ptr %f) unnamed_addr #0 {
start:
  call void @_ZN4core3ops8function6FnOnce9call_once17h2e8e8fa7347da120E(ptr %f)
  call void asm sideeffect "", "~{memory}"(), !srcloc !3
  ret void
}

; Function Attrs: uwtable
define hidden i64 @_ZN3std2rt10lang_start17ha3b54fab1f2518b9E(ptr %main, i64 %argc, ptr %argv, i8 %sigpipe) unnamed_addr #1 {
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
define internal i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he4a3bb6af4f8bfafE"(ptr align 8 %_1) unnamed_addr #2 {
start:
  %_4 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
  call void @_ZN3std10sys_common9backtrace28__rust_begin_short_backtrace17h11952cf61e1518ebE(ptr %_4)
  %self = call i8 @"_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h026d1b3fd579707fE"()
  %_0 = zext i8 %self to i32
  ret i32 %_0
}

; Function Attrs: inlinehint uwtable
define internal i32 @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h06fb5f22a45b1729E"(ptr %_1) unnamed_addr #2 {
start:
  %_2 = alloca {}, align 1
  %0 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
  %_0 = call i32 @_ZN4core3ops8function6FnOnce9call_once17h631194d6dbd64289E(ptr %0)
  ret i32 %_0
}

; Function Attrs: inlinehint uwtable
define internal void @_ZN4core3ops8function6FnOnce9call_once17h2e8e8fa7347da120E(ptr %_1) unnamed_addr #2 {
start:
  %_2 = alloca {}, align 1
  call void %_1()
  ret void
}

; Function Attrs: inlinehint uwtable
define internal i32 @_ZN4core3ops8function6FnOnce9call_once17h631194d6dbd64289E(ptr %0) unnamed_addr #2 personality ptr @rust_eh_personality {
start:
  %1 = alloca { ptr, i32 }, align 8
  %_2 = alloca {}, align 1
  %_1 = alloca ptr, align 8
  store ptr %0, ptr %_1, align 8
  %_0 = invoke i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17he4a3bb6af4f8bfafE"(ptr align 8 %_1)
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
define internal void @"_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17hd44a932dcf55a427E"(ptr align 8 %_1) unnamed_addr #2 {
start:
  ret void
}

; Function Attrs: inlinehint uwtable
define internal i8 @"_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h026d1b3fd579707fE"() unnamed_addr #2 {
start:
  ret i8 0
}

; Function Attrs: uwtable
define dso_local i32 @tmp() unnamed_addr #1 {
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
  %x = call i32 @tmp()
  call void @Fresh(i32 %x)
  call void @log(i32 %x)
  ret void
}

; Function Attrs: uwtable
define internal void @_ZN7example4main17ha3370acdcff48c7aE() unnamed_addr #1 {
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
  %3 = call i64 @_ZN3std2rt10lang_start17ha3b54fab1f2518b9E(ptr @_ZN7example4main17ha3370acdcff48c7aE, i64 %2, ptr %1, i8 0)
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
!3 = !{i32 1115290}
!4 = !{}
