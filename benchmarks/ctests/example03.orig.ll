; ModuleID = '../../benchmarks/ctests/example03.c'
source_filename = "../../benchmarks/ctests/example03.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx12.0.0"

@IO_NAME = global ptr @input, align 8

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @Fresh(i32 noundef %x) #0 {
entry:
  %x.addr = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @Consistent(i32 noundef %x, i32 noundef %id) #0 {
entry:
  %x.addr = alloca i32, align 4
  %id.addr = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  store i32 %id, ptr %id.addr, align 4
  ret void
}

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
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @app() #0 {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  %call = call i32 @input()
  store i32 %call, ptr %x, align 4
  store i32 1, ptr %y, align 4
  %0 = load i32, ptr %y, align 4
  %add = add nsw i32 %0, 1
  store i32 %add, ptr %z, align 4
  %1 = load i32, ptr %z, align 4
  call void @log(i32 noundef %1)
  %2 = load i32, ptr %x, align 4
  call void @log(i32 noundef %2)
  %3 = load i32, ptr %x, align 4
  call void @Fresh(i32 noundef %3)
  ret void
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 17.0.2"}
