; ModuleID = 'greenhouse_post.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:16:16-i32:16-i64:16-f32:16-f64:16-a:8-n8:16-S16"
target triple = "msp430-none-unknown-elf"

%"fmt::USIZE_MARKER::{{closure}}" = type {}
%"core::option::Option<i32>::Some" = type { [1 x i16], i32, [0 x i16] }
%"core::mem::maybe_uninit::MaybeUninit<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>" = type { [16 x i16] }
%"core::mem::manually_drop::ManuallyDrop<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>" = type { [0 x i16], %"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock", [0 x i16] }
%"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock" = type { [0 x i16], i64, [0 x i16], i64, [0 x i16], i64, [0 x i16], i64, [0 x i16] }
%"core::option::Option<u16>::Some" = type { [1 x i16], i16, [0 x i16] }
%"core::panic::Location" = type { [0 x i16], { [0 x i8]*, i16 }, [0 x i16], i32, [0 x i16], i32, [0 x i16] }
%"fmt::Arguments" = type { [0 x i16], { [0 x { [0 x i8]*, i16 }]*, i16 }, [0 x i16], { i16*, i16 }, [0 x i16], { [0 x { i8*, i8* }]*, i16 }, [0 x i16] }
%"fmt::Formatter" = type { [0 x i16], i32, [0 x i16], i32, [0 x i16], { i16, i16 }, [0 x i16], { i16, i16 }, [0 x i16], { {}*, [3 x i16]* }, [0 x i8], i8, [1 x i8] }
%"panic::PanicInfo" = type { [0 x i16], { {}*, [3 x i16]* }, [0 x i16], i16*, [0 x i16], %"core::panic::Location"*, [0 x i16] }

@alloc5 = private unnamed_addr constant <{ [6 x i8] }> <{ [6 x i8] c"adc\0D\0A\00" }>, align 1
@alloc6 = private unnamed_addr constant <{ [7 x i8] }> <{ [7 x i8] c"temp\0D\0A\00" }>, align 1
@num_dirty_gv = common externally_initialized global i16 0
@_numBoots = common externally_initialized global i16 0
@data_src = global [4 x i8*] zeroinitializer, section ".nv_vars", align 2
@data_dest = global [4 x i8*] zeroinitializer, section ".nv_vars", align 2
@data_size = global [4 x i16] zeroinitializer, section ".nv_vars", align 2
@atomic_depth = external global i16
@_ZN10greenhouse3app8MOISTURE17h8897597179d69b14E = internal global <{ [10 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN10greenhouse3app8MOISTURE17h8897597179d69b14E_bak = internal global <{ [10 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN10greenhouse3app11TEMPERATURE17hfb400d8a3f5f6cbaE = internal global <{ [20 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN10greenhouse3app11TEMPERATURE17hfb400d8a3f5f6cbaE_bak = internal global <{ [20 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN10greenhouse3app6SENSE117h9ceb247d33710457E = internal global <{ [1 x i8] }> zeroinitializer, section ".nv_vars", align 1
@_ZN10greenhouse3app6SENSE117h9ceb247d33710457E_bak = internal global <{ [1 x i8] }> zeroinitializer, section ".nv_vars", align 1
@_ZN10greenhouse3app6SENSE217hdfe04dfa897f740aE = internal global <{ [1 x i8] }> zeroinitializer, section ".nv_vars", align 1
@_ZN10greenhouse3app6SENSE217hdfe04dfa897f740aE_bak = internal global <{ [1 x i8] }> zeroinitializer, section ".nv_vars", align 1
@_ZN10greenhouse3app5MOIST17h959cb7d1bbbb882bE = internal global <{ [2 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN10greenhouse3app4TEMP17h50e2fb0948c59ac1E = internal global <{ [4 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN10greenhouse3app3AVG17hdf1ec3a33bfd291dE = internal global <{ [6 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN10greenhouse3app8COMPUTEC17h57840fa4e15d44e7E = internal global <{ [1 x i8] }> zeroinitializer, section ".nv_vars", align 1
@_ZN10greenhouse3app5SENDC17h9bde036371f22910E = internal global <{ [1 x i8] }> zeroinitializer, section ".nv_vars", align 1
@alloc49 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc62, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00[\00\00\00\12\00\00\00" }>, align 2
@alloc51 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc62, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\5C\00\00\00\19\00\00\00" }>, align 2
@alloc62 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"src/lib.rs" }>, align 1
@alloc53 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc62, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00g\00\00\00\17\00\00\00" }>, align 2
@alloc55 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc62, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00g\00\00\00\09\00\00\00" }>, align 2
@alloc57 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc62, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00h\00\00\00\1A\00\00\00" }>, align 2
@alloc59 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc62, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00h\00\00\00\09\00\00\00" }>, align 2
@alloc61 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc62, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00j\00\00\00\05\00\00\00" }>, align 2
@alloc63 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc62, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00k\00\00\00\05\00\00\00" }>, align 2
@anon.b7bafff2f871b915b57b152a19c6233b.18 = private unnamed_addr constant <{ i8*, [0 x i8] }> <{ i8* bitcast (<{ i8*, [2 x i8], i8*, [2 x i8] }>* @alloc16077 to i8*), [0 x i8] zeroinitializer }>, align 2
@anon.b7bafff2f871b915b57b152a19c6233b.10 = private unnamed_addr constant <{ i8*, [0 x i8] }> <{ i8* getelementptr inbounds (<{ [0 x i8] }>, <{ [0 x i8] }>* @alloc18891, i32 0, i32 0, i32 0), [0 x i8] zeroinitializer }>, align 2
@vtable.c = private unnamed_addr constant { void (%"fmt::USIZE_MARKER::{{closure}}"*)*, i16, i16, i64 (%"fmt::USIZE_MARKER::{{closure}}"*)* } { void (%"fmt::USIZE_MARKER::{{closure}}"*)* undef, i16 0, i16 1, i64 (%"fmt::USIZE_MARKER::{{closure}}"*)* undef }, align 2
@alloc18891 = private unnamed_addr constant <{ [0 x i8] }> zeroinitializer, align 2
@alloc16077 = private unnamed_addr constant <{ i8*, [2 x i8], i8*, [2 x i8] }> <{ i8* getelementptr inbounds (<{ [32 x i8] }>, <{ [32 x i8] }>* @alloc16075, i32 0, i32 0, i32 0), [2 x i8] c" \00", i8* getelementptr inbounds (<{ [18 x i8] }>, <{ [18 x i8] }>* @alloc16076, i32 0, i32 0, i32 0), [2 x i8] c"\12\00" }>, align 2
@alloc16075 = private unnamed_addr constant <{ [32 x i8] }> <{ [32 x i8] c"index out of bounds: the len is " }>, align 1
@alloc16076 = private unnamed_addr constant <{ [18 x i8] }> <{ [18 x i8] c" but the index is " }>, align 1

; Function Attrs: nounwind
define internal i16 @_ZN10greenhouse9adcConfig17h1a9fbeb697d52057E() unnamed_addr #0 {
start:
  %_6 = alloca { i16, i32 }, align 2
  %iter = alloca { i32, i32 }, align 2
  %_3 = alloca { i32, i32 }, align 2
  %reg = alloca i32, align 2
  store i32 0, i32* %reg, align 2
  %0 = bitcast { i32, i32 }* %_3 to i32*
  store i32 0, i32* %0, align 2
  %1 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %_3, i32 0, i32 1
  store i32 40, i32* %1, align 2
  %2 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %_3, i32 0, i32 0
  %3 = load i32, i32* %2, align 2
  %4 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %_3, i32 0, i32 1
  %5 = load i32, i32* %4, align 2
  %6 = call { i32, i32 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h41e18e6758f29b3aE"(i32 %3, i32 %5)
  %_2.0 = extractvalue { i32, i32 } %6, 0
  %_2.1 = extractvalue { i32, i32 } %6, 1
  br label %bb1

bb1:                                              ; preds = %start
  %7 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %iter, i32 0, i32 0
  store i32 %_2.0, i32* %7, align 2
  %8 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %iter, i32 0, i32 1
  store i32 %_2.1, i32* %8, align 2
  br label %bb2

bb2:                                              ; preds = %bb6, %bb1
  %9 = call { i16, i32 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h6b75dcd3ad340ce9E"({ i32, i32 }* align 2 dereferenceable(8) %iter)
  store { i16, i32 } %9, { i16, i32 }* %_6, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %10 = bitcast { i16, i32 }* %_6 to i16*
  %_9 = load i16, i16* %10, align 2, !range !0
  switch i16 %_9, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  ret i16 0

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %11 = bitcast { i16, i32 }* %_6 to %"core::option::Option<i32>::Some"*
  %12 = getelementptr inbounds %"core::option::Option<i32>::Some", %"core::option::Option<i32>::Some"* %11, i32 0, i32 1
  %val = load i32, i32* %12, align 2
  %13 = load i32, i32* %reg, align 2
  %14 = add i32 %13, 1
  store i32 %14, i32* %reg, align 2
  br label %bb2
}

; Function Attrs: nounwind
define internal { i32, i32 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h41e18e6758f29b3aE"(i32 %self.0, i32 %self.1) unnamed_addr #0 {
start:
  %0 = insertvalue { i32, i32 } undef, i32 %self.0, 0
  %1 = insertvalue { i32, i32 } %0, i32 %self.1, 1
  ret { i32, i32 } %1
}

; Function Attrs: inlinehint nounwind
define internal { i16, i32 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h6b75dcd3ad340ce9E"({ i32, i32 }* align 2 dereferenceable(8) %self) unnamed_addr #1 {
start:
  %0 = alloca { i16, i32 }, align 2
  %_3 = bitcast { i32, i32 }* %self to i32*
  %_4 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %self, i32 0, i32 1
  %_2 = call zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$i32$GT$2lt17h8231edc782b09ea6E"(i32* noalias readonly align 2 dereferenceable(4) %_3, i32* noalias readonly align 2 dereferenceable(4) %_4)
  br label %bb1

bb1:                                              ; preds = %start
  br i1 %_2, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  %1 = bitcast { i16, i32 }* %0 to i16*
  store i16 0, i16* %1, align 2
  br label %bb7

bb3:                                              ; preds = %bb1
  %_7 = bitcast { i32, i32 }* %self to i32*
  %_6 = call i32 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$i32$GT$5clone17h1649dbcc2f687d03E"(i32* noalias readonly align 2 dereferenceable(4) %_7)
  br label %bb4

bb4:                                              ; preds = %bb3
  %n = call i32 @"_ZN47_$LT$i32$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17he08b4a82e004cee7E"(i32 %_6, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  %_10 = bitcast { i32, i32 }* %self to i32*
  %_8 = call i32 @_ZN4core3mem7replace17h37483f7b0028c436E(i32* align 2 dereferenceable(4) %_10, i32 %n)
  br label %bb6

bb6:                                              ; preds = %bb5
  %2 = bitcast { i16, i32 }* %0 to %"core::option::Option<i32>::Some"*
  %3 = getelementptr inbounds %"core::option::Option<i32>::Some", %"core::option::Option<i32>::Some"* %2, i32 0, i32 1
  store i32 %_8, i32* %3, align 2
  %4 = bitcast { i16, i32 }* %0 to i16*
  store i16 1, i16* %4, align 2
  br label %bb7

bb7:                                              ; preds = %bb6, %bb2
  %5 = getelementptr inbounds { i16, i32 }, { i16, i32 }* %0, i32 0, i32 0
  %6 = load i16, i16* %5, align 2, !range !0
  %7 = getelementptr inbounds { i16, i32 }, { i16, i32 }* %0, i32 0, i32 1
  %8 = load i32, i32* %7, align 2
  %9 = insertvalue { i16, i32 } undef, i16 %6, 0
  %10 = insertvalue { i16, i32 } %9, i32 %8, 1
  ret { i16, i32 } %10
}

; Function Attrs: inlinehint nounwind
define internal zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$i32$GT$2lt17h8231edc782b09ea6E"(i32* noalias readonly align 2 dereferenceable(4) %self, i32* noalias readonly align 2 dereferenceable(4) %other) unnamed_addr #1 {
start:
  %_3 = load i32, i32* %self, align 2
  %_4 = load i32, i32* %other, align 2
  %0 = icmp slt i32 %_3, %_4
  ret i1 %0
}

; Function Attrs: inlinehint nounwind
define internal i32 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$i32$GT$5clone17h1649dbcc2f687d03E"(i32* noalias readonly align 2 dereferenceable(4) %self) unnamed_addr #1 {
start:
  %0 = load i32, i32* %self, align 2
  ret i32 %0
}

; Function Attrs: inlinehint nounwind
define internal i32 @"_ZN47_$LT$i32$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17he08b4a82e004cee7E"(i32 %start1, i16 %n) unnamed_addr #1 {
start:
  %_4 = zext i16 %n to i32
  %0 = call i32 @"_ZN4core3num21_$LT$impl$u20$i32$GT$13unchecked_add17hf5337dea445375b2E"(i32 %start1, i32 %_4)
  br label %bb1

bb1:                                              ; preds = %start
  ret i32 %0
}

; Function Attrs: inlinehint nounwind
define internal i32 @_ZN4core3mem7replace17h37483f7b0028c436E(i32* align 2 dereferenceable(4) %dest, i32) unnamed_addr #1 {
start:
  %src = alloca i32, align 2
  store i32 %0, i32* %src, align 2
  call void @_ZN4core3mem4swap17h76a28188f01f1332E(i32* align 2 dereferenceable(4) %dest, i32* align 2 dereferenceable(4) %src)
  br label %bb1

bb1:                                              ; preds = %start
  %1 = load i32, i32* %src, align 2
  ret i32 %1
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3mem4swap17h76a28188f01f1332E(i32* align 2 dereferenceable(4) %x, i32* align 2 dereferenceable(4) %y) unnamed_addr #1 {
start:
  call void @_ZN4core3ptr23swap_nonoverlapping_one17h631cfaca2ab52985E(i32* %x, i32* %y)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr23swap_nonoverlapping_one17h631cfaca2ab52985E(i32* %x, i32* %y) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %1 = alloca {}, align 1
  store i16 4, i16* %0, align 2
  %2 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %_3 = icmp ult i16 %2, 32
  br i1 %_3, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  call void @_ZN4core3ptr19swap_nonoverlapping17heb25c7a7a15584f0E(i32* %x, i32* %y, i16 1)
  br label %bb7

bb3:                                              ; preds = %bb1
  %z = call i32 @_ZN4core3ptr4read17h59556c6536a927e6E(i32* %x)
  br label %bb4

bb4:                                              ; preds = %bb3
  call void @_ZN4core10intrinsics19copy_nonoverlapping17h20d2b501fd65a041E(i32* %y, i32* %x, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  call void @_ZN4core3ptr5write17h7d6eff9d0cb2b9bfE(i32* %y, i32 %z)
  br label %bb6

bb6:                                              ; preds = %bb5
  br label %bb8

bb7:                                              ; preds = %bb2
  br label %bb8

bb8:                                              ; preds = %bb7, %bb6
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr19swap_nonoverlapping17heb25c7a7a15584f0E(i32* %x, i32* %y, i16 %count) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %x1 = bitcast i32* %x to i8*
  %y2 = bitcast i32* %y to i8*
  store i16 4, i16* %0, align 2
  %1 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %len = mul i16 %1, %count
  call void @_ZN4core3ptr25swap_nonoverlapping_bytes17hc62e6330119b0c6dE(i8* %x1, i8* %y2, i16 %len)
  br label %bb2

bb2:                                              ; preds = %bb1
  ret void
}

; Function Attrs: inlinehint nounwind
define internal i32 @_ZN4core3ptr4read17h59556c6536a927e6E(i32* %src) unnamed_addr #1 {
start:
  %0 = alloca i32, align 2
  %tmp = alloca i32, align 2
  %1 = bitcast i32* %0 to {}*
  %2 = load i32, i32* %0, align 2
  store i32 %2, i32* %tmp, align 2
  br label %bb1

bb1:                                              ; preds = %start
  br label %bb2

bb2:                                              ; preds = %bb1
  call void @_ZN4core10intrinsics19copy_nonoverlapping17h20d2b501fd65a041E(i32* %src, i32* %tmp, i16 1)
  br label %bb3

bb3:                                              ; preds = %bb2
  %_7 = load i32, i32* %tmp, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  ret i32 %_7
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core10intrinsics19copy_nonoverlapping17h20d2b501fd65a041E(i32* %src, i32* %dst, i16 %count) unnamed_addr #1 {
start:
  %0 = mul i16 4, %count
  %1 = bitcast i32* %dst to i8*
  %2 = bitcast i32* %src to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 2 %1, i8* align 2 %2, i16 %0, i1 false)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr5write17h7d6eff9d0cb2b9bfE(i32* %dst, i32 %src) unnamed_addr #1 {
start:
  %0 = alloca {}, align 1
  store i32 %src, i32* %dst, align 2
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i16(i8* nocapture writeonly, i8* nocapture readonly, i16, i1 immarg) #2

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr25swap_nonoverlapping_bytes17hc62e6330119b0c6dE(i8* %x, i8* %y, i16 %len) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %t1 = alloca %"core::mem::maybe_uninit::MaybeUninit<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>", align 2
  %t = alloca <4 x i64>, align 32
  %i = alloca i16, align 2
  %1 = alloca {}, align 1
  store i16 32, i16* %0, align 2
  %2 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  store i16 0, i16* %i, align 2
  br label %bb2

bb2:                                              ; preds = %bb11, %bb1
  %_8 = load i16, i16* %i, align 2
  %_7 = add i16 %_8, %2
  %_6 = icmp ule i16 %_7, %len
  br i1 %_6, label %bb4, label %bb3

bb3:                                              ; preds = %bb2
  %_38 = load i16, i16* %i, align 2
  %_37 = icmp ult i16 %_38, %len
  br i1 %_37, label %bb13, label %bb12

bb4:                                              ; preds = %bb2
  %3 = bitcast <4 x i64>* %t to {}*
  br label %bb5

bb5:                                              ; preds = %bb4
  br label %bb6

bb6:                                              ; preds = %bb5
  %t2 = bitcast <4 x i64>* %t to i8*
  %_17 = load i16, i16* %i, align 2
  %x3 = call i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$3add17h02212dc06e61a034E"(i8* %x, i16 %_17)
  br label %bb7

bb7:                                              ; preds = %bb6
  %_20 = load i16, i16* %i, align 2
  %y4 = call i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$3add17h02212dc06e61a034E"(i8* %y, i16 %_20)
  br label %bb8

bb8:                                              ; preds = %bb7
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %x3, i8* %t2, i16 %2)
  br label %bb9

bb9:                                              ; preds = %bb8
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %y4, i8* %x3, i16 %2)
  br label %bb10

bb10:                                             ; preds = %bb9
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %t2, i8* %y4, i16 %2)
  br label %bb11

bb11:                                             ; preds = %bb10
  %4 = load i16, i16* %i, align 2
  %5 = add i16 %4, %2
  store i16 %5, i16* %i, align 2
  br label %bb2

bb12:                                             ; preds = %bb3
  br label %bb21

bb13:                                             ; preds = %bb3
  %6 = bitcast %"core::mem::maybe_uninit::MaybeUninit<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>"* %t1 to {}*
  br label %bb14

bb14:                                             ; preds = %bb13
  %_43 = load i16, i16* %i, align 2
  %rem = sub i16 %len, %_43
  %_4.i = bitcast %"core::mem::maybe_uninit::MaybeUninit<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>"* %t1 to %"core::mem::manually_drop::ManuallyDrop<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>"*
  %_3.i.i = bitcast %"core::mem::manually_drop::ManuallyDrop<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>"* %_4.i to %"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock"*
  br label %bb15

bb15:                                             ; preds = %bb14
  %t5 = bitcast %"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock"* %_3.i.i to i8*
  %_49 = load i16, i16* %i, align 2
  %x6 = call i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$3add17h02212dc06e61a034E"(i8* %x, i16 %_49)
  br label %bb16

bb16:                                             ; preds = %bb15
  %_52 = load i16, i16* %i, align 2
  %y7 = call i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$3add17h02212dc06e61a034E"(i8* %y, i16 %_52)
  br label %bb17

bb17:                                             ; preds = %bb16
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %x6, i8* %t5, i16 %rem)
  br label %bb18

bb18:                                             ; preds = %bb17
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %y7, i8* %x6, i16 %rem)
  br label %bb19

bb19:                                             ; preds = %bb18
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %t5, i8* %y7, i16 %rem)
  br label %bb20

bb20:                                             ; preds = %bb19
  br label %bb21

bb21:                                             ; preds = %bb20, %bb12
  ret void
}

; Function Attrs: inlinehint nounwind
define internal i32 @"_ZN4core3num21_$LT$impl$u20$i32$GT$13unchecked_add17hf5337dea445375b2E"(i32 %self, i32 %rhs) unnamed_addr #1 {
start:
  %0 = alloca i32, align 2
  %1 = add nsw i32 %self, %rhs
  store i32 %1, i32* %0, align 2
  %2 = load i32, i32* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  ret i32 %2
}

; Function Attrs: nounwind
define internal i16 @_ZN10greenhouse9adcSample17hfec5df1cf603bdcaE(i16 %count) unnamed_addr #0 {
start:
  call void @start_atomic()
  br label %bb1

bb1:                                              ; preds = %start
  %_4 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [6 x i8] }>* @alloc5 to [0 x i8]*), i16 6)
  br label %bb2

bb2:                                              ; preds = %bb1
  call void (i8*, ...) @printf(i8* %_4)
  br label %bb3

bb3:                                              ; preds = %bb2
  call void @end_atomic()
  br label %bb4

bb4:                                              ; preds = %bb3
  %_9 = urem i16 %count, 17
  %0 = add i16 1000, %_9
  ret i16 %0
}

; Function Attrs: nounwind
declare void @start_atomic() unnamed_addr #0

; Function Attrs: nounwind
declare void @printf(i8*, ...) unnamed_addr #0

; Function Attrs: nounwind
declare void @end_atomic() unnamed_addr #0

; Function Attrs: nounwind
define internal i16 @_ZN10greenhouse10tempConfig17h27e1101ef9551221E() unnamed_addr #0 {
start:
  %_6 = alloca { i16, i32 }, align 2
  %iter = alloca { i32, i32 }, align 2
  %_3 = alloca { i32, i32 }, align 2
  %reg = alloca i32, align 2
  store i32 0, i32* %reg, align 2
  %0 = bitcast { i32, i32 }* %_3 to i32*
  store i32 0, i32* %0, align 2
  %1 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %_3, i32 0, i32 1
  store i32 40, i32* %1, align 2
  %2 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %_3, i32 0, i32 0
  %3 = load i32, i32* %2, align 2
  %4 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %_3, i32 0, i32 1
  %5 = load i32, i32* %4, align 2
  %6 = call { i32, i32 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h41e18e6758f29b3aE"(i32 %3, i32 %5)
  %_2.0 = extractvalue { i32, i32 } %6, 0
  %_2.1 = extractvalue { i32, i32 } %6, 1
  br label %bb1

bb1:                                              ; preds = %start
  %7 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %iter, i32 0, i32 0
  store i32 %_2.0, i32* %7, align 2
  %8 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %iter, i32 0, i32 1
  store i32 %_2.1, i32* %8, align 2
  br label %bb2

bb2:                                              ; preds = %bb6, %bb1
  %9 = call { i16, i32 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h6b75dcd3ad340ce9E"({ i32, i32 }* align 2 dereferenceable(8) %iter)
  store { i16, i32 } %9, { i16, i32 }* %_6, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %10 = bitcast { i16, i32 }* %_6 to i16*
  %_9 = load i16, i16* %10, align 2, !range !0
  switch i16 %_9, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  ret i16 0

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %11 = bitcast { i16, i32 }* %_6 to %"core::option::Option<i32>::Some"*
  %12 = getelementptr inbounds %"core::option::Option<i32>::Some", %"core::option::Option<i32>::Some"* %11, i32 0, i32 1
  %val = load i32, i32* %12, align 2
  %13 = load i32, i32* %reg, align 2
  %14 = add i32 %13, 1
  store i32 %14, i32* %reg, align 2
  br label %bb2
}

; Function Attrs: nounwind
define internal float @_ZN10greenhouse8tempDegC17h8ab38ebf75b0d3b5E(i16 %count) unnamed_addr #0 {
start:
  call void @start_atomic()
  br label %bb1

bb1:                                              ; preds = %start
  %_4 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [7 x i8] }>* @alloc6 to [0 x i8]*), i16 7)
  br label %bb2

bb2:                                              ; preds = %bb1
  call void (i8*, ...) @printf(i8* %_4)
  br label %bb3

bb3:                                              ; preds = %bb2
  call void @end_atomic()
  br label %bb4

bb4:                                              ; preds = %bb3
  %_9 = uitofp i16 %count to float
  %0 = fadd float 0x4012CCCCC0000000, %_9
  ret float %0
}

; Function Attrs: nounwind
define void @_entry() unnamed_addr #0 {
start:
  call void @app()
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: nounwind
define void @app() unnamed_addr #0 {
start:
  %moistTempAvgLocal = alloca { i16, float }, align 2
  %_41 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_38 = alloca { i16, i16 }, align 2
  br label %bb1

bb1:                                              ; preds = %bb20, %start
  %0 = bitcast { i16, i16 }* %_38 to i16*
  store i16 0, i16* %0, align 2
  %1 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_38, i32 0, i32 1
  store i16 40, i16* %1, align 2
  %2 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_38, i32 0, i32 0
  %3 = load i16, i16* %2, align 2
  %4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_38, i32 0, i32 1
  %5 = load i16, i16* %4, align 2
  %6 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h52c9e0b912e6db79E"(i16 %3, i16 %5)
  %_37.0 = extractvalue { i16, i16 } %6, 0
  %_37.1 = extractvalue { i16, i16 } %6, 1
  br label %bb2

bb2:                                              ; preds = %bb1
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_37.0, i16* %7, align 2
  %8 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_37.1, i16* %8, align 2
  br label %bb3

bb3:                                              ; preds = %bb18, %bb2
  %9 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h660f690e6e8ca6c5E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %9, { i16, i16 }* %_41, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  %10 = bitcast { i16, i16 }* %_41 to i16*
  %_44 = load i16, i16* %10, align 2, !range !0
  switch i16 %_44, label %bb6 [
    i16 0, label %bb5
    i16 1, label %bb7
  ]

bb5:                                              ; preds = %bb4
  call void @gpioTwiddle()
  br label %bb19

bb6:                                              ; preds = %bb4
  unreachable

bb7:                                              ; preds = %bb4
  %11 = bitcast { i16, i16 }* %_41 to %"core::option::Option<u16>::Some"*
  %12 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %11, i32 0, i32 1
  %val = load i16, i16* %12, align 2
  call void @atomic_start()
  %13 = load volatile i16, i16* @atomic_depth
  %14 = icmp eq i16 0, %13
  br i1 %14, label %bb7.split1, label %bb7.split

bb7.split1:                                       ; preds = %bb7
  %15 = load <{ [10 x i8] }>, <{ [10 x i8] }>* @_ZN10greenhouse3app8MOISTURE17h8897597179d69b14E
  store <{ [10 x i8] }> %15, <{ [10 x i8] }>* @_ZN10greenhouse3app8MOISTURE17h8897597179d69b14E_bak
  %16 = bitcast <{ [10 x i8] }>* @_ZN10greenhouse3app8MOISTURE17h8897597179d69b14E to i8*
  %17 = bitcast <{ [10 x i8] }>* @_ZN10greenhouse3app8MOISTURE17h8897597179d69b14E_bak to i8*
  %18 = getelementptr inbounds <{ [10 x i8] }>, <{ [10 x i8] }>* null, i16 1
  %19 = ptrtoint <{ [10 x i8] }>* %18 to i16
  call void @log_entry(i8* %16, i8* %17, i16 %19)
  %20 = load <{ [20 x i8] }>, <{ [20 x i8] }>* @_ZN10greenhouse3app11TEMPERATURE17hfb400d8a3f5f6cbaE
  store <{ [20 x i8] }> %20, <{ [20 x i8] }>* @_ZN10greenhouse3app11TEMPERATURE17hfb400d8a3f5f6cbaE_bak
  %21 = bitcast <{ [20 x i8] }>* @_ZN10greenhouse3app11TEMPERATURE17hfb400d8a3f5f6cbaE to i8*
  %22 = bitcast <{ [20 x i8] }>* @_ZN10greenhouse3app11TEMPERATURE17hfb400d8a3f5f6cbaE_bak to i8*
  %23 = getelementptr inbounds <{ [20 x i8] }>, <{ [20 x i8] }>* null, i16 1
  %24 = ptrtoint <{ [20 x i8] }>* %23 to i16
  call void @log_entry(i8* %21, i8* %22, i16 %24)
  %25 = load <{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE117h9ceb247d33710457E
  store <{ [1 x i8] }> %25, <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE117h9ceb247d33710457E_bak
  %26 = bitcast <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE117h9ceb247d33710457E to i8*
  %27 = bitcast <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE117h9ceb247d33710457E_bak to i8*
  %28 = getelementptr inbounds <{ [1 x i8] }>, <{ [1 x i8] }>* null, i16 1
  %29 = ptrtoint <{ [1 x i8] }>* %28 to i16
  call void @log_entry(i8* %26, i8* %27, i16 %29)
  %30 = load <{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE217hdfe04dfa897f740aE
  store <{ [1 x i8] }> %30, <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE217hdfe04dfa897f740aE_bak
  %31 = bitcast <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE217hdfe04dfa897f740aE to i8*
  %32 = bitcast <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE217hdfe04dfa897f740aE_bak to i8*
  %33 = getelementptr inbounds <{ [1 x i8] }>, <{ [1 x i8] }>* null, i16 1
  %34 = ptrtoint <{ [1 x i8] }>* %33 to i16
  call void @log_entry(i8* %31, i8* %32, i16 %34)
  br label %bb7.split

bb7.split:                                        ; preds = %bb7, %bb7.split1
  %init = call i16 @_ZN10greenhouse9adcConfig17h1a9fbeb697d52057E()
  br label %bb8

bb8:                                              ; preds = %bb7.split
  br label %bb9

bb9:                                              ; preds = %bb8
  %_51 = call i16 @_ZN10greenhouse9adcSample17hfec5df1cf603bdcaE(i16 %val)
  br label %bb10

bb10:                                             ; preds = %bb9
  store i16 %_51, i16* bitcast (<{ [2 x i8] }>* @_ZN10greenhouse3app5MOIST17h959cb7d1bbbb882bE to i16*), align 2
  %35 = load i8, i8* getelementptr inbounds (<{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE117h9ceb247d33710457E, i32 0, i32 0, i32 0), align 1
  %36 = add i8 %35, 1
  store i8 %36, i8* getelementptr inbounds (<{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE117h9ceb247d33710457E, i32 0, i32 0, i32 0), align 1
  %init2 = call i16 @_ZN10greenhouse10tempConfig17h27e1101ef9551221E()
  br label %bb11

bb11:                                             ; preds = %bb10
  br label %bb12

bb12:                                             ; preds = %bb11
  %_56 = call float @_ZN10greenhouse8tempDegC17h8ab38ebf75b0d3b5E(i16 %val)
  br label %bb13

bb13:                                             ; preds = %bb12
  store float %_56, float* bitcast (<{ [4 x i8] }>* @_ZN10greenhouse3app4TEMP17h50e2fb0948c59ac1E to float*), align 2
  %37 = load i8, i8* getelementptr inbounds (<{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE217hdfe04dfa897f740aE, i32 0, i32 0, i32 0), align 1
  %38 = add i8 %37, 1
  store i8 %38, i8* getelementptr inbounds (<{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE217hdfe04dfa897f740aE, i32 0, i32 0, i32 0), align 1
  %_59 = load i16, i16* bitcast (<{ [2 x i8] }>* @_ZN10greenhouse3app5MOIST17h959cb7d1bbbb882bE to i16*), align 2
  %_60 = load float, float* bitcast (<{ [4 x i8] }>* @_ZN10greenhouse3app4TEMP17h50e2fb0948c59ac1E to float*), align 2
  call void @_ZN10greenhouse9storeData17h503a7bfc9f3bb8a0E(i16 %_59, float %_60, [0 x i16]* nonnull align 2 bitcast (<{ [10 x i8] }>* @_ZN10greenhouse3app8MOISTURE17h8897597179d69b14E to [0 x i16]*), i16 5, [0 x float]* nonnull align 2 bitcast (<{ [20 x i8] }>* @_ZN10greenhouse3app11TEMPERATURE17hfb400d8a3f5f6cbaE to [0 x float]*), i16 5)
  call void @atomic_end()
  br label %bb14

bb14:                                             ; preds = %bb13
  %39 = call { i16, float } @_ZN10greenhouse7calcAvg17h19ed4c9ba7aa5a53E([0 x i16]* noalias nonnull readonly align 2 bitcast (<{ [10 x i8] }>* @_ZN10greenhouse3app8MOISTURE17h8897597179d69b14E to [0 x i16]*), i16 5, [0 x float]* noalias nonnull readonly align 2 bitcast (<{ [20 x i8] }>* @_ZN10greenhouse3app11TEMPERATURE17hfb400d8a3f5f6cbaE to [0 x float]*), i16 5)
  store { i16, float } %39, { i16, float }* %moistTempAvgLocal, align 2
  br label %bb15

bb15:                                             ; preds = %bb14
  br label %bb16

bb16:                                             ; preds = %bb15
  %40 = bitcast { i16, float }* %moistTempAvgLocal to i16*
  %_72 = load i16, i16* %40, align 2
  store i16 %_72, i16* getelementptr inbounds ({ i16, float }, { i16, float }* bitcast (<{ [6 x i8] }>* @_ZN10greenhouse3app3AVG17hdf1ec3a33bfd291dE to { i16, float }*), i32 0, i32 0), align 2
  %41 = getelementptr inbounds { i16, float }, { i16, float }* %moistTempAvgLocal, i32 0, i32 1
  %_73 = load float, float* %41, align 2
  store float %_73, float* getelementptr inbounds ({ i16, float }, { i16, float }* bitcast (<{ [6 x i8] }>* @_ZN10greenhouse3app3AVG17hdf1ec3a33bfd291dE to { i16, float }*), i32 0, i32 1), align 2
  call void @_ZN10greenhouse7compute17had6512ee685a036fE({ i16, float }* noalias readonly align 2 dereferenceable(6) bitcast (<{ [6 x i8] }>* @_ZN10greenhouse3app3AVG17hdf1ec3a33bfd291dE to { i16, float }*))
  br label %bb17

bb17:                                             ; preds = %bb16
  %42 = load i8, i8* getelementptr inbounds (<{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app8COMPUTEC17h57840fa4e15d44e7E, i32 0, i32 0, i32 0), align 1
  %43 = add i8 %42, 1
  store i8 %43, i8* getelementptr inbounds (<{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app8COMPUTEC17h57840fa4e15d44e7E, i32 0, i32 0, i32 0), align 1
  call void @_ZN10greenhouse8sendData17h9f3f8485c57ddb59E({ i16, float }* noalias readonly align 2 dereferenceable(6) bitcast (<{ [6 x i8] }>* @_ZN10greenhouse3app3AVG17hdf1ec3a33bfd291dE to { i16, float }*))
  br label %bb18

bb18:                                             ; preds = %bb17
  %44 = load i8, i8* getelementptr inbounds (<{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app5SENDC17h9bde036371f22910E, i32 0, i32 0, i32 0), align 1
  %45 = add i8 %44, 1
  store i8 %45, i8* getelementptr inbounds (<{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app5SENDC17h9bde036371f22910E, i32 0, i32 0, i32 0), align 1
  br label %bb3

bb19:                                             ; preds = %bb5
  call void @gpioTwiddle()
  br label %bb20

bb20:                                             ; preds = %bb19
  store i8 0, i8* getelementptr inbounds (<{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE117h9ceb247d33710457E, i32 0, i32 0, i32 0), align 1
  store i8 0, i8* getelementptr inbounds (<{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app6SENSE217hdfe04dfa897f740aE, i32 0, i32 0, i32 0), align 1
  store i8 0, i8* getelementptr inbounds (<{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app8COMPUTEC17h57840fa4e15d44e7E, i32 0, i32 0, i32 0), align 1
  store i8 0, i8* getelementptr inbounds (<{ [1 x i8] }>, <{ [1 x i8] }>* @_ZN10greenhouse3app5SENDC17h9bde036371f22910E, i32 0, i32 0, i32 0), align 1
  br label %bb1
}

; Function Attrs: nounwind
define internal { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h52c9e0b912e6db79E"(i16 %self.0, i16 %self.1) unnamed_addr #0 {
start:
  %0 = insertvalue { i16, i16 } undef, i16 %self.0, 0
  %1 = insertvalue { i16, i16 } %0, i16 %self.1, 1
  ret { i16, i16 } %1
}

; Function Attrs: inlinehint nounwind
define internal { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h660f690e6e8ca6c5E"({ i16, i16 }* align 2 dereferenceable(4) %self) unnamed_addr #1 {
start:
  %0 = alloca { i16, i16 }, align 2
  %_3 = bitcast { i16, i16 }* %self to i16*
  %_4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %self, i32 0, i32 1
  %_2 = call zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$u16$GT$2lt17h45e86538b2c7ae77E"(i16* noalias readonly align 2 dereferenceable(2) %_3, i16* noalias readonly align 2 dereferenceable(2) %_4)
  br label %bb1

bb1:                                              ; preds = %start
  br i1 %_2, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  %1 = bitcast { i16, i16 }* %0 to i16*
  store i16 0, i16* %1, align 2
  br label %bb7

bb3:                                              ; preds = %bb1
  %_7 = bitcast { i16, i16 }* %self to i16*
  %_6 = call i16 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$u16$GT$5clone17h289b7d0947ca11d9E"(i16* noalias readonly align 2 dereferenceable(2) %_7)
  br label %bb4

bb4:                                              ; preds = %bb3
  %n = call i16 @"_ZN47_$LT$u16$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17hea835907cbd96f68E"(i16 %_6, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  %_10 = bitcast { i16, i16 }* %self to i16*
  %_8 = call i16 @_ZN4core3mem7replace17h44d2c0ca8214fc8eE(i16* align 2 dereferenceable(2) %_10, i16 %n)
  br label %bb6

bb6:                                              ; preds = %bb5
  %2 = bitcast { i16, i16 }* %0 to %"core::option::Option<u16>::Some"*
  %3 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %2, i32 0, i32 1
  store i16 %_8, i16* %3, align 2
  %4 = bitcast { i16, i16 }* %0 to i16*
  store i16 1, i16* %4, align 2
  br label %bb7

bb7:                                              ; preds = %bb6, %bb2
  %5 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %0, i32 0, i32 0
  %6 = load i16, i16* %5, align 2, !range !0
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %0, i32 0, i32 1
  %8 = load i16, i16* %7, align 2
  %9 = insertvalue { i16, i16 } undef, i16 %6, 0
  %10 = insertvalue { i16, i16 } %9, i16 %8, 1
  ret { i16, i16 } %10
}

; Function Attrs: nounwind
declare void @gpioTwiddle() unnamed_addr #0

; Function Attrs: nounwind
define void @atomic_start() unnamed_addr #0 {
start:
  %local = load i16, i16* @atomic_depth, align 2
  call void @start_atomic()
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

declare void @log_entry(i8*, i8*, i16)

; Function Attrs: nounwind
define internal void @_ZN10greenhouse9storeData17h503a7bfc9f3bb8a0E(i16 %m, float %t, [0 x i16]* nonnull align 2 %moisture.0, i16 %moisture.1, [0 x float]* nonnull align 2 %temperature.0, i16 %temperature.1) unnamed_addr #0 {
start:
  %_9 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_6 = alloca { i16, i16 }, align 2
  %0 = bitcast { i16, i16 }* %_6 to i16*
  store i16 1, i16* %0, align 2
  %1 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_6, i32 0, i32 1
  store i16 5, i16* %1, align 2
  %2 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_6, i32 0, i32 0
  %3 = load i16, i16* %2, align 2
  %4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_6, i32 0, i32 1
  %5 = load i16, i16* %4, align 2
  %6 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h820c98c80fab166dE"(i16 %3, i16 %5)
  %_5.0 = extractvalue { i16, i16 } %6, 0
  %_5.1 = extractvalue { i16, i16 } %6, 1
  br label %bb1

bb1:                                              ; preds = %start
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_5.0, i16* %7, align 2
  %8 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_5.1, i16* %8, align 2
  br label %bb2

bb2:                                              ; preds = %bb10, %bb1
  %9 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %9, { i16, i16 }* %_9, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %10 = bitcast { i16, i16 }* %_9 to i16*
  %_12 = load i16, i16* %10, align 2, !range !0
  switch i16 %_12, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  %_35 = icmp ult i16 0, %moisture.1
  %11 = call i1 @llvm.expect.i1(i1 %_35, i1 true)
  br i1 %11, label %bb11, label %panic4

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %12 = bitcast { i16, i16 }* %_9 to %"core::option::Option<u16>::Some"*
  %13 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %12, i32 0, i32 1
  %val = load i16, i16* %13, align 2
  %_17 = sub i16 %val, 1
  %_20 = icmp ult i16 %_17, %moisture.1
  %14 = call i1 @llvm.expect.i1(i1 %_20, i1 true)
  br i1 %14, label %bb7, label %panic

bb7:                                              ; preds = %bb6
  %15 = getelementptr inbounds [0 x i16], [0 x i16]* %moisture.0, i16 0, i16 %_17
  %_16 = load i16, i16* %15, align 2
  %_23 = icmp ult i16 %val, %moisture.1
  %16 = call i1 @llvm.expect.i1(i1 %_23, i1 true)
  br i1 %16, label %bb8, label %panic1

bb8:                                              ; preds = %bb7
  %17 = getelementptr inbounds [0 x i16], [0 x i16]* %moisture.0, i16 0, i16 %val
  store i16 %_16, i16* %17, align 2
  %_25 = sub i16 %val, 1
  %_28 = icmp ult i16 %_25, %temperature.1
  %18 = call i1 @llvm.expect.i1(i1 %_28, i1 true)
  br i1 %18, label %bb9, label %panic2

bb9:                                              ; preds = %bb8
  %19 = getelementptr inbounds [0 x float], [0 x float]* %temperature.0, i16 0, i16 %_25
  %_24 = load float, float* %19, align 2
  %_31 = icmp ult i16 %val, %temperature.1
  %20 = call i1 @llvm.expect.i1(i1 %_31, i1 true)
  br i1 %20, label %bb10, label %panic3

bb10:                                             ; preds = %bb9
  %21 = getelementptr inbounds [0 x float], [0 x float]* %temperature.0, i16 0, i16 %val
  store float %_24, float* %21, align 2
  br label %bb2

bb11:                                             ; preds = %bb4
  %22 = getelementptr inbounds [0 x i16], [0 x i16]* %moisture.0, i16 0, i16 0
  store i16 %m, i16* %22, align 2
  %_39 = icmp ult i16 0, %temperature.1
  %23 = call i1 @llvm.expect.i1(i1 %_39, i1 true)
  br i1 %23, label %bb12, label %panic5

bb12:                                             ; preds = %bb11
  %24 = getelementptr inbounds [0 x float], [0 x float]* %temperature.0, i16 0, i16 0
  store float %t, float* %24, align 2
  ret void

panic:                                            ; preds = %bb6
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %_17, i16 %moisture.1, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc53 to %"core::panic::Location"*))
  unreachable

panic1:                                           ; preds = %bb7
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 %moisture.1, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc55 to %"core::panic::Location"*))
  unreachable

panic2:                                           ; preds = %bb8
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %_25, i16 %temperature.1, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc57 to %"core::panic::Location"*))
  unreachable

panic3:                                           ; preds = %bb9
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 %temperature.1, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc59 to %"core::panic::Location"*))
  unreachable

panic4:                                           ; preds = %bb4
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 0, i16 %moisture.1, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc61 to %"core::panic::Location"*))
  unreachable

panic5:                                           ; preds = %bb11
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 0, i16 %temperature.1, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc63 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define void @atomic_end() unnamed_addr #0 {
start:
  call void @end_atomic()
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: nounwind
define internal { i16, float } @_ZN10greenhouse7calcAvg17h19ed4c9ba7aa5a53E([0 x i16]* noalias nonnull readonly align 2 %moisture.0, i16 %moisture.1, [0 x float]* noalias nonnull readonly align 2 %temperature.0, i16 %temperature.1) unnamed_addr #0 {
start:
  %_7 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_4 = alloca { i16, i16 }, align 2
  %avg = alloca { i16, float }, align 2
  %0 = bitcast { i16, float }* %avg to i16*
  store i16 0, i16* %0, align 2
  %1 = getelementptr inbounds { i16, float }, { i16, float }* %avg, i32 0, i32 1
  store float 0.000000e+00, float* %1, align 2
  %2 = bitcast { i16, i16 }* %_4 to i16*
  store i16 0, i16* %2, align 2
  %3 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_4, i32 0, i32 1
  store i16 5, i16* %3, align 2
  %4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_4, i32 0, i32 0
  %5 = load i16, i16* %4, align 2
  %6 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_4, i32 0, i32 1
  %7 = load i16, i16* %6, align 2
  %8 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h820c98c80fab166dE"(i16 %5, i16 %7)
  %_3.0 = extractvalue { i16, i16 } %8, 0
  %_3.1 = extractvalue { i16, i16 } %8, 1
  br label %bb1

bb1:                                              ; preds = %start
  %9 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_3.0, i16* %9, align 2
  %10 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_3.1, i16* %10, align 2
  br label %bb2

bb2:                                              ; preds = %bb8, %bb1
  %11 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %11, { i16, i16 }* %_7, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %12 = bitcast { i16, i16 }* %_7 to i16*
  %_10 = load i16, i16* %12, align 2, !range !0
  switch i16 %_10, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  %13 = bitcast { i16, float }* %avg to i16*
  %_23 = load i16, i16* %13, align 2
  %14 = bitcast { i16, float }* %avg to i16*
  %15 = udiv i16 %_23, 5
  store i16 %15, i16* %14, align 2
  %16 = getelementptr inbounds { i16, float }, { i16, float }* %avg, i32 0, i32 1
  %_25 = load float, float* %16, align 2
  %17 = getelementptr inbounds { i16, float }, { i16, float }* %avg, i32 0, i32 1
  %18 = fdiv float %_25, 5.000000e+00
  store float %18, float* %17, align 2
  %19 = getelementptr inbounds { i16, float }, { i16, float }* %avg, i32 0, i32 0
  %20 = load i16, i16* %19, align 2
  %21 = getelementptr inbounds { i16, float }, { i16, float }* %avg, i32 0, i32 1
  %22 = load float, float* %21, align 2
  %23 = insertvalue { i16, float } undef, i16 %20, 0
  %24 = insertvalue { i16, float } %23, float %22, 1
  ret { i16, float } %24

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %25 = bitcast { i16, i16 }* %_7 to %"core::option::Option<u16>::Some"*
  %26 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %25, i32 0, i32 1
  %val = load i16, i16* %26, align 2
  %_17 = icmp ult i16 %val, %moisture.1
  %27 = call i1 @llvm.expect.i1(i1 %_17, i1 true)
  br i1 %27, label %bb7, label %panic

bb7:                                              ; preds = %bb6
  %28 = getelementptr inbounds [0 x i16], [0 x i16]* %moisture.0, i16 0, i16 %val
  %_14 = load i16, i16* %28, align 2
  %29 = bitcast { i16, float }* %avg to i16*
  %30 = bitcast { i16, float }* %avg to i16*
  %31 = load i16, i16* %30, align 2
  %32 = add i16 %31, %_14
  store i16 %32, i16* %29, align 2
  %33 = getelementptr inbounds { i16, float }, { i16, float }* %avg, i32 0, i32 1
  %_18 = load float, float* %33, align 2
  %_22 = icmp ult i16 %val, %temperature.1
  %34 = call i1 @llvm.expect.i1(i1 %_22, i1 true)
  br i1 %34, label %bb8, label %panic1

bb8:                                              ; preds = %bb7
  %35 = getelementptr inbounds [0 x float], [0 x float]* %temperature.0, i16 0, i16 %val
  %_19 = load float, float* %35, align 2
  %36 = getelementptr inbounds { i16, float }, { i16, float }* %avg, i32 0, i32 1
  %37 = fadd float %_18, %_19
  store float %37, float* %36, align 2
  br label %bb2

panic:                                            ; preds = %bb6
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 %moisture.1, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc49 to %"core::panic::Location"*))
  unreachable

panic1:                                           ; preds = %bb7
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 %temperature.1, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc51 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define internal void @_ZN10greenhouse7compute17had6512ee685a036fE({ i16, float }* noalias readonly align 2 dereferenceable(6) %avg) unnamed_addr #0 {
start:
  %_2 = alloca i8, align 1
  %0 = alloca {}, align 1
  %1 = getelementptr inbounds { i16, float }, { i16, float }* %avg, i32 0, i32 1
  %_4 = load float, float* %1, align 2
  %_3 = fcmp ogt float %_4, 1.000000e+01
  br i1 %_3, label %bb3, label %bb2

bb1:                                              ; preds = %bb3
  store i8 1, i8* %_2, align 1
  br label %bb4

bb2:                                              ; preds = %bb3, %start
  store i8 0, i8* %_2, align 1
  br label %bb4

bb3:                                              ; preds = %start
  %2 = getelementptr inbounds { i16, float }, { i16, float }* %avg, i32 0, i32 1
  %_6 = load float, float* %2, align 2
  %_5 = fcmp olt float %_6, 2.200000e+01
  br i1 %_5, label %bb1, label %bb2

bb4:                                              ; preds = %bb2, %bb1
  %3 = load i8, i8* %_2, align 1, !range !1
  %4 = trunc i8 %3 to i1
  br i1 %4, label %bb6, label %bb5

bb5:                                              ; preds = %bb4
  %5 = getelementptr inbounds { i16, float }, { i16, float }* %avg, i32 0, i32 1
  %_9 = load float, float* %5, align 2
  %_8 = fcmp oge float %_9, 2.200000e+01
  br i1 %_8, label %bb9, label %bb8

bb6:                                              ; preds = %bb4
  call void @gpioOneTwiddle()
  br label %bb7

bb7:                                              ; preds = %bb6
  br label %bb16

bb8:                                              ; preds = %bb5
  call void @gpioOneTwiddle()
  br label %bb12

bb9:                                              ; preds = %bb5
  call void @gpioOneTwiddle()
  br label %bb10

bb10:                                             ; preds = %bb9
  call void @gpioOneTwiddle()
  br label %bb11

bb11:                                             ; preds = %bb10
  br label %bb15

bb12:                                             ; preds = %bb8
  call void @gpioOneTwiddle()
  br label %bb13

bb13:                                             ; preds = %bb12
  call void @gpioOneTwiddle()
  br label %bb14

bb14:                                             ; preds = %bb13
  br label %bb15

bb15:                                             ; preds = %bb14, %bb11
  br label %bb16

bb16:                                             ; preds = %bb15, %bb7
  ret void
}

; Function Attrs: nounwind
define internal void @_ZN10greenhouse8sendData17h9f3f8485c57ddb59E({ i16, float }* noalias readonly align 2 dereferenceable(6) %data) unnamed_addr #0 {
start:
  %i = alloca i16, align 2
  store i16 0, i16* %i, align 2
  br label %bb1

bb1:                                              ; preds = %bb3, %start
  %_4 = load i16, i16* %i, align 2
  %_3 = icmp ult i16 %_4, 3000
  br i1 %_3, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  ret void

bb3:                                              ; preds = %bb1
  %0 = load i16, i16* %i, align 2
  %1 = add i16 %0, 1
  store i16 %1, i16* %i, align 2
  br label %bb1
}

; Function Attrs: nounwind
declare void @gpioOneTwiddle() unnamed_addr #0

; Function Attrs: nounwind readnone
declare i1 @llvm.expect.i1(i1, i1) #3

; Function Attrs: inlinehint nounwind
define internal zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$u16$GT$2lt17h45e86538b2c7ae77E"(i16* noalias readonly align 2 dereferenceable(2) %self, i16* noalias readonly align 2 dereferenceable(2) %other) unnamed_addr #1 {
start:
  %_3 = load i16, i16* %self, align 2
  %_4 = load i16, i16* %other, align 2
  %0 = icmp ult i16 %_3, %_4
  ret i1 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$u16$GT$5clone17h289b7d0947ca11d9E"(i16* noalias readonly align 2 dereferenceable(2) %self) unnamed_addr #1 {
start:
  %0 = load i16, i16* %self, align 2
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN47_$LT$u16$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17hea835907cbd96f68E"(i16 %start1, i16 %n) unnamed_addr #1 {
start:
  %0 = call i16 @"_ZN4core3num21_$LT$impl$u20$u16$GT$13unchecked_add17h263c40ef7556e9f5E"(i16 %start1, i16 %n)
  br label %bb1

bb1:                                              ; preds = %start
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @_ZN4core3mem7replace17h44d2c0ca8214fc8eE(i16* align 2 dereferenceable(2) %dest, i16) unnamed_addr #1 {
start:
  %src = alloca i16, align 2
  store i16 %0, i16* %src, align 2
  call void @_ZN4core3mem4swap17h297bff2eb7f0cfecE(i16* align 2 dereferenceable(2) %dest, i16* align 2 dereferenceable(2) %src)
  br label %bb1

bb1:                                              ; preds = %start
  %1 = load i16, i16* %src, align 2
  ret i16 %1
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3mem4swap17h297bff2eb7f0cfecE(i16* align 2 dereferenceable(2) %x, i16* align 2 dereferenceable(2) %y) unnamed_addr #1 {
start:
  call void @_ZN4core3ptr23swap_nonoverlapping_one17hf3545a55ff2903daE(i16* %x, i16* %y)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr23swap_nonoverlapping_one17hf3545a55ff2903daE(i16* %x, i16* %y) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %1 = alloca {}, align 1
  store i16 2, i16* %0, align 2
  %2 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %_3 = icmp ult i16 %2, 32
  br i1 %_3, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  call void @_ZN4core3ptr19swap_nonoverlapping17hb23e2f1c7e77fdeaE(i16* %x, i16* %y, i16 1)
  br label %bb7

bb3:                                              ; preds = %bb1
  %z = call i16 @_ZN4core3ptr4read17hdae84fd17449c1dcE(i16* %x)
  br label %bb4

bb4:                                              ; preds = %bb3
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hc91740379899059eE(i16* %y, i16* %x, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  call void @_ZN4core3ptr5write17h83413ec93fb2aed0E(i16* %y, i16 %z)
  br label %bb6

bb6:                                              ; preds = %bb5
  br label %bb8

bb7:                                              ; preds = %bb2
  br label %bb8

bb8:                                              ; preds = %bb7, %bb6
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr19swap_nonoverlapping17hb23e2f1c7e77fdeaE(i16* %x, i16* %y, i16 %count) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %x1 = bitcast i16* %x to i8*
  %y2 = bitcast i16* %y to i8*
  store i16 2, i16* %0, align 2
  %1 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %len = mul i16 %1, %count
  call void @_ZN4core3ptr25swap_nonoverlapping_bytes17hc62e6330119b0c6dE(i8* %x1, i8* %y2, i16 %len)
  br label %bb2

bb2:                                              ; preds = %bb1
  ret void
}

; Function Attrs: inlinehint nounwind
define internal i16 @_ZN4core3ptr4read17hdae84fd17449c1dcE(i16* %src) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %tmp = alloca i16, align 2
  %1 = bitcast i16* %0 to {}*
  %2 = load i16, i16* %0, align 2
  store i16 %2, i16* %tmp, align 2
  br label %bb1

bb1:                                              ; preds = %start
  br label %bb2

bb2:                                              ; preds = %bb1
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hc91740379899059eE(i16* %src, i16* %tmp, i16 1)
  br label %bb3

bb3:                                              ; preds = %bb2
  %_7 = load i16, i16* %tmp, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  ret i16 %_7
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core10intrinsics19copy_nonoverlapping17hc91740379899059eE(i16* %src, i16* %dst, i16 %count) unnamed_addr #1 {
start:
  %0 = mul i16 2, %count
  %1 = bitcast i16* %dst to i8*
  %2 = bitcast i16* %src to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 2 %1, i8* align 2 %2, i16 %0, i1 false)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr5write17h83413ec93fb2aed0E(i16* %dst, i16 %src) unnamed_addr #1 {
start:
  %0 = alloca {}, align 1
  store i16 %src, i16* %dst, align 2
  ret void
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN4core3num21_$LT$impl$u20$u16$GT$13unchecked_add17h263c40ef7556e9f5E"(i16 %self, i16 %rhs) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %1 = add nuw i16 %self, %rhs
  store i16 %1, i16* %0, align 2
  %2 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  ret i16 %2
}

define void @clear_isDirty() {
entry:
  ret void
}

; Function Attrs: cold noinline noreturn nounwind
define void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16, i16, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12)) unnamed_addr #4 {
start:
  %_11 = alloca { i16*, i16* }, align 2
  %_10 = alloca [2 x { i8*, i8* }], align 2
  %_3 = alloca %"fmt::Arguments", align 2
  %len = alloca i16, align 2
  %index = alloca i16, align 2
  store i16 %0, i16* %index, align 2
  store i16 %1, i16* %len, align 2
  %_22 = load [2 x { [0 x i8]*, i16 }]*, [2 x { [0 x i8]*, i16 }]** bitcast (<{ i8*, [0 x i8] }>* @anon.b7bafff2f871b915b57b152a19c6233b.18 to [2 x { [0 x i8]*, i16 }]**), align 2, !nonnull !2
  %_4.0 = bitcast [2 x { [0 x i8]*, i16 }]* %_22 to [0 x { [0 x i8]*, i16 }]*
  %3 = bitcast { i16*, i16* }* %_11 to i16**
  store i16* %len, i16** %3, align 2
  %4 = getelementptr inbounds { i16*, i16* }, { i16*, i16* }* %_11, i32 0, i32 1
  store i16* %index, i16** %4, align 2
  %5 = bitcast { i16*, i16* }* %_11 to i16**
  %arg0 = load i16*, i16** %5, align 2, !nonnull !2
  %6 = getelementptr inbounds { i16*, i16* }, { i16*, i16* }* %_11, i32 0, i32 1
  %arg1 = load i16*, i16** %6, align 2, !nonnull !2
  %7 = call { i8*, i8* } @_ZN4core3fmt10ArgumentV13new17h93a6a2505b71feb3E(i16* noalias readonly align 2 dereferenceable(2) %arg0, i1 (i16*, %"fmt::Formatter"*)* nonnull undef)
  %_16.0 = extractvalue { i8*, i8* } %7, 0
  %_16.1 = extractvalue { i8*, i8* } %7, 1
  br label %bb1

bb1:                                              ; preds = %start
  %8 = call { i8*, i8* } @_ZN4core3fmt10ArgumentV13new17h93a6a2505b71feb3E(i16* noalias readonly align 2 dereferenceable(2) %arg1, i1 (i16*, %"fmt::Formatter"*)* nonnull undef)
  %_19.0 = extractvalue { i8*, i8* } %8, 0
  %_19.1 = extractvalue { i8*, i8* } %8, 1
  br label %bb2

bb2:                                              ; preds = %bb1
  %9 = bitcast [2 x { i8*, i8* }]* %_10 to { i8*, i8* }*
  %10 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %9, i32 0, i32 0
  store i8* %_16.0, i8** %10, align 2
  %11 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %9, i32 0, i32 1
  store i8* %_16.1, i8** %11, align 2
  %12 = getelementptr inbounds [2 x { i8*, i8* }], [2 x { i8*, i8* }]* %_10, i32 0, i32 1
  %13 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %12, i32 0, i32 0
  store i8* %_19.0, i8** %13, align 2
  %14 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %12, i32 0, i32 1
  store i8* %_19.1, i8** %14, align 2
  %_7.0 = bitcast [2 x { i8*, i8* }]* %_10 to [0 x { i8*, i8* }]*
  call void @_ZN4core3fmt9Arguments6new_v117hcb862d1c1c522ce9E(%"fmt::Arguments"* noalias nocapture sret dereferenceable(12) %_3, [0 x { [0 x i8]*, i16 }]* noalias nonnull readonly align 2 %_4.0, i16 2, [0 x { i8*, i8* }]* noalias nonnull readonly align 2 %_7.0, i16 2)
  br label %bb3

bb3:                                              ; preds = %bb2
  call void @_ZN4core9panicking9panic_fmt17hd5daa03e51f33d00E(%"fmt::Arguments"* noalias nocapture dereferenceable(12) %_3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) %2)
  unreachable
}

; Function Attrs: nounwind
define { i8*, i8* } @_ZN4core3fmt10ArgumentV13new17h93a6a2505b71feb3E(i16* noalias readonly align 2 dereferenceable(2) %x, i1 (i16*, %"fmt::Formatter"*)* nonnull %f) unnamed_addr #0 {
start:
  %0 = alloca %"fmt::USIZE_MARKER::{{closure}}"*, align 2
  %1 = alloca i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)*, align 2
  %2 = alloca { i8*, i8* }, align 2
  %3 = bitcast i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)** %1 to i1 (i16*, %"fmt::Formatter"*)**
  store i1 (i16*, %"fmt::Formatter"*)* %f, i1 (i16*, %"fmt::Formatter"*)** %3, align 2
  %_3 = load i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)*, i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)** %1, align 2, !nonnull !2
  br label %bb1

bb1:                                              ; preds = %start
  %4 = bitcast %"fmt::USIZE_MARKER::{{closure}}"** %0 to i16**
  store i16* %x, i16** %4, align 2
  %_5 = load %"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::USIZE_MARKER::{{closure}}"** %0, align 2, !nonnull !2
  br label %bb2

bb2:                                              ; preds = %bb1
  %5 = bitcast { i8*, i8* }* %2 to %"fmt::USIZE_MARKER::{{closure}}"**
  store %"fmt::USIZE_MARKER::{{closure}}"* %_5, %"fmt::USIZE_MARKER::{{closure}}"** %5, align 2
  %6 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 1
  %7 = bitcast i8** %6 to i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)**
  store i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)* %_3, i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)** %7, align 2
  %8 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 0
  %9 = load i8*, i8** %8, align 2, !nonnull !2
  %10 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 1
  %11 = load i8*, i8** %10, align 2, !nonnull !2
  %12 = insertvalue { i8*, i8* } undef, i8* %9, 0
  %13 = insertvalue { i8*, i8* } %12, i8* %11, 1
  ret { i8*, i8* } %13
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3fmt9Arguments6new_v117hcb862d1c1c522ce9E(%"fmt::Arguments"* noalias nocapture sret dereferenceable(12), [0 x { [0 x i8]*, i16 }]* noalias nonnull readonly align 2 %pieces.0, i16 %pieces.1, [0 x { i8*, i8* }]* noalias nonnull readonly align 2 %args.0, i16 %args.1) unnamed_addr #1 {
start:
  %_4 = alloca { i16*, i16 }, align 2
  %1 = bitcast { i16*, i16 }* %_4 to {}**
  store {}* null, {}** %1, align 2
  %2 = bitcast %"fmt::Arguments"* %0 to { [0 x { [0 x i8]*, i16 }]*, i16 }*
  %3 = getelementptr inbounds { [0 x { [0 x i8]*, i16 }]*, i16 }, { [0 x { [0 x i8]*, i16 }]*, i16 }* %2, i32 0, i32 0
  store [0 x { [0 x i8]*, i16 }]* %pieces.0, [0 x { [0 x i8]*, i16 }]** %3, align 2
  %4 = getelementptr inbounds { [0 x { [0 x i8]*, i16 }]*, i16 }, { [0 x { [0 x i8]*, i16 }]*, i16 }* %2, i32 0, i32 1
  store i16 %pieces.1, i16* %4, align 2
  %5 = getelementptr inbounds %"fmt::Arguments", %"fmt::Arguments"* %0, i32 0, i32 3
  %6 = getelementptr inbounds { i16*, i16 }, { i16*, i16 }* %_4, i32 0, i32 0
  %7 = load i16*, i16** %6, align 2
  %8 = getelementptr inbounds { i16*, i16 }, { i16*, i16 }* %_4, i32 0, i32 1
  %9 = load i16, i16* %8, align 2
  %10 = getelementptr inbounds { i16*, i16 }, { i16*, i16 }* %5, i32 0, i32 0
  store i16* %7, i16** %10, align 2
  %11 = getelementptr inbounds { i16*, i16 }, { i16*, i16 }* %5, i32 0, i32 1
  store i16 %9, i16* %11, align 2
  %12 = getelementptr inbounds %"fmt::Arguments", %"fmt::Arguments"* %0, i32 0, i32 5
  %13 = getelementptr inbounds { [0 x { i8*, i8* }]*, i16 }, { [0 x { i8*, i8* }]*, i16 }* %12, i32 0, i32 0
  store [0 x { i8*, i8* }]* %args.0, [0 x { i8*, i8* }]** %13, align 2
  %14 = getelementptr inbounds { [0 x { i8*, i8* }]*, i16 }, { [0 x { i8*, i8* }]*, i16 }* %12, i32 0, i32 1
  store i16 %args.1, i16* %14, align 2
  ret void
}

; Function Attrs: cold noinline noreturn nounwind
define void @_ZN4core9panicking9panic_fmt17hd5daa03e51f33d00E(%"fmt::Arguments"* noalias nocapture dereferenceable(12) %fmt, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12)) unnamed_addr #4 {
start:
  %_3 = alloca i16*, align 2
  %pi = alloca %"panic::PanicInfo", align 2
  %1 = bitcast i16** %_3 to %"fmt::Arguments"**
  store %"fmt::Arguments"* %fmt, %"fmt::Arguments"** %1, align 2
  %_7 = call align 2 dereferenceable(12) %"core::panic::Location"* @_ZN4core5panic8Location6caller17he63f0d12e433f130E(%"core::panic::Location"* noalias readonly align 2 dereferenceable(12) %0)
  br label %bb1

bb1:                                              ; preds = %start
  %2 = load i16*, i16** %_3, align 2
  call void @_ZN4core5panic9PanicInfo20internal_constructor17h3f579eac134a0316E(%"panic::PanicInfo"* noalias nocapture sret dereferenceable(8) %pi, i16* noalias readonly align 2 dereferenceable_or_null(12) %2, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) %_7)
  br label %bb2

bb2:                                              ; preds = %bb1
  call void @rust_begin_unwind(%"panic::PanicInfo"* noalias readonly align 2 dereferenceable(8) %pi)
  unreachable
}

; Function Attrs: nounwind
define align 2 dereferenceable(12) %"core::panic::Location"* @_ZN4core5panic8Location6caller17he63f0d12e433f130E(%"core::panic::Location"* noalias readonly align 2 dereferenceable(12)) unnamed_addr #0 {
start:
  %1 = alloca %"core::panic::Location"*, align 2
  store %"core::panic::Location"* %0, %"core::panic::Location"** %1, align 2
  %2 = load %"core::panic::Location"*, %"core::panic::Location"** %1, align 2, !nonnull !2
  br label %bb1

bb1:                                              ; preds = %start
  ret %"core::panic::Location"* %2
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core5panic9PanicInfo20internal_constructor17h3f579eac134a0316E(%"panic::PanicInfo"* noalias nocapture sret dereferenceable(8), i16* noalias readonly align 2 dereferenceable_or_null(12) %message, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) %location) unnamed_addr #1 {
start:
  %_8 = load %"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::USIZE_MARKER::{{closure}}"** bitcast (<{ i8*, [0 x i8] }>* @anon.b7bafff2f871b915b57b152a19c6233b.10 to %"fmt::USIZE_MARKER::{{closure}}"**), align 2, !nonnull !2
  %_5.0 = bitcast %"fmt::USIZE_MARKER::{{closure}}"* %_8 to {}*
  %1 = bitcast %"panic::PanicInfo"* %0 to { {}*, [3 x i16]* }*
  %2 = getelementptr inbounds { {}*, [3 x i16]* }, { {}*, [3 x i16]* }* %1, i32 0, i32 0
  store {}* %_5.0, {}** %2, align 2
  %3 = getelementptr inbounds { {}*, [3 x i16]* }, { {}*, [3 x i16]* }* %1, i32 0, i32 1
  store [3 x i16]* bitcast ({ void (%"fmt::USIZE_MARKER::{{closure}}"*)*, i16, i16, i64 (%"fmt::USIZE_MARKER::{{closure}}"*)* }* @vtable.c to [3 x i16]*), [3 x i16]** %3, align 2
  %4 = getelementptr inbounds %"panic::PanicInfo", %"panic::PanicInfo"* %0, i32 0, i32 3
  store i16* %message, i16** %4, align 2
  %5 = getelementptr inbounds %"panic::PanicInfo", %"panic::PanicInfo"* %0, i32 0, i32 5
  store %"core::panic::Location"* %location, %"core::panic::Location"** %5, align 2
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i16(i8* nocapture writeonly, i8, i16, i1 immarg) #2

; Function Attrs: inlinehint nounwind
define i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 %self.0, i16 %self.1) unnamed_addr #1 {
start:
  %0 = bitcast [0 x i8]* %self.0 to i8*
  ret i8* %0
}

; Function Attrs: inlinehint nounwind
define i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$6offset17h2e1a7811e3081d04E"(i8* %self, i16 %count) unnamed_addr #1 {
start:
  %0 = alloca i8*, align 2
  %1 = getelementptr inbounds i8, i8* %self, i16 %count
  store i8* %1, i8** %0, align 2
  %_3 = load i8*, i8** %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  ret i8* %_3
}

; Function Attrs: inlinehint nounwind
define void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %src, i8* %dst, i16 %count) unnamed_addr #1 {
start:
  %0 = mul i16 1, %count
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %dst, i8* align 1 %src, i16 %0, i1 false)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: nounwind
define { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h820c98c80fab166dE"(i16 %self.0, i16 %self.1) unnamed_addr #0 {
start:
  %0 = insertvalue { i16, i16 } undef, i16 %self.0, 0
  %1 = insertvalue { i16, i16 } %0, i16 %self.1, 1
  ret { i16, i16 } %1
}

; Function Attrs: inlinehint nounwind
define { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %self) unnamed_addr #1 {
start:
  %0 = alloca { i16, i16 }, align 2
  %_3 = bitcast { i16, i16 }* %self to i16*
  %_4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %self, i32 0, i32 1
  %_2 = call zeroext i1 @"_ZN4core3cmp5impls57_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$usize$GT$2lt17h0750a5d1d0a2d0e5E"(i16* noalias readonly align 2 dereferenceable(2) %_3, i16* noalias readonly align 2 dereferenceable(2) %_4)
  br label %bb1

bb1:                                              ; preds = %start
  br i1 %_2, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  %1 = bitcast { i16, i16 }* %0 to i16*
  store i16 0, i16* %1, align 2
  br label %bb7

bb3:                                              ; preds = %bb1
  %_7 = bitcast { i16, i16 }* %self to i16*
  %_6 = call i16 @"_ZN4core5clone5impls54_$LT$impl$u20$core..clone..Clone$u20$for$u20$usize$GT$5clone17h35de8cec8ce1ca85E"(i16* noalias readonly align 2 dereferenceable(2) %_7)
  br label %bb4

bb4:                                              ; preds = %bb3
  %n = call i16 @"_ZN49_$LT$usize$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h967f7533a954ac6cE"(i16 %_6, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  %_10 = bitcast { i16, i16 }* %self to i16*
  %_8 = call i16 @_ZN4core3mem7replace17h2a3746616bd5c532E(i16* align 2 dereferenceable(2) %_10, i16 %n)
  br label %bb6

bb6:                                              ; preds = %bb5
  %2 = bitcast { i16, i16 }* %0 to %"core::option::Option<u16>::Some"*
  %3 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %2, i32 0, i32 1
  store i16 %_8, i16* %3, align 2
  %4 = bitcast { i16, i16 }* %0 to i16*
  store i16 1, i16* %4, align 2
  br label %bb7

bb7:                                              ; preds = %bb6, %bb2
  %5 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %0, i32 0, i32 0
  %6 = load i16, i16* %5, align 2, !range !0
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %0, i32 0, i32 1
  %8 = load i16, i16* %7, align 2
  %9 = insertvalue { i16, i16 } undef, i16 %6, 0
  %10 = insertvalue { i16, i16 } %9, i16 %8, 1
  ret { i16, i16 } %10
}

; Function Attrs: inlinehint nounwind
define internal zeroext i1 @"_ZN4core3cmp5impls57_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$usize$GT$2lt17h0750a5d1d0a2d0e5E"(i16* noalias readonly align 2 dereferenceable(2) %self, i16* noalias readonly align 2 dereferenceable(2) %other) unnamed_addr #1 {
start:
  %_3 = load i16, i16* %self, align 2
  %_4 = load i16, i16* %other, align 2
  %0 = icmp ult i16 %_3, %_4
  ret i1 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN4core5clone5impls54_$LT$impl$u20$core..clone..Clone$u20$for$u20$usize$GT$5clone17h35de8cec8ce1ca85E"(i16* noalias readonly align 2 dereferenceable(2) %self) unnamed_addr #1 {
start:
  %0 = load i16, i16* %self, align 2
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN49_$LT$usize$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h967f7533a954ac6cE"(i16 %start1, i16 %n) unnamed_addr #1 {
start:
  %0 = call i16 @"_ZN4core3num23_$LT$impl$u20$usize$GT$13unchecked_add17h985a7d3f93b73fe5E"(i16 %start1, i16 %n)
  br label %bb1

bb1:                                              ; preds = %start
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define i16 @_ZN4core3mem7replace17h2a3746616bd5c532E(i16* align 2 dereferenceable(2) %dest, i16) unnamed_addr #1 {
start:
  %src = alloca i16, align 2
  store i16 %0, i16* %src, align 2
  call void @_ZN4core3mem4swap17h5780128ab4410f1bE(i16* align 2 dereferenceable(2) %dest, i16* align 2 dereferenceable(2) %src)
  br label %bb1

bb1:                                              ; preds = %start
  %1 = load i16, i16* %src, align 2
  ret i16 %1
}

; Function Attrs: inlinehint nounwind
define void @_ZN4core3mem4swap17h5780128ab4410f1bE(i16* align 2 dereferenceable(2) %x, i16* align 2 dereferenceable(2) %y) unnamed_addr #1 {
start:
  call void @_ZN4core3ptr23swap_nonoverlapping_one17h794dcea844776eb6E(i16* %x, i16* %y)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define void @_ZN4core3ptr23swap_nonoverlapping_one17h794dcea844776eb6E(i16* %x, i16* %y) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %1 = alloca {}, align 1
  store i16 2, i16* %0, align 2
  %2 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %_3 = icmp ult i16 %2, 32
  br i1 %_3, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  call void @_ZN4core3ptr19swap_nonoverlapping17hce1af3a4ad5262f2E(i16* %x, i16* %y, i16 1)
  br label %bb7

bb3:                                              ; preds = %bb1
  %z = call i16 @_ZN4core3ptr4read17ha381715c75e05d0dE(i16* %x)
  br label %bb4

bb4:                                              ; preds = %bb3
  call void @_ZN4core10intrinsics19copy_nonoverlapping17h9dce94ffe69dd9feE(i16* %y, i16* %x, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  call void @_ZN4core3ptr5write17h2798392a937a2f1cE(i16* %y, i16 %z)
  br label %bb6

bb6:                                              ; preds = %bb5
  br label %bb8

bb7:                                              ; preds = %bb2
  br label %bb8

bb8:                                              ; preds = %bb7, %bb6
  ret void
}

; Function Attrs: inlinehint nounwind
define void @_ZN4core3ptr19swap_nonoverlapping17hce1af3a4ad5262f2E(i16* %x, i16* %y, i16 %count) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %x1 = bitcast i16* %x to i8*
  %y2 = bitcast i16* %y to i8*
  store i16 2, i16* %0, align 2
  %1 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %len = mul i16 %1, %count
  call void @_ZN4core3ptr25swap_nonoverlapping_bytes17h9e5ff4c1ae9cd9eaE(i8* %x1, i8* %y2, i16 %len)
  br label %bb2

bb2:                                              ; preds = %bb1
  ret void
}

; Function Attrs: inlinehint nounwind
define i16 @_ZN4core3ptr4read17ha381715c75e05d0dE(i16* %src) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %tmp = alloca i16, align 2
  %1 = bitcast i16* %0 to {}*
  %2 = load i16, i16* %0, align 2
  store i16 %2, i16* %tmp, align 2
  br label %bb1

bb1:                                              ; preds = %start
  br label %bb2

bb2:                                              ; preds = %bb1
  call void @_ZN4core10intrinsics19copy_nonoverlapping17h9dce94ffe69dd9feE(i16* %src, i16* %tmp, i16 1)
  br label %bb3

bb3:                                              ; preds = %bb2
  %_7 = load i16, i16* %tmp, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  ret i16 %_7
}

; Function Attrs: inlinehint nounwind
define void @_ZN4core10intrinsics19copy_nonoverlapping17h9dce94ffe69dd9feE(i16* %src, i16* %dst, i16 %count) unnamed_addr #1 {
start:
  %0 = mul i16 2, %count
  %1 = bitcast i16* %dst to i8*
  %2 = bitcast i16* %src to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 2 %1, i8* align 2 %2, i16 %0, i1 false)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define void @_ZN4core3ptr5write17h2798392a937a2f1cE(i16* %dst, i16 %src) unnamed_addr #1 {
start:
  %0 = alloca {}, align 1
  store i16 %src, i16* %dst, align 2
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr25swap_nonoverlapping_bytes17h9e5ff4c1ae9cd9eaE(i8* %x, i8* %y, i16 %len) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %t1 = alloca %"core::mem::maybe_uninit::MaybeUninit<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>", align 2
  %t = alloca <4 x i64>, align 32
  %i = alloca i16, align 2
  %1 = alloca {}, align 1
  store i16 32, i16* %0, align 2
  %2 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  store i16 0, i16* %i, align 2
  br label %bb2

bb2:                                              ; preds = %bb11, %bb1
  %_8 = load i16, i16* %i, align 2
  %_7 = add i16 %_8, %2
  %_6 = icmp ule i16 %_7, %len
  br i1 %_6, label %bb4, label %bb3

bb3:                                              ; preds = %bb2
  %_38 = load i16, i16* %i, align 2
  %_37 = icmp ult i16 %_38, %len
  br i1 %_37, label %bb13, label %bb12

bb4:                                              ; preds = %bb2
  %3 = bitcast <4 x i64>* %t to {}*
  br label %bb5

bb5:                                              ; preds = %bb4
  br label %bb6

bb6:                                              ; preds = %bb5
  %t2 = bitcast <4 x i64>* %t to i8*
  %_17 = load i16, i16* %i, align 2
  %x3 = call i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$3add17h02212dc06e61a034E"(i8* %x, i16 %_17)
  br label %bb7

bb7:                                              ; preds = %bb6
  %_20 = load i16, i16* %i, align 2
  %y4 = call i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$3add17h02212dc06e61a034E"(i8* %y, i16 %_20)
  br label %bb8

bb8:                                              ; preds = %bb7
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %x3, i8* %t2, i16 %2)
  br label %bb9

bb9:                                              ; preds = %bb8
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %y4, i8* %x3, i16 %2)
  br label %bb10

bb10:                                             ; preds = %bb9
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %t2, i8* %y4, i16 %2)
  br label %bb11

bb11:                                             ; preds = %bb10
  %4 = load i16, i16* %i, align 2
  %5 = add i16 %4, %2
  store i16 %5, i16* %i, align 2
  br label %bb2

bb12:                                             ; preds = %bb3
  br label %bb21

bb13:                                             ; preds = %bb3
  %6 = bitcast %"core::mem::maybe_uninit::MaybeUninit<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>"* %t1 to {}*
  br label %bb14

bb14:                                             ; preds = %bb13
  %_43 = load i16, i16* %i, align 2
  %rem = sub i16 %len, %_43
  %_4.i = bitcast %"core::mem::maybe_uninit::MaybeUninit<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>"* %t1 to %"core::mem::manually_drop::ManuallyDrop<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>"*
  %_3.i.i = bitcast %"core::mem::manually_drop::ManuallyDrop<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>"* %_4.i to %"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock"*
  br label %bb15

bb15:                                             ; preds = %bb14
  %t5 = bitcast %"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock"* %_3.i.i to i8*
  %_49 = load i16, i16* %i, align 2
  %x6 = call i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$3add17h02212dc06e61a034E"(i8* %x, i16 %_49)
  br label %bb16

bb16:                                             ; preds = %bb15
  %_52 = load i16, i16* %i, align 2
  %y7 = call i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$3add17h02212dc06e61a034E"(i8* %y, i16 %_52)
  br label %bb17

bb17:                                             ; preds = %bb16
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %x6, i8* %t5, i16 %rem)
  br label %bb18

bb18:                                             ; preds = %bb17
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %y7, i8* %x6, i16 %rem)
  br label %bb19

bb19:                                             ; preds = %bb18
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %t5, i8* %y7, i16 %rem)
  br label %bb20

bb20:                                             ; preds = %bb19
  br label %bb21

bb21:                                             ; preds = %bb20, %bb12
  ret void
}

; Function Attrs: inlinehint nounwind
define i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$3add17h02212dc06e61a034E"(i8* %self, i16 %count) unnamed_addr #1 {
start:
  %0 = call i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$6offset17h2e1a7811e3081d04E"(i8* %self, i16 %count)
  br label %bb1

bb1:                                              ; preds = %start
  ret i8* %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN4core3num23_$LT$impl$u20$usize$GT$13unchecked_add17h985a7d3f93b73fe5E"(i16 %self, i16 %rhs) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %1 = add nuw i16 %self, %rhs
  store i16 %1, i16* %0, align 2
  %2 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  ret i16 %2
}

; Function Attrs: nounwind
declare void @llvm.assume(i1) #5

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.usub.with.overflow.i16(i16, i16) #6

; Function Attrs: nounwind readnone speculatable
declare i16 @llvm.cttz.i16(i16, i1 immarg) #6

; Function Attrs: nounwind readnone speculatable
declare { i32, i1 } @llvm.uadd.with.overflow.i32(i32, i32) #6

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #7

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.uadd.with.overflow.i64(i64, i64) #6

; Function Attrs: nounwind readnone speculatable
declare i16 @llvm.usub.sat.i16(i16, i16) #6

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.ctlz.i32(i32, i1 immarg) #6

; Function Attrs: nounwind readnone speculatable
declare i64 @llvm.ctlz.i64(i64, i1 immarg) #6

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.usub.with.overflow.i64(i64, i64) #6

; Function Attrs: nounwind readnone speculatable
declare i16 @llvm.ctpop.i16(i16) #6

; Function Attrs: nounwind
declare i32 @memcmp(i8*, i8*, i16) unnamed_addr #0

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #6

; Function Attrs: nounwind readnone speculatable
declare { i8, i1 } @llvm.usub.with.overflow.i8(i8, i8) #6

; Function Attrs: nounwind readnone speculatable
declare { i8, i1 } @llvm.uadd.with.overflow.i8(i8, i8) #6

; Function Attrs: nounwind readnone speculatable
declare { i8, i1 } @llvm.umul.with.overflow.i8(i8, i8) #6

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.uadd.with.overflow.i16(i16, i16) #6

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.umul.with.overflow.i16(i16, i16) #6

; Function Attrs: nounwind readnone speculatable
declare { i32, i1 } @llvm.usub.with.overflow.i32(i32, i32) #6

; Function Attrs: nounwind readnone speculatable
declare { i32, i1 } @llvm.umul.with.overflow.i32(i32, i32) #6

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.usub.with.overflow.i128(i128, i128) #6

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.uadd.with.overflow.i128(i128, i128) #6

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.umul.with.overflow.i128(i128, i128) #6

; Function Attrs: nounwind readnone speculatable
declare { i8, i1 } @llvm.ssub.with.overflow.i8(i8, i8) #6

; Function Attrs: nounwind readnone speculatable
declare { i8, i1 } @llvm.sadd.with.overflow.i8(i8, i8) #6

; Function Attrs: nounwind readnone speculatable
declare { i8, i1 } @llvm.smul.with.overflow.i8(i8, i8) #6

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.ssub.with.overflow.i16(i16, i16) #6

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.sadd.with.overflow.i16(i16, i16) #6

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.smul.with.overflow.i16(i16, i16) #6

; Function Attrs: nounwind readnone speculatable
declare { i32, i1 } @llvm.ssub.with.overflow.i32(i32, i32) #6

; Function Attrs: nounwind readnone speculatable
declare { i32, i1 } @llvm.sadd.with.overflow.i32(i32, i32) #6

; Function Attrs: nounwind readnone speculatable
declare { i32, i1 } @llvm.smul.with.overflow.i32(i32, i32) #6

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.ssub.with.overflow.i64(i64, i64) #6

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.sadd.with.overflow.i64(i64, i64) #6

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.smul.with.overflow.i64(i64, i64) #6

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.ssub.with.overflow.i128(i128, i128) #6

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.sadd.with.overflow.i128(i128, i128) #6

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.smul.with.overflow.i128(i128, i128) #6

; Function Attrs: nounwind readnone speculatable
declare i8 @llvm.ctlz.i8(i8, i1 immarg) #6

; Function Attrs: nounwind readnone speculatable
declare i16 @llvm.ctlz.i16(i16, i1 immarg) #6

; Function Attrs: nounwind readnone speculatable
declare i128 @llvm.ctlz.i128(i128, i1 immarg) #6

; Function Attrs: nounwind readnone speculatable
declare i64 @llvm.fshl.i64(i64, i64, i64) #6

; Function Attrs: noreturn nounwind
define void @rust_begin_unwind(%"panic::PanicInfo"* noalias readonly align 2 dereferenceable(8) %_info) unnamed_addr #8 {
start:
  call void asm sideeffect "dint { nop", "~{memory}"() #5, !srcloc !3
  br label %bb1

bb1:                                              ; preds = %start
  br label %bb2

bb2:                                              ; preds = %bb3, %bb1
  call void asm sideeffect "", "~{memory}"() #5, !srcloc !4
  br label %bb3

bb3:                                              ; preds = %bb2
  br label %bb2
}

attributes #0 = { nounwind "target-cpu"="generic" }
attributes #1 = { inlinehint nounwind "target-cpu"="generic" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind readnone }
attributes #4 = { cold noinline noreturn nounwind "target-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { nounwind readnone speculatable }
attributes #7 = { cold noreturn nounwind }
attributes #8 = { noreturn nounwind "target-cpu"="generic" }

!0 = !{i16 0, i16 2}
!1 = !{i8 0, i8 2}
!2 = !{}
!3 = !{i32 2974937}
!4 = !{i32 2974670}
