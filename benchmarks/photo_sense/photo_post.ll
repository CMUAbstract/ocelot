; ModuleID = 'photo_post.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:16:16-i32:16-i64:16-f32:16-f64:16-a:8-n8:16-S16"
target triple = "msp430-none-unknown-elf"

%"core::option::Option<i32>::Some" = type { [1 x i16], i32, [0 x i16] }
%"core::mem::maybe_uninit::MaybeUninit<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>" = type { [16 x i16] }
%"core::mem::manually_drop::ManuallyDrop<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>" = type { [0 x i16], %"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock", [0 x i16] }
%"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock" = type { [0 x i16], i64, [0 x i16], i64, [0 x i16], i64, [0 x i16], i64, [0 x i16] }
%"core::option::Option<u16>::Some" = type { [1 x i16], i16, [0 x i16] }
%"panic::PanicInfo" = type { [0 x i16], { {}*, [3 x i16]* }, [0 x i16], i16*, [0 x i16], %"panic::Location"*, [0 x i16] }
%"panic::Location" = type { [0 x i16], { [0 x i8]*, i16 }, [0 x i16], i32, [0 x i16], i32, [0 x i16] }

@num_dirty_gv = common externally_initialized global i16 0
@_numBoots = common externally_initialized global i16 0
@data_src = global [0 x i8*] zeroinitializer, section ".nv_vars", align 2
@data_dest = global [0 x i8*] zeroinitializer, section ".nv_vars", align 2
@data_size = global [0 x i16] zeroinitializer, section ".nv_vars", align 2
@atomic_depth = external global i16

; Function Attrs: nounwind
define internal i16 @_ZN5photo10read_light17h140a6a6c2a8a076eE(i16 %count) unnamed_addr #0 {
start:
  %_7 = alloca { i16, i32 }, align 2
  %iter = alloca { i32, i32 }, align 2
  %_4 = alloca { i32, i32 }, align 2
  %val = alloca i16, align 2
  store i16 %count, i16* %val, align 2
  %0 = bitcast { i32, i32 }* %_4 to i32*
  store i32 0, i32* %0, align 2
  %1 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %_4, i32 0, i32 1
  store i32 50, i32* %1, align 2
  %2 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %_4, i32 0, i32 0
  %3 = load i32, i32* %2, align 2
  %4 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %_4, i32 0, i32 1
  %5 = load i32, i32* %4, align 2
  %6 = call { i32, i32 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hb94f6cd81c2d390dE"(i32 %3, i32 %5)
  %_3.0 = extractvalue { i32, i32 } %6, 0
  %_3.1 = extractvalue { i32, i32 } %6, 1
  br label %bb1

bb1:                                              ; preds = %start
  %7 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %iter, i32 0, i32 0
  store i32 %_3.0, i32* %7, align 2
  %8 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %iter, i32 0, i32 1
  store i32 %_3.1, i32* %8, align 2
  br label %bb2

bb2:                                              ; preds = %bb6, %bb1
  %9 = call { i16, i32 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17hf169f82b1e9d0e91E"({ i32, i32 }* align 2 dereferenceable(8) %iter)
  store { i16, i32 } %9, { i16, i32 }* %_7, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %10 = bitcast { i16, i32 }* %_7 to i16*
  %_10 = load i16, i16* %10, align 2, !range !0
  switch i16 %_10, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  %_15 = load i16, i16* %val, align 2
  %_14 = urem i16 %_15, 17
  %11 = add i16 1400, %_14
  ret i16 %11

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %12 = bitcast { i16, i32 }* %_7 to %"core::option::Option<i32>::Some"*
  %13 = getelementptr inbounds %"core::option::Option<i32>::Some", %"core::option::Option<i32>::Some"* %12, i32 0, i32 1
  %val1 = load i32, i32* %13, align 2
  %14 = load i16, i16* %val, align 2
  %15 = add i16 %14, 1
  store i16 %15, i16* %val, align 2
  br label %bb2
}

; Function Attrs: nounwind
define internal { i32, i32 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hb94f6cd81c2d390dE"(i32 %self.0, i32 %self.1) unnamed_addr #0 {
start:
  %0 = insertvalue { i32, i32 } undef, i32 %self.0, 0
  %1 = insertvalue { i32, i32 } %0, i32 %self.1, 1
  ret { i32, i32 } %1
}

; Function Attrs: inlinehint nounwind
define internal { i16, i32 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17hf169f82b1e9d0e91E"({ i32, i32 }* align 2 dereferenceable(8) %self) unnamed_addr #1 {
start:
  %0 = alloca { i16, i32 }, align 2
  %_3 = bitcast { i32, i32 }* %self to i32*
  %_4 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %self, i32 0, i32 1
  %_2 = call zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$i32$GT$2lt17hd78d74adbf725b04E"(i32* noalias readonly align 2 dereferenceable(4) %_3, i32* noalias readonly align 2 dereferenceable(4) %_4)
  br label %bb1

bb1:                                              ; preds = %start
  br i1 %_2, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  %1 = bitcast { i16, i32 }* %0 to i16*
  store i16 0, i16* %1, align 2
  br label %bb7

bb3:                                              ; preds = %bb1
  %_7 = bitcast { i32, i32 }* %self to i32*
  %_6 = call i32 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$i32$GT$5clone17h10b2de232f51fd84E"(i32* noalias readonly align 2 dereferenceable(4) %_7)
  br label %bb4

bb4:                                              ; preds = %bb3
  %n = call i32 @"_ZN47_$LT$i32$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h79b3abb08e8e28b9E"(i32 %_6, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  %_10 = bitcast { i32, i32 }* %self to i32*
  %_8 = call i32 @_ZN4core3mem7replace17h97ae02304c322493E(i32* align 2 dereferenceable(4) %_10, i32 %n)
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
define internal zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$i32$GT$2lt17hd78d74adbf725b04E"(i32* noalias readonly align 2 dereferenceable(4) %self, i32* noalias readonly align 2 dereferenceable(4) %other) unnamed_addr #1 {
start:
  %_3 = load i32, i32* %self, align 2
  %_4 = load i32, i32* %other, align 2
  %0 = icmp slt i32 %_3, %_4
  ret i1 %0
}

; Function Attrs: inlinehint nounwind
define internal i32 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$i32$GT$5clone17h10b2de232f51fd84E"(i32* noalias readonly align 2 dereferenceable(4) %self) unnamed_addr #1 {
start:
  %0 = load i32, i32* %self, align 2
  ret i32 %0
}

; Function Attrs: inlinehint nounwind
define internal i32 @"_ZN47_$LT$i32$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h79b3abb08e8e28b9E"(i32 %start1, i16 %n) unnamed_addr #1 {
start:
  %_4 = zext i16 %n to i32
  %0 = call i32 @"_ZN4core3num21_$LT$impl$u20$i32$GT$13unchecked_add17ha687a23fa5991488E"(i32 %start1, i32 %_4)
  br label %bb1

bb1:                                              ; preds = %start
  ret i32 %0
}

; Function Attrs: inlinehint nounwind
define internal i32 @_ZN4core3mem7replace17h97ae02304c322493E(i32* align 2 dereferenceable(4) %dest, i32) unnamed_addr #1 {
start:
  %src = alloca i32, align 2
  store i32 %0, i32* %src, align 2
  call void @_ZN4core3mem4swap17h29b37c45af654735E(i32* align 2 dereferenceable(4) %dest, i32* align 2 dereferenceable(4) %src)
  br label %bb1

bb1:                                              ; preds = %start
  %1 = load i32, i32* %src, align 2
  ret i32 %1
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3mem4swap17h29b37c45af654735E(i32* align 2 dereferenceable(4) %x, i32* align 2 dereferenceable(4) %y) unnamed_addr #1 {
start:
  call void @_ZN4core3ptr23swap_nonoverlapping_one17h3123ceb5c04308cdE(i32* %x, i32* %y)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr23swap_nonoverlapping_one17h3123ceb5c04308cdE(i32* %x, i32* %y) unnamed_addr #1 {
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
  call void @_ZN4core3ptr19swap_nonoverlapping17hfc03421adb2d889cE(i32* %x, i32* %y, i16 1)
  br label %bb7

bb3:                                              ; preds = %bb1
  %z = call i32 @_ZN4core3ptr4read17hc906b4143fde1326E(i32* %x)
  br label %bb4

bb4:                                              ; preds = %bb3
  call void @_ZN4core10intrinsics19copy_nonoverlapping17h266ff5d10024fdc5E(i32* %y, i32* %x, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  call void @_ZN4core3ptr5write17hd066cfa7d5eb3630E(i32* %y, i32 %z)
  br label %bb6

bb6:                                              ; preds = %bb5
  br label %bb8

bb7:                                              ; preds = %bb2
  br label %bb8

bb8:                                              ; preds = %bb7, %bb6
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr19swap_nonoverlapping17hfc03421adb2d889cE(i32* %x, i32* %y, i16 %count) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %x1 = bitcast i32* %x to i8*
  %y2 = bitcast i32* %y to i8*
  store i16 4, i16* %0, align 2
  %1 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %len = mul i16 %1, %count
  call void @_ZN4core3ptr25swap_nonoverlapping_bytes17h33e6c97bd845050eE(i8* %x1, i8* %y2, i16 %len)
  br label %bb2

bb2:                                              ; preds = %bb1
  ret void
}

; Function Attrs: inlinehint nounwind
define internal i32 @_ZN4core3ptr4read17hc906b4143fde1326E(i32* %src) unnamed_addr #1 {
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
  call void @_ZN4core10intrinsics19copy_nonoverlapping17h266ff5d10024fdc5E(i32* %src, i32* %tmp, i16 1)
  br label %bb3

bb3:                                              ; preds = %bb2
  %_7 = load i32, i32* %tmp, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  ret i32 %_7
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core10intrinsics19copy_nonoverlapping17h266ff5d10024fdc5E(i32* %src, i32* %dst, i16 %count) unnamed_addr #1 {
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
define internal void @_ZN4core3ptr5write17hd066cfa7d5eb3630E(i32* %dst, i32 %src) unnamed_addr #1 {
start:
  %0 = alloca {}, align 1
  store i32 %src, i32* %dst, align 2
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i16(i8* nocapture writeonly, i8* nocapture readonly, i16, i1 immarg) #2

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr25swap_nonoverlapping_bytes17h33e6c97bd845050eE(i8* %x, i8* %y, i16 %len) unnamed_addr #1 {
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
define internal i32 @"_ZN4core3num21_$LT$impl$u20$i32$GT$13unchecked_add17ha687a23fa5991488E"(i32 %self, i32 %rhs) unnamed_addr #1 {
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
  %_5 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_2 = alloca { i16, i16 }, align 2
  br label %bb0

bb0:                                              ; preds = %bb12, %start
  %0 = bitcast { i16, i16 }* %_2 to i16*
  store i16 0, i16* %0, align 2
  %1 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_2, i32 0, i32 1
  store i16 100, i16* %1, align 2
  %2 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_2, i32 0, i32 0
  %3 = load i16, i16* %2, align 2
  %4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_2, i32 0, i32 1
  %5 = load i16, i16* %4, align 2
  %6 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h2e2a862d1d694c47E"(i16 %3, i16 %5)
  %_1.0 = extractvalue { i16, i16 } %6, 0
  %_1.1 = extractvalue { i16, i16 } %6, 1
  br label %bb1

bb1:                                              ; preds = %bb0
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_1.0, i16* %7, align 2
  %8 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_1.1, i16* %8, align 2
  br label %bb2

bb2:                                              ; preds = %bb8, %bb1
  %9 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h89f59f32b4b2b849E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %9, { i16, i16 }* %_5, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %10 = bitcast { i16, i16 }* %_5 to i16*
  %_8 = load i16, i16* %10, align 2, !range !0
  switch i16 %_8, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  call void @output_guard_start()
  br label %bb9

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %11 = bitcast { i16, i16 }* %_5 to %"core::option::Option<u16>::Some"*
  %12 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %11, i32 0, i32 1
  %val = load i16, i16* %12, align 2
  %light = call i16 @_ZN5photo13average_light17h8e850ad0930feb73E(i16 %val)
  br label %bb7

bb7:                                              ; preds = %bb6
  br label %bb8

bb8:                                              ; preds = %bb7
  br label %bb2

bb9:                                              ; preds = %bb4
  call void @gpioTwiddle()
  br label %bb10

bb10:                                             ; preds = %bb9
  call void @gpioTwiddle()
  br label %bb11

bb11:                                             ; preds = %bb10
  call void @output_guard_end()
  br label %bb12

bb12:                                             ; preds = %bb11
  br label %bb0
}

; Function Attrs: nounwind
define internal { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h2e2a862d1d694c47E"(i16 %self.0, i16 %self.1) unnamed_addr #0 {
start:
  %0 = insertvalue { i16, i16 } undef, i16 %self.0, 0
  %1 = insertvalue { i16, i16 } %0, i16 %self.1, 1
  ret { i16, i16 } %1
}

; Function Attrs: inlinehint nounwind
define internal { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h89f59f32b4b2b849E"({ i16, i16 }* align 2 dereferenceable(4) %self) unnamed_addr #1 {
start:
  %0 = alloca { i16, i16 }, align 2
  %_3 = bitcast { i16, i16 }* %self to i16*
  %_4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %self, i32 0, i32 1
  %_2 = call zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$u16$GT$2lt17h1444c976cc58b097E"(i16* noalias readonly align 2 dereferenceable(2) %_3, i16* noalias readonly align 2 dereferenceable(2) %_4)
  br label %bb1

bb1:                                              ; preds = %start
  br i1 %_2, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  %1 = bitcast { i16, i16 }* %0 to i16*
  store i16 0, i16* %1, align 2
  br label %bb7

bb3:                                              ; preds = %bb1
  %_7 = bitcast { i16, i16 }* %self to i16*
  %_6 = call i16 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$u16$GT$5clone17ha92bd836d1577855E"(i16* noalias readonly align 2 dereferenceable(2) %_7)
  br label %bb4

bb4:                                              ; preds = %bb3
  %n = call i16 @"_ZN47_$LT$u16$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17hea15312ae1e87443E"(i16 %_6, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  %_10 = bitcast { i16, i16 }* %self to i16*
  %_8 = call i16 @_ZN4core3mem7replace17h5b9f2f8c74edc485E(i16* align 2 dereferenceable(2) %_10, i16 %n)
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
define void @output_guard_start() unnamed_addr #0 {
start:
  call void @start_atomic()
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: nounwind
define internal i16 @_ZN5photo13average_light17h8e850ad0930feb73E(i16 %count) unnamed_addr #0 {
start:
  %_7 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_4 = alloca { i16, i16 }, align 2
  %light = alloca i16, align 2
  call void @atomic_start()
  %0 = call i16 @_ZN5photo10read_light17h140a6a6c2a8a076eE(i16 %count)
  store i16 %0, i16* %light, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %1 = bitcast { i16, i16 }* %_4 to i16*
  store i16 1, i16* %1, align 2
  %2 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_4, i32 0, i32 1
  store i16 3, i16* %2, align 2
  %3 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_4, i32 0, i32 0
  %4 = load i16, i16* %3, align 2
  %5 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_4, i32 0, i32 1
  %6 = load i16, i16* %5, align 2
  %7 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h2e2a862d1d694c47E"(i16 %4, i16 %6)
  %_3.0 = extractvalue { i16, i16 } %7, 0
  %_3.1 = extractvalue { i16, i16 } %7, 1
  br label %bb2

bb2:                                              ; preds = %bb1
  %8 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_3.0, i16* %8, align 2
  %9 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_3.1, i16* %9, align 2
  br label %bb3

bb3:                                              ; preds = %bb8, %bb2
  %10 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h89f59f32b4b2b849E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %10, { i16, i16 }* %_7, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  %11 = bitcast { i16, i16 }* %_7 to i16*
  %_10 = load i16, i16* %11, align 2, !range !0
  switch i16 %_10, label %bb6 [
    i16 0, label %bb5
    i16 1, label %bb7
  ]

bb5:                                              ; preds = %bb4
  call void @atomic_end()
  %12 = load i16, i16* %light, align 2
  %13 = udiv i16 %12, 3
  store i16 %13, i16* %light, align 2
  %14 = load i16, i16* %light, align 2
  ret i16 %14

bb6:                                              ; preds = %bb4
  unreachable

bb7:                                              ; preds = %bb4
  %15 = bitcast { i16, i16 }* %_7 to %"core::option::Option<u16>::Some"*
  %16 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %15, i32 0, i32 1
  %val = load i16, i16* %16, align 2
  %_15 = add i16 %count, %val
  %_14 = call i16 @_ZN5photo10read_light17h140a6a6c2a8a076eE(i16 %_15)
  br label %bb8

bb8:                                              ; preds = %bb7
  %17 = load i16, i16* %light, align 2
  %18 = add i16 %17, %_14
  store i16 %18, i16* %light, align 2
  br label %bb3
}

; Function Attrs: nounwind
declare void @gpioTwiddle() unnamed_addr #0

; Function Attrs: nounwind
define void @output_guard_end() unnamed_addr #0 {
start:
  call void @end_atomic()
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: nounwind
declare void @end_atomic() unnamed_addr #0

; Function Attrs: nounwind
define void @atomic_start() unnamed_addr #0 {
start:
  %local = load i16, i16* @atomic_depth, align 2
  call void @start_atomic()
  br label %bb1

bb1:                                              ; preds = %start
  ret void
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
declare void @start_atomic() unnamed_addr #0

; Function Attrs: inlinehint nounwind
define internal zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$u16$GT$2lt17h1444c976cc58b097E"(i16* noalias readonly align 2 dereferenceable(2) %self, i16* noalias readonly align 2 dereferenceable(2) %other) unnamed_addr #1 {
start:
  %_3 = load i16, i16* %self, align 2
  %_4 = load i16, i16* %other, align 2
  %0 = icmp ult i16 %_3, %_4
  ret i1 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$u16$GT$5clone17ha92bd836d1577855E"(i16* noalias readonly align 2 dereferenceable(2) %self) unnamed_addr #1 {
start:
  %0 = load i16, i16* %self, align 2
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN47_$LT$u16$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17hea15312ae1e87443E"(i16 %start1, i16 %n) unnamed_addr #1 {
start:
  %0 = call i16 @"_ZN4core3num21_$LT$impl$u20$u16$GT$13unchecked_add17h98b4e04aba1f3008E"(i16 %start1, i16 %n)
  br label %bb1

bb1:                                              ; preds = %start
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @_ZN4core3mem7replace17h5b9f2f8c74edc485E(i16* align 2 dereferenceable(2) %dest, i16) unnamed_addr #1 {
start:
  %src = alloca i16, align 2
  store i16 %0, i16* %src, align 2
  call void @_ZN4core3mem4swap17hd118a00096fc1743E(i16* align 2 dereferenceable(2) %dest, i16* align 2 dereferenceable(2) %src)
  br label %bb1

bb1:                                              ; preds = %start
  %1 = load i16, i16* %src, align 2
  ret i16 %1
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3mem4swap17hd118a00096fc1743E(i16* align 2 dereferenceable(2) %x, i16* align 2 dereferenceable(2) %y) unnamed_addr #1 {
start:
  call void @_ZN4core3ptr23swap_nonoverlapping_one17h6f7d9aabf53d847eE(i16* %x, i16* %y)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr23swap_nonoverlapping_one17h6f7d9aabf53d847eE(i16* %x, i16* %y) unnamed_addr #1 {
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
  call void @_ZN4core3ptr19swap_nonoverlapping17h03df8eda8d22ea32E(i16* %x, i16* %y, i16 1)
  br label %bb7

bb3:                                              ; preds = %bb1
  %z = call i16 @_ZN4core3ptr4read17h47e18a4d89a497c3E(i16* %x)
  br label %bb4

bb4:                                              ; preds = %bb3
  call void @_ZN4core10intrinsics19copy_nonoverlapping17ha64df3b876d9c1b4E(i16* %y, i16* %x, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  call void @_ZN4core3ptr5write17h013a437ded7280f9E(i16* %y, i16 %z)
  br label %bb6

bb6:                                              ; preds = %bb5
  br label %bb8

bb7:                                              ; preds = %bb2
  br label %bb8

bb8:                                              ; preds = %bb7, %bb6
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr19swap_nonoverlapping17h03df8eda8d22ea32E(i16* %x, i16* %y, i16 %count) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %x1 = bitcast i16* %x to i8*
  %y2 = bitcast i16* %y to i8*
  store i16 2, i16* %0, align 2
  %1 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %len = mul i16 %1, %count
  call void @_ZN4core3ptr25swap_nonoverlapping_bytes17h33e6c97bd845050eE(i8* %x1, i8* %y2, i16 %len)
  br label %bb2

bb2:                                              ; preds = %bb1
  ret void
}

; Function Attrs: inlinehint nounwind
define internal i16 @_ZN4core3ptr4read17h47e18a4d89a497c3E(i16* %src) unnamed_addr #1 {
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
  call void @_ZN4core10intrinsics19copy_nonoverlapping17ha64df3b876d9c1b4E(i16* %src, i16* %tmp, i16 1)
  br label %bb3

bb3:                                              ; preds = %bb2
  %_7 = load i16, i16* %tmp, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  ret i16 %_7
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core10intrinsics19copy_nonoverlapping17ha64df3b876d9c1b4E(i16* %src, i16* %dst, i16 %count) unnamed_addr #1 {
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
define internal void @_ZN4core3ptr5write17h013a437ded7280f9E(i16* %dst, i16 %src) unnamed_addr #1 {
start:
  %0 = alloca {}, align 1
  store i16 %src, i16* %dst, align 2
  ret void
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN4core3num21_$LT$impl$u20$u16$GT$13unchecked_add17h98b4e04aba1f3008E"(i16 %self, i16 %rhs) unnamed_addr #1 {
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

; Function Attrs: nounwind readnone
declare i1 @llvm.expect.i1(i1, i1) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i16(i8* nocapture writeonly, i8, i16, i1 immarg) #2

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

; Function Attrs: inlinehint nounwind
define i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$3add17h02212dc06e61a034E"(i8* %self, i16 %count) unnamed_addr #1 {
start:
  %0 = call i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$6offset17h2e1a7811e3081d04E"(i8* %self, i16 %count)
  br label %bb1

bb1:                                              ; preds = %start
  ret i8* %0
}

; Function Attrs: nounwind
declare void @llvm.assume(i1) #4

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.usub.with.overflow.i16(i16, i16) #5

; Function Attrs: nounwind readnone speculatable
declare i16 @llvm.cttz.i16(i16, i1 immarg) #5

; Function Attrs: nounwind readnone speculatable
declare { i32, i1 } @llvm.uadd.with.overflow.i32(i32, i32) #5

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #6

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.uadd.with.overflow.i64(i64, i64) #5

; Function Attrs: nounwind readnone speculatable
declare i16 @llvm.usub.sat.i16(i16, i16) #5

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.ctlz.i32(i32, i1 immarg) #5

; Function Attrs: nounwind readnone speculatable
declare i64 @llvm.ctlz.i64(i64, i1 immarg) #5

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.usub.with.overflow.i64(i64, i64) #5

; Function Attrs: nounwind readnone speculatable
declare i16 @llvm.ctpop.i16(i16) #5

; Function Attrs: nounwind
declare i32 @memcmp(i8*, i8*, i16) unnamed_addr #0

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #5

; Function Attrs: nounwind readnone speculatable
declare { i8, i1 } @llvm.usub.with.overflow.i8(i8, i8) #5

; Function Attrs: nounwind readnone speculatable
declare { i8, i1 } @llvm.uadd.with.overflow.i8(i8, i8) #5

; Function Attrs: nounwind readnone speculatable
declare { i8, i1 } @llvm.umul.with.overflow.i8(i8, i8) #5

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.uadd.with.overflow.i16(i16, i16) #5

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.umul.with.overflow.i16(i16, i16) #5

; Function Attrs: nounwind readnone speculatable
declare { i32, i1 } @llvm.usub.with.overflow.i32(i32, i32) #5

; Function Attrs: nounwind readnone speculatable
declare { i32, i1 } @llvm.umul.with.overflow.i32(i32, i32) #5

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.usub.with.overflow.i128(i128, i128) #5

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.uadd.with.overflow.i128(i128, i128) #5

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.umul.with.overflow.i128(i128, i128) #5

; Function Attrs: nounwind readnone speculatable
declare { i8, i1 } @llvm.ssub.with.overflow.i8(i8, i8) #5

; Function Attrs: nounwind readnone speculatable
declare { i8, i1 } @llvm.sadd.with.overflow.i8(i8, i8) #5

; Function Attrs: nounwind readnone speculatable
declare { i8, i1 } @llvm.smul.with.overflow.i8(i8, i8) #5

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.ssub.with.overflow.i16(i16, i16) #5

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.sadd.with.overflow.i16(i16, i16) #5

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.smul.with.overflow.i16(i16, i16) #5

; Function Attrs: nounwind readnone speculatable
declare { i32, i1 } @llvm.ssub.with.overflow.i32(i32, i32) #5

; Function Attrs: nounwind readnone speculatable
declare { i32, i1 } @llvm.sadd.with.overflow.i32(i32, i32) #5

; Function Attrs: nounwind readnone speculatable
declare { i32, i1 } @llvm.smul.with.overflow.i32(i32, i32) #5

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.ssub.with.overflow.i64(i64, i64) #5

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.sadd.with.overflow.i64(i64, i64) #5

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.smul.with.overflow.i64(i64, i64) #5

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.ssub.with.overflow.i128(i128, i128) #5

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.sadd.with.overflow.i128(i128, i128) #5

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.smul.with.overflow.i128(i128, i128) #5

; Function Attrs: nounwind readnone speculatable
declare i8 @llvm.ctlz.i8(i8, i1 immarg) #5

; Function Attrs: nounwind readnone speculatable
declare i16 @llvm.ctlz.i16(i16, i1 immarg) #5

; Function Attrs: nounwind readnone speculatable
declare i128 @llvm.ctlz.i128(i128, i1 immarg) #5

; Function Attrs: nounwind readnone speculatable
declare i64 @llvm.fshl.i64(i64, i64, i64) #5

; Function Attrs: noreturn nounwind
define void @rust_begin_unwind(%"panic::PanicInfo"* noalias readonly align 2 dereferenceable(8) %_info) unnamed_addr #7 {
start:
  call void asm sideeffect "dint { nop", "~{memory}"() #4, !srcloc !1
  br label %bb1

bb1:                                              ; preds = %start
  br label %bb2

bb2:                                              ; preds = %bb3, %bb1
  call void asm sideeffect "", "~{memory}"() #4, !srcloc !2
  br label %bb3

bb3:                                              ; preds = %bb2
  br label %bb2
}

attributes #0 = { nounwind "target-cpu"="generic" }
attributes #1 = { inlinehint nounwind "target-cpu"="generic" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind readnone }
attributes #4 = { nounwind }
attributes #5 = { nounwind readnone speculatable }
attributes #6 = { cold noreturn nounwind }
attributes #7 = { noreturn nounwind "target-cpu"="generic" }

!0 = !{i16 0, i16 2}
!1 = !{i32 2974937}
!2 = !{i32 2974670}
