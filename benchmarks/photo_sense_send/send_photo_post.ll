; ModuleID = 'send_photo_post.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:16:16-i32:16-i64:16-f32:16-f64:16-a:8-n8:16-S16"
target triple = "msp430-none-unknown-elf"

%"core::option::Option<i32>::Some" = type { [1 x i16], i32, [0 x i16] }
%"core::mem::maybe_uninit::MaybeUninit<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>" = type { [16 x i16] }
%"core::mem::manually_drop::ManuallyDrop<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>" = type { [0 x i16], %"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock", [0 x i16] }
%"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock" = type { [0 x i16], i64, [0 x i16], i64, [0 x i16], i64, [0 x i16], i64, [0 x i16] }
%RadioPkt = type { [0 x i8], i8, [0 x i8], [1 x i8], [0 x i8] }
%"panic::PanicInfo" = type { [0 x i16], { {}*, [3 x i16]* }, [0 x i16], i16*, [0 x i16], %"panic::Location"*, [0 x i16] }
%"panic::Location" = type { [0 x i16], { [0 x i8]*, i16 }, [0 x i16], i32, [0 x i16], i32, [0 x i16] }

@num_dirty_gv = common externally_initialized global i16 0
@_numBoots = common externally_initialized global i16 0
@data_src = global [0 x i8*] zeroinitializer, section ".nv_vars", align 2
@data_dest = global [0 x i8*] zeroinitializer, section ".nv_vars", align 2
@data_size = global [0 x i16] zeroinitializer, section ".nv_vars", align 2
@alloc2 = private unnamed_addr constant <{ [11 x i8] }> <{ [11 x i8] c"send ble\0D\0A\00" }>, align 1
@atomic_depth = external global i16

; Function Attrs: nounwind
declare void @radio_on() unnamed_addr #0

; Function Attrs: nounwind
define internal i16 @_ZN10send_photo10read_light17hf5d0905c297d54f9E(i16 %count) unnamed_addr #0 {
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
  %6 = call { i32, i32 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h51722a82d120b8c3E"(i32 %3, i32 %5)
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
  %9 = call { i16, i32 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h49405c4706fd6350E"({ i32, i32 }* align 2 dereferenceable(8) %iter)
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
define internal { i32, i32 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h51722a82d120b8c3E"(i32 %self.0, i32 %self.1) unnamed_addr #0 {
start:
  %0 = insertvalue { i32, i32 } undef, i32 %self.0, 0
  %1 = insertvalue { i32, i32 } %0, i32 %self.1, 1
  ret { i32, i32 } %1
}

; Function Attrs: inlinehint nounwind
define internal { i16, i32 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h49405c4706fd6350E"({ i32, i32 }* align 2 dereferenceable(8) %self) unnamed_addr #1 {
start:
  %0 = alloca { i16, i32 }, align 2
  %_3 = bitcast { i32, i32 }* %self to i32*
  %_4 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %self, i32 0, i32 1
  %_2 = call zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$i32$GT$2lt17h88d0c43ba5440330E"(i32* noalias readonly align 2 dereferenceable(4) %_3, i32* noalias readonly align 2 dereferenceable(4) %_4)
  br label %bb1

bb1:                                              ; preds = %start
  br i1 %_2, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  %1 = bitcast { i16, i32 }* %0 to i16*
  store i16 0, i16* %1, align 2
  br label %bb7

bb3:                                              ; preds = %bb1
  %_7 = bitcast { i32, i32 }* %self to i32*
  %_6 = call i32 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$i32$GT$5clone17h4f6b6c743b68e877E"(i32* noalias readonly align 2 dereferenceable(4) %_7)
  br label %bb4

bb4:                                              ; preds = %bb3
  %n = call i32 @"_ZN47_$LT$i32$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h5ff179f0c202191dE"(i32 %_6, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  %_10 = bitcast { i32, i32 }* %self to i32*
  %_8 = call i32 @_ZN4core3mem7replace17h25989d0460c449eaE(i32* align 2 dereferenceable(4) %_10, i32 %n)
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
define internal zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$i32$GT$2lt17h88d0c43ba5440330E"(i32* noalias readonly align 2 dereferenceable(4) %self, i32* noalias readonly align 2 dereferenceable(4) %other) unnamed_addr #1 {
start:
  %_3 = load i32, i32* %self, align 2
  %_4 = load i32, i32* %other, align 2
  %0 = icmp slt i32 %_3, %_4
  ret i1 %0
}

; Function Attrs: inlinehint nounwind
define internal i32 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$i32$GT$5clone17h4f6b6c743b68e877E"(i32* noalias readonly align 2 dereferenceable(4) %self) unnamed_addr #1 {
start:
  %0 = load i32, i32* %self, align 2
  ret i32 %0
}

; Function Attrs: inlinehint nounwind
define internal i32 @"_ZN47_$LT$i32$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h5ff179f0c202191dE"(i32 %start1, i16 %n) unnamed_addr #1 {
start:
  %_4 = zext i16 %n to i32
  %0 = call i32 @"_ZN4core3num21_$LT$impl$u20$i32$GT$13unchecked_add17h839de6ff373259b8E"(i32 %start1, i32 %_4)
  br label %bb1

bb1:                                              ; preds = %start
  ret i32 %0
}

; Function Attrs: inlinehint nounwind
define internal i32 @_ZN4core3mem7replace17h25989d0460c449eaE(i32* align 2 dereferenceable(4) %dest, i32) unnamed_addr #1 {
start:
  %src = alloca i32, align 2
  store i32 %0, i32* %src, align 2
  call void @_ZN4core3mem4swap17h155291ca30512974E(i32* align 2 dereferenceable(4) %dest, i32* align 2 dereferenceable(4) %src)
  br label %bb1

bb1:                                              ; preds = %start
  %1 = load i32, i32* %src, align 2
  ret i32 %1
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3mem4swap17h155291ca30512974E(i32* align 2 dereferenceable(4) %x, i32* align 2 dereferenceable(4) %y) unnamed_addr #1 {
start:
  call void @_ZN4core3ptr23swap_nonoverlapping_one17h87a10fe2ac49d3fbE(i32* %x, i32* %y)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr23swap_nonoverlapping_one17h87a10fe2ac49d3fbE(i32* %x, i32* %y) unnamed_addr #1 {
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
  call void @_ZN4core3ptr19swap_nonoverlapping17hbbfe174a67b456b7E(i32* %x, i32* %y, i16 1)
  br label %bb7

bb3:                                              ; preds = %bb1
  %z = call i32 @_ZN4core3ptr4read17hc54be66445a141abE(i32* %x)
  br label %bb4

bb4:                                              ; preds = %bb3
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hc0d7a7e16b5bc738E(i32* %y, i32* %x, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  call void @_ZN4core3ptr5write17hd3a226ff9eccb6ddE(i32* %y, i32 %z)
  br label %bb6

bb6:                                              ; preds = %bb5
  br label %bb8

bb7:                                              ; preds = %bb2
  br label %bb8

bb8:                                              ; preds = %bb7, %bb6
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr19swap_nonoverlapping17hbbfe174a67b456b7E(i32* %x, i32* %y, i16 %count) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %x1 = bitcast i32* %x to i8*
  %y2 = bitcast i32* %y to i8*
  store i16 4, i16* %0, align 2
  %1 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %len = mul i16 %1, %count
  call void @_ZN4core3ptr25swap_nonoverlapping_bytes17h73df6d2cff6e93d2E(i8* %x1, i8* %y2, i16 %len)
  br label %bb2

bb2:                                              ; preds = %bb1
  ret void
}

; Function Attrs: inlinehint nounwind
define internal i32 @_ZN4core3ptr4read17hc54be66445a141abE(i32* %src) unnamed_addr #1 {
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
  call void @_ZN4core10intrinsics19copy_nonoverlapping17hc0d7a7e16b5bc738E(i32* %src, i32* %tmp, i16 1)
  br label %bb3

bb3:                                              ; preds = %bb2
  %_7 = load i32, i32* %tmp, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  ret i32 %_7
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core10intrinsics19copy_nonoverlapping17hc0d7a7e16b5bc738E(i32* %src, i32* %dst, i16 %count) unnamed_addr #1 {
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
define internal void @_ZN4core3ptr5write17hd3a226ff9eccb6ddE(i32* %dst, i32 %src) unnamed_addr #1 {
start:
  %0 = alloca {}, align 1
  store i32 %src, i32* %dst, align 2
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i16(i8* nocapture writeonly, i8* nocapture readonly, i16, i1 immarg) #2

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr25swap_nonoverlapping_bytes17h73df6d2cff6e93d2E(i8* %x, i8* %y, i16 %len) unnamed_addr #1 {
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
define internal i32 @"_ZN4core3num21_$LT$impl$u20$i32$GT$13unchecked_add17h839de6ff373259b8E"(i32 %self, i32 %rhs) unnamed_addr #1 {
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
  %_6 = alloca { i16, i32 }, align 2
  %iter = alloca { i32, i32 }, align 2
  %_3 = alloca { i32, i32 }, align 2
  %count = alloca i16, align 2
  br label %bb0

bb0:                                              ; preds = %bb9, %start
  store i16 0, i16* %count, align 2
  %0 = bitcast { i32, i32 }* %_3 to i32*
  store i32 0, i32* %0, align 2
  %1 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %_3, i32 0, i32 1
  store i32 100, i32* %1, align 2
  %2 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %_3, i32 0, i32 0
  %3 = load i32, i32* %2, align 2
  %4 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %_3, i32 0, i32 1
  %5 = load i32, i32* %4, align 2
  %6 = call { i32, i32 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h51722a82d120b8c3E"(i32 %3, i32 %5)
  %_2.0 = extractvalue { i32, i32 } %6, 0
  %_2.1 = extractvalue { i32, i32 } %6, 1
  br label %bb1

bb1:                                              ; preds = %bb0
  %7 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %iter, i32 0, i32 0
  store i32 %_2.0, i32* %7, align 2
  %8 = getelementptr inbounds { i32, i32 }, { i32, i32 }* %iter, i32 0, i32 1
  store i32 %_2.1, i32* %8, align 2
  br label %bb2

bb2:                                              ; preds = %bb7, %bb1
  %9 = call { i16, i32 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h49405c4706fd6350E"({ i32, i32 }* align 2 dereferenceable(8) %iter)
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
  call void @gpioTwiddle()
  br label %bb8

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %11 = bitcast { i16, i32 }* %_6 to %"core::option::Option<i32>::Some"*
  %12 = getelementptr inbounds %"core::option::Option<i32>::Some", %"core::option::Option<i32>::Some"* %11, i32 0, i32 1
  %val = load i32, i32* %12, align 2
  %_14 = load i16, i16* %count, align 2
  call void @_ZN10send_photo14sense_and_send17hfcf66fd16852e62fE(i16 %_14)
  br label %bb7

bb7:                                              ; preds = %bb6
  %13 = load i16, i16* %count, align 2
  %14 = add i16 %13, 1
  store i16 %14, i16* %count, align 2
  br label %bb2

bb8:                                              ; preds = %bb4
  call void @gpioTwiddle()
  br label %bb9

bb9:                                              ; preds = %bb8
  br label %bb0
}

; Function Attrs: nounwind
declare void @gpioTwiddle() unnamed_addr #0

; Function Attrs: nounwind
define internal void @_ZN10send_photo14sense_and_send17hfcf66fd16852e62fE(i16 %count) unnamed_addr #0 {
start:
  %_24 = alloca [2 x i8], align 1
  %_16 = alloca [1 x i8], align 1
  %packet = alloca %RadioPkt, align 1
  %0 = alloca {}, align 1
  call void @atomic_start()
  %light = call i16 @_ZN10send_photo10read_light17hf5d0905c297d54f9E(i16 %count)
  br label %bb1

bb1:                                              ; preds = %start
  br label %bb2

bb2:                                              ; preds = %bb1
  %_6 = icmp ugt i16 %light, 4000
  br i1 %_6, label %bb4, label %bb3

bb3:                                              ; preds = %bb2
  br label %bb17

bb4:                                              ; preds = %bb2
  call void @start_atomic()
  br label %bb5

bb5:                                              ; preds = %bb4
  %_10 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [11 x i8] }>* @alloc2 to [0 x i8]*), i16 11)
  br label %bb6

bb6:                                              ; preds = %bb5
  call void (i8*, ...) @printf(i8* %_10)
  br label %bb7

bb7:                                              ; preds = %bb6
  call void @end_atomic()
  br label %bb8

bb8:                                              ; preds = %bb7
  %1 = bitcast [1 x i8]* %_16 to i8*
  store i8 119, i8* %1, align 1
  %2 = bitcast %RadioPkt* %packet to i8*
  store i8 0, i8* %2, align 1
  %3 = getelementptr inbounds %RadioPkt, %RadioPkt* %packet, i32 0, i32 3
  %4 = bitcast [1 x i8]* %3 to i8*
  %5 = bitcast [1 x i8]* %_16 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %4, i8* align 1 %5, i16 1, i1 false)
  call void @radio_on()
  br label %bb9

bb9:                                              ; preds = %bb8
  call void @msp_sleep(i16 60)
  br label %bb10

bb10:                                             ; preds = %bb9
  call void @uartlink_open_tx()
  br label %bb11

bb11:                                             ; preds = %bb10
  %6 = bitcast %RadioPkt* %packet to i8*
  %_25 = load i8, i8* %6, align 1
  %7 = getelementptr inbounds %RadioPkt, %RadioPkt* %packet, i32 0, i32 3
  %8 = getelementptr inbounds [1 x i8], [1 x i8]* %7, i16 0, i16 0
  %_26 = load i8, i8* %8, align 1
  %9 = bitcast [2 x i8]* %_24 to i8*
  store i8 %_25, i8* %9, align 1
  %10 = getelementptr inbounds [2 x i8], [2 x i8]* %_24, i32 0, i32 1
  store i8 %_26, i8* %10, align 1
  %_22.0 = bitcast [2 x i8]* %_24 to [0 x i8]*
  %_21 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 %_22.0, i16 2)
  br label %bb12

bb12:                                             ; preds = %bb11
  call void @uartlink_send(i8* %_21, i16 2)
  br label %bb13

bb13:                                             ; preds = %bb12
  call void @uartlink_close()
  br label %bb14

bb14:                                             ; preds = %bb13
  call void @msp_sleep(i16 30)
  br label %bb15

bb15:                                             ; preds = %bb14
  call void @radio_off()
  br label %bb16

bb16:                                             ; preds = %bb15
  br label %bb17

bb17:                                             ; preds = %bb16, %bb3
  call void @atomic_end()
  ret void
}

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
declare void @start_atomic() unnamed_addr #0

; Function Attrs: nounwind
declare void @printf(i8*, ...) unnamed_addr #0

; Function Attrs: nounwind
declare void @end_atomic() unnamed_addr #0

; Function Attrs: nounwind
declare void @msp_sleep(i16) unnamed_addr #0

; Function Attrs: nounwind
declare void @uartlink_open_tx() unnamed_addr #0

; Function Attrs: nounwind
declare void @uartlink_send(i8*, i16) unnamed_addr #0

; Function Attrs: nounwind
declare void @uartlink_close() unnamed_addr #0

; Function Attrs: nounwind
declare void @radio_off() unnamed_addr #0

; Function Attrs: nounwind
define void @atomic_end() unnamed_addr #0 {
start:
  call void @end_atomic()
  br label %bb1

bb1:                                              ; preds = %start
  ret void
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
