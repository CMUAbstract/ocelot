; ModuleID = '../../benchmarks/tests/example07.c'
source_filename = "../../benchmarks/tests/example07.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

@IO_NAME = global ptr @input, align 8
@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @atomic_start() #0 {
entry:
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @atomic_end() #0 {
entry:
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @input() #0 {
entry:
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @log(i32 noundef %x) #0 {
entry:
  %x.addr = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  %0 = load i32, ptr %x.addr, align 4
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %0)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @app() #0 {
entry:
  %x = alloca i32, align 4
  %0 = alloca i32, align 4
  %i = alloca i32, align 4
  %y = alloca i32, align 4
  call void @atomic_start()
  %call = call i32 @input()
  store i32 %call, ptr %x, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %entry, %for.inc, <null operand!>
  %1 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %1, 10
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, ptr %x, align 4
  call void @log(i32 noundef %2)
  br label %for.inc

for.inc:                                          ; preds = %for.body, <null operand!>
  %3 = load i32, ptr %i, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !5

for.end:                                          ; preds = %for.cond
  call void @atomic_end()
  store i32 0, ptr %0, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc3, %for.end
  %4 = load i32, ptr %0, align 4
  %5 = icmp slt i32 %4, 10
  br i1 %5, label %for.body2, label %for.end4

for.body2:                                        ; preds = %for.cond1
  store i32 1, ptr %y, align 4
  %6 = load i32, ptr %y, align 4
  %7 = add nsw i32 %6, 2
  call void @log(i32 noundef %7)
  br label %for.inc3

for.inc3:                                         ; preds = %for.body2
  %8 = load i32, ptr %0, align 4
  %9 = add nsw i32 %8, 1
  store i32 %9, ptr %0, align 4
  br label %for.cond1, !llvm.loop !5

for.end4:                                         ; preds = %for.cond1
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
entry:
  call void @app()
  ret i32 0
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 17.0.2"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}