; ModuleID = 'tire_post.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:16:16-i32:16-i64:16-f32:16-f64:16-a:8-n8:16-S16"
target triple = "msp430-none-unknown-elf"

%"fmt::USIZE_MARKER::{{closure}}" = type {}
%threeAxis = type { [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8] }
%History = type { [0 x i16], i16, [0 x i16], [5 x i16], [0 x i16], i16, [0 x i16], i16, [0 x i16] }
%"core::option::Option<u16>::Some" = type { [1 x i16], i16, [0 x i16] }
%"core::panic::Location" = type { [0 x i16], { [0 x i8]*, i16 }, [0 x i16], i32, [0 x i16], i32, [0 x i16] }
%"core::str::{{impl}}::as_bytes::Slices" = type { [2 x i16] }
%"core::mem::maybe_uninit::MaybeUninit<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>" = type { [16 x i16] }
%"core::mem::manually_drop::ManuallyDrop<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>" = type { [0 x i16], %"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock", [0 x i16] }
%"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock" = type { [0 x i16], i64, [0 x i16], i64, [0 x i16], i64, [0 x i16], i64, [0 x i16] }
%"fmt::Arguments" = type { [0 x i16], { [0 x { [0 x i8]*, i16 }]*, i16 }, [0 x i16], { i16*, i16 }, [0 x i16], { [0 x { i8*, i8* }]*, i16 }, [0 x i16] }
%"fmt::Formatter" = type { [0 x i16], i32, [0 x i16], i32, [0 x i16], { i16, i16 }, [0 x i16], { i16, i16 }, [0 x i16], { {}*, [3 x i16]* }, [0 x i8], i8, [1 x i8] }
%"panic::PanicInfo" = type { [0 x i16], { {}*, [3 x i16]* }, [0 x i16], i16*, [0 x i16], %"core::panic::Location"*, [0 x i16] }

@num_dirty_gv = common externally_initialized global i16 0
@_numBoots = common externally_initialized global i16 0
@data_src = global [2 x i8*] zeroinitializer, section ".nv_vars", align 2
@data_dest = global [2 x i8*] zeroinitializer, section ".nv_vars", align 2
@data_size = global [2 x i16] zeroinitializer, section ".nv_vars", align 2
@_ZN4tire3app6UWC_NV17h0bddde4b6c2ae94cE = internal global <{ [2 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN4tire3app6MWC_NV17h12a36e36be008beeE = internal global <{ [2 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN4tire3app8COUNT_NV17hd67dd01413b6dd2eE = internal global <{ [2 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN4tire3app7SEED_NV17h016474e634f6f8dfE = internal global <{ [2 x i8] }> <{ [2 x i8] c"\01\00" }>, section ".nv_vars", align 2
@_ZN4tire3app7HIST_NV17h9c8565d5c90d348aE = internal global <{ [16 x i8] }> zeroinitializer, section ".nv_vars", align 2
@atomic_depth = external global i16
@_ZN4tire3app7SEED_NV17h016474e634f6f8dfE_bak = internal global <{ [2 x i8] }> <{ [2 x i8] c"\01\00" }>, section ".nv_vars", align 2
@_ZN4tire3app6UWC_NV17h0bddde4b6c2ae94cE_bak = internal global <{ [2 x i8] }> zeroinitializer, section ".nv_vars", align 2
@alloc83 = private unnamed_addr constant <{ [21 x i8] }> <{ [21 x i8] c"urgent_burst_tire!\0D\0A\00" }>, align 1
@alloc85 = private unnamed_addr constant <{ [22 x i8] }> <{ [22 x i8] c"medium_low_pressure\0D\0A\00" }>, align 1
@alloc84 = private unnamed_addr constant <{ [22 x i8] }> <{ [22 x i8] c"urgent_low_pressure\0D\0A\00" }>, align 1
@alloc76 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc81, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\BD\00\00\00\22\00\00\00" }>, align 2
@alloc78 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc81, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\BD\00\00\00\09\00\00\00" }>, align 2
@alloc80 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc81, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\BE\00\00\00\11\00\00\00" }>, align 2
@alloc81 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"src/lib.rs" }>, align 1
@str.0 = internal constant [57 x i8] c"attempt to calculate the remainder with a divisor of zero"
@alloc60 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [112 x i8] }>, <{ [112 x i8] }>* @alloc59, i32 0, i32 0, i32 0), [10 x i8] c"p\00\12\02\00\00-\00\00\00" }>, align 2
@alloc59 = private unnamed_addr constant <{ [112 x i8] }> <{ [112 x i8] c"/home/reviewer/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/libcore/ops/arith.rs" }>, align 1
@alloc64 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc81, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\96\00\00\00\11\00\00\00" }>, align 2
@alloc66 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc81, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\9B\00\00\00\0D\00\00\00" }>, align 2
@alloc68 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc81, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\9D\00\00\00\11\00\00\00" }>, align 2
@alloc70 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc81, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A2\00\00\00\0D\00\00\00" }>, align 2
@alloc72 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc81, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A4\00\00\00\11\00\00\00" }>, align 2
@alloc74 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc81, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A9\00\00\00\0D\00\00\00" }>, align 2
@alloc62 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc81, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\82\00\00\00\09\00\00\00" }>, align 2
@alloc5 = private unnamed_addr constant <{ [23 x i8] }> <{ [23 x i8] c"Urgent: %l Medium: %l\0A\00" }>, align 1
@alloc82 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc81, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\E3\00\00\00\09\00\00\00" }>, align 2
@anon.b7bafff2f871b915b57b152a19c6233b.18 = private unnamed_addr constant <{ i8*, [0 x i8] }> <{ i8* bitcast (<{ i8*, [2 x i8], i8*, [2 x i8] }>* @alloc16077 to i8*), [0 x i8] zeroinitializer }>, align 2
@anon.b7bafff2f871b915b57b152a19c6233b.10 = private unnamed_addr constant <{ i8*, [0 x i8] }> <{ i8* getelementptr inbounds (<{ [0 x i8] }>, <{ [0 x i8] }>* @alloc18891, i32 0, i32 0, i32 0), [0 x i8] zeroinitializer }>, align 2
@vtable.c = private unnamed_addr constant { void (%"fmt::USIZE_MARKER::{{closure}}"*)*, i16, i16, i64 (%"fmt::USIZE_MARKER::{{closure}}"*)* } { void (%"fmt::USIZE_MARKER::{{closure}}"*)* undef, i16 0, i16 1, i64 (%"fmt::USIZE_MARKER::{{closure}}"*)* undef }, align 2
@alloc18891 = private unnamed_addr constant <{ [0 x i8] }> zeroinitializer, align 2
@alloc16077 = private unnamed_addr constant <{ i8*, [2 x i8], i8*, [2 x i8] }> <{ i8* getelementptr inbounds (<{ [32 x i8] }>, <{ [32 x i8] }>* @alloc16075, i32 0, i32 0, i32 0), [2 x i8] c" \00", i8* getelementptr inbounds (<{ [18 x i8] }>, <{ [18 x i8] }>* @alloc16076, i32 0, i32 0, i32 0), [2 x i8] c"\12\00" }>, align 2
@alloc16075 = private unnamed_addr constant <{ [32 x i8] }> <{ [32 x i8] c"index out of bounds: the len is " }>, align 1
@alloc16076 = private unnamed_addr constant <{ [18 x i8] }> <{ [18 x i8] c" but the index is " }>, align 1

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
  %currMotion = alloca [3 x %threeAxis], align 1
  %_67 = alloca i16, align 2
  %_61 = alloca i16, align 2
  %window = alloca [3 x %threeAxis], align 1
  %_28 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_25 = alloca { i16, i16 }, align 2
  br label %bb1

bb1:                                              ; preds = %bb56, %start
  store i16 0, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app6UWC_NV17h0bddde4b6c2ae94cE to i16*), align 2
  store i16 0, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app6MWC_NV17h12a36e36be008beeE to i16*), align 2
  store i16 0, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app8COUNT_NV17hd67dd01413b6dd2eE to i16*), align 2
  store i16 0, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE to i16*), align 2
  call void @_ZN4tire10initRecord17h4d5be82bd1fa40d1E(%History* align 2 dereferenceable(16) bitcast (<{ [16 x i8] }>* @_ZN4tire3app7HIST_NV17h9c8565d5c90d348aE to %History*), i16* align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE to i16*))
  br label %bb2

bb2:                                              ; preds = %bb1
  %0 = bitcast { i16, i16 }* %_25 to i16*
  store i16 0, i16* %0, align 2
  %1 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_25, i32 0, i32 1
  store i16 264, i16* %1, align 2
  %2 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_25, i32 0, i32 0
  %3 = load i16, i16* %2, align 2
  %4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_25, i32 0, i32 1
  %5 = load i16, i16* %4, align 2
  %6 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17ha723f69cdb07f821E"(i16 %3, i16 %5)
  %_24.0 = extractvalue { i16, i16 } %6, 0
  %_24.1 = extractvalue { i16, i16 } %6, 1
  br label %bb3

bb3:                                              ; preds = %bb2
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_24.0, i16* %7, align 2
  %8 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_24.1, i16* %8, align 2
  br label %bb4

bb4:                                              ; preds = %bb53, %bb14, %bb3
  %9 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h93f3136ef38c4f37E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %9, { i16, i16 }* %_28, align 2
  br label %bb5

bb5:                                              ; preds = %bb4
  %10 = bitcast { i16, i16 }* %_28 to i16*
  %_31 = load i16, i16* %10, align 2, !range !0
  switch i16 %_31, label %bb7 [
    i16 0, label %bb6
    i16 1, label %bb8
  ]

bb6:                                              ; preds = %bb5
  call void @_ZN4tire16end_of_benchmark17hc49878f77d773b9aE(i16* noalias readonly align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN4tire3app6UWC_NV17h0bddde4b6c2ae94cE to i16*), i16* noalias readonly align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN4tire3app6MWC_NV17h12a36e36be008beeE to i16*))
  br label %bb54

bb7:                                              ; preds = %bb5
  unreachable

bb8:                                              ; preds = %bb5
  %11 = bitcast { i16, i16 }* %_28 to %"core::option::Option<u16>::Some"*
  %12 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %11, i32 0, i32 1
  %val = load i16, i16* %12, align 2
  call void @_ZN4tire13acquireWindow17h334a29275df02eddE([3 x %threeAxis]* noalias nocapture sret dereferenceable(9) %window, i16* align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE to i16*))
  br label %bb9

bb9:                                              ; preds = %bb8
  %_38 = call zeroext i1 @_ZN4tire8isMoving17h75519792ea0be3a4E([3 x %threeAxis]* noalias readonly align 1 dereferenceable(9) %window)
  br label %bb10

bb10:                                             ; preds = %bb9
  %_37 = icmp eq i1 %_38, false
  br i1 %_37, label %bb12, label %bb11

bb11:                                             ; preds = %bb10
  br label %bb15

bb12:                                             ; preds = %bb10
  %_42 = urem i16 %val, 3
  %_41 = icmp ne i16 %_42, 0
  br i1 %_41, label %bb14, label %bb13

bb13:                                             ; preds = %bb12
  br label %bb15

bb14:                                             ; preds = %bb12
  br label %bb4

bb15:                                             ; preds = %bb13, %bb11
  call void @atomic_start()
  %13 = load volatile i16, i16* @atomic_depth
  %14 = icmp eq i16 0, %13
  br i1 %14, label %bb15.split1, label %bb15.split

bb15.split1:                                      ; preds = %bb15
  %15 = load <{ [2 x i8] }>, <{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE
  store <{ [2 x i8] }> %15, <{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE_bak
  %16 = bitcast <{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE to i8*
  %17 = bitcast <{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE_bak to i8*
  %18 = getelementptr inbounds <{ [2 x i8] }>, <{ [2 x i8] }>* null, i16 1
  %19 = ptrtoint <{ [2 x i8] }>* %18 to i16
  call void @log_entry(i8* %16, i8* %17, i16 %19)
  br label %bb15.split

bb15.split:                                       ; preds = %bb15, %bb15.split1
  %reading = call i16 @_ZN4tire16relativePressure17h00e38ad946681b37E(i16* noalias readonly align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE to i16*))
  br label %bb16

bb16:                                             ; preds = %bb15.split
  br label %bb17

bb17:                                             ; preds = %bb16
  %adjusted = call i16 @_ZN4tire12coldPressure17h8892e3580fb87861E(i16 %reading, i16* align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE to i16*))
  call void @atomic_end()
  br label %bb18

bb18:                                             ; preds = %bb17
  call void @_ZN4tire16updateHistorical17hb1ff916b822a9be9E(%History* align 2 dereferenceable(16) bitcast (<{ [16 x i8] }>* @_ZN4tire3app7HIST_NV17h9c8565d5c90d348aE to %History*), i16 %adjusted)
  br label %bb19

bb19:                                             ; preds = %bb18
  %_55 = load i16, i16* getelementptr inbounds (%History, %History* bitcast (<{ [16 x i8] }>* @_ZN4tire3app7HIST_NV17h9c8565d5c90d348aE to %History*), i32 0, i32 7), align 2
  %_54 = icmp ugt i16 %_55, 25
  br i1 %_54, label %bb21, label %bb20

bb20:                                             ; preds = %bb19
  %_90 = load i16, i16* getelementptr inbounds (%History, %History* bitcast (<{ [16 x i8] }>* @_ZN4tire3app7HIST_NV17h9c8565d5c90d348aE to %History*), i32 0, i32 0, i32 0), align 2
  %_89 = icmp ult i16 %_90, 200
  br i1 %_89, label %bb42, label %bb41

bb21:                                             ; preds = %bb19
  call void @atomic_start()
  %20 = load volatile i16, i16* @atomic_depth
  %21 = icmp eq i16 0, %20
  br i1 %21, label %bb21.split2, label %bb21.split

bb21.split2:                                      ; preds = %bb21
  %22 = load <{ [2 x i8] }>, <{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE
  store <{ [2 x i8] }> %22, <{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE_bak
  %23 = bitcast <{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE to i8*
  %24 = bitcast <{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE_bak to i8*
  %25 = getelementptr inbounds <{ [2 x i8] }>, <{ [2 x i8] }>* null, i16 1
  %26 = ptrtoint <{ [2 x i8] }>* %25 to i16
  call void @log_entry(i8* %23, i8* %24, i16 %26)
  %27 = load <{ [2 x i8] }>, <{ [2 x i8] }>* @_ZN4tire3app6UWC_NV17h0bddde4b6c2ae94cE
  store <{ [2 x i8] }> %27, <{ [2 x i8] }>* @_ZN4tire3app6UWC_NV17h0bddde4b6c2ae94cE_bak
  %28 = bitcast <{ [2 x i8] }>* @_ZN4tire3app6UWC_NV17h0bddde4b6c2ae94cE to i8*
  %29 = bitcast <{ [2 x i8] }>* @_ZN4tire3app6UWC_NV17h0bddde4b6c2ae94cE_bak to i8*
  %30 = getelementptr inbounds <{ [2 x i8] }>, <{ [2 x i8] }>* null, i16 1
  %31 = ptrtoint <{ [2 x i8] }>* %30 to i16
  call void @log_entry(i8* %28, i8* %29, i16 %31)
  br label %bb21.split

bb21.split:                                       ; preds = %bb21, %bb21.split2
  call void @atomic_start()
  %reading0 = call i16 @_ZN4tire16relativePressure17h00e38ad946681b37E(i16* noalias readonly align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE to i16*))
  br label %bb22

bb22:                                             ; preds = %bb21.split
  %reading1 = call i16 @_ZN4tire16relativePressure17h00e38ad946681b37E(i16* noalias readonly align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE to i16*))
  br label %bb23

bb23:                                             ; preds = %bb22
  %_64 = load i16, i16* getelementptr inbounds (%History, %History* bitcast (<{ [16 x i8] }>* @_ZN4tire3app7HIST_NV17h9c8565d5c90d348aE to %History*), i32 0, i32 7), align 2
  %_62 = icmp ult i16 %reading0, %_64
  br i1 %_62, label %bb25, label %bb24

bb24:                                             ; preds = %bb23
  store i16 0, i16* %_61, align 2
  br label %bb26

bb25:                                             ; preds = %bb23
  %_65 = load i16, i16* getelementptr inbounds (%History, %History* bitcast (<{ [16 x i8] }>* @_ZN4tire3app7HIST_NV17h9c8565d5c90d348aE to %History*), i32 0, i32 7), align 2
  %32 = sub i16 %_65, %reading0
  store i16 %32, i16* %_61, align 2
  br label %bb26

bb26:                                             ; preds = %bb25, %bb24
  %_68 = icmp ult i16 %reading1, %reading0
  br i1 %_68, label %bb28, label %bb27

bb27:                                             ; preds = %bb26
  store i16 0, i16* %_67, align 2
  br label %bb29

bb28:                                             ; preds = %bb26
  %33 = sub i16 %reading0, %reading1
  store i16 %33, i16* %_67, align 2
  br label %bb29

bb29:                                             ; preds = %bb28, %bb27
  %34 = load i16, i16* %_61, align 2
  %35 = load i16, i16* %_67, align 2
  %sumDiff = add i16 %34, %35
  %avgDiff = udiv i16 %sumDiff, 2
  br label %bb30

bb30:                                             ; preds = %bb29
  call void @atomic_start()
  call void @_ZN4tire13acquireWindow17h334a29275df02eddE([3 x %threeAxis]* noalias nocapture sret dereferenceable(9) %currMotion, i16* align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE to i16*))
  call void @atomic_end()
  br label %bb31

bb31:                                             ; preds = %bb30
  br label %bb32

bb32:                                             ; preds = %bb31
  %_81 = call zeroext i1 @_ZN4tire8isMoving17h75519792ea0be3a4E([3 x %threeAxis]* noalias readonly align 1 dereferenceable(9) %currMotion)
  br label %bb33

bb33:                                             ; preds = %bb32
  br i1 %_81, label %bb35, label %bb34

bb34:                                             ; preds = %bb33
  br label %bb40

bb35:                                             ; preds = %bb33
  %_84 = icmp ugt i16 %avgDiff, 0
  br i1 %_84, label %bb37, label %bb36

bb36:                                             ; preds = %bb35
  br label %bb39

bb37:                                             ; preds = %bb35
  call void @_ZN4tire8sendData17hf159beeb0d41b37dE([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [21 x i8] }>* @alloc83 to [0 x i8]*), i16 21)
  br label %bb38

bb38:                                             ; preds = %bb37
  %36 = load i16, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app6UWC_NV17h0bddde4b6c2ae94cE to i16*), align 2
  %37 = add i16 %36, 1
  store i16 %37, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app6UWC_NV17h0bddde4b6c2ae94cE to i16*), align 2
  br label %bb39

bb39:                                             ; preds = %bb38, %bb36
  br label %bb40

bb40:                                             ; preds = %bb39, %bb34
  call void @atomic_end()
  call void @atomic_end()
  br label %bb49

bb41:                                             ; preds = %bb20
  br label %bb48

bb42:                                             ; preds = %bb20
  %38 = load i16, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app8COUNT_NV17hd67dd01413b6dd2eE to i16*), align 2
  %39 = add i16 %38, 1
  store i16 %39, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app8COUNT_NV17hd67dd01413b6dd2eE to i16*), align 2
  %_92 = load i16, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app8COUNT_NV17hd67dd01413b6dd2eE to i16*), align 2
  %_91 = icmp ugt i16 %_92, 1000
  br i1 %_91, label %bb44, label %bb43

bb43:                                             ; preds = %bb42
  call void @_ZN4tire8sendData17hf159beeb0d41b37dE([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [22 x i8] }>* @alloc85 to [0 x i8]*), i16 22)
  br label %bb46

bb44:                                             ; preds = %bb42
  call void @_ZN4tire8sendData17hf159beeb0d41b37dE([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [22 x i8] }>* @alloc84 to [0 x i8]*), i16 22)
  br label %bb45

bb45:                                             ; preds = %bb44
  %40 = load i16, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app6UWC_NV17h0bddde4b6c2ae94cE to i16*), align 2
  %41 = add i16 %40, 1
  store i16 %41, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app6UWC_NV17h0bddde4b6c2ae94cE to i16*), align 2
  br label %bb47

bb46:                                             ; preds = %bb43
  %42 = load i16, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app6MWC_NV17h12a36e36be008beeE to i16*), align 2
  %43 = add i16 %42, 1
  store i16 %43, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app6MWC_NV17h12a36e36be008beeE to i16*), align 2
  br label %bb47

bb47:                                             ; preds = %bb46, %bb45
  br label %bb48

bb48:                                             ; preds = %bb47, %bb41
  br label %bb49

bb49:                                             ; preds = %bb48, %bb40
  %_100 = load i16, i16* getelementptr inbounds (%History, %History* bitcast (<{ [16 x i8] }>* @_ZN4tire3app7HIST_NV17h9c8565d5c90d348aE to %History*), i32 0, i32 7), align 2
  %_99 = icmp eq i16 %_100, 0
  br i1 %_99, label %bb51, label %bb50

bb50:                                             ; preds = %bb49
  br label %bb53

bb51:                                             ; preds = %bb49
  call void @_ZN4tire10initRecord17h4d5be82bd1fa40d1E(%History* align 2 dereferenceable(16) bitcast (<{ [16 x i8] }>* @_ZN4tire3app7HIST_NV17h9c8565d5c90d348aE to %History*), i16* align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN4tire3app7SEED_NV17h016474e634f6f8dfE to i16*))
  br label %bb52

bb52:                                             ; preds = %bb51
  store i16 0, i16* bitcast (<{ [2 x i8] }>* @_ZN4tire3app8COUNT_NV17hd67dd01413b6dd2eE to i16*), align 2
  br label %bb53

bb53:                                             ; preds = %bb52, %bb50
  br label %bb4

bb54:                                             ; preds = %bb6
  call void @gpioTwiddle()
  br label %bb55

bb55:                                             ; preds = %bb54
  call void @gpioTwiddle()
  br label %bb56

bb56:                                             ; preds = %bb55
  br label %bb1
}

; Function Attrs: nounwind
define internal void @_ZN4tire10initRecord17h4d5be82bd1fa40d1E(%History* align 2 dereferenceable(16) %rec, i16* align 2 dereferenceable(2) %seed) unnamed_addr #0 {
start:
  %_25 = alloca i16, align 2
  %_8 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_5 = alloca { i16, i16 }, align 2
  %mean = alloca i16, align 2
  store i16 0, i16* %mean, align 2
  %0 = bitcast { i16, i16 }* %_5 to i16*
  store i16 0, i16* %0, align 2
  %1 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_5, i32 0, i32 1
  store i16 5, i16* %1, align 2
  %2 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_5, i32 0, i32 0
  %3 = load i16, i16* %2, align 2
  %4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_5, i32 0, i32 1
  %5 = load i16, i16* %4, align 2
  %6 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h820c98c80fab166dE"(i16 %3, i16 %5)
  %_4.0 = extractvalue { i16, i16 } %6, 0
  %_4.1 = extractvalue { i16, i16 } %6, 1
  br label %bb1

bb1:                                              ; preds = %start
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_4.0, i16* %7, align 2
  %8 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_4.1, i16* %8, align 2
  br label %bb2

bb2:                                              ; preds = %bb9, %bb1
  %9 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %9, { i16, i16 }* %_8, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %10 = bitcast { i16, i16 }* %_8 to i16*
  %_11 = load i16, i16* %10, align 2, !range !0
  switch i16 %_11, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  %11 = getelementptr inbounds %History, %History* %rec, i32 0, i32 3
  %12 = getelementptr inbounds [5 x i16], [5 x i16]* %11, i16 0, i16 1
  %_27 = load i16, i16* %12, align 2
  %13 = getelementptr inbounds %History, %History* %rec, i32 0, i32 3
  %14 = getelementptr inbounds [5 x i16], [5 x i16]* %13, i16 0, i16 0
  %_29 = load i16, i16* %14, align 2
  %_26 = icmp ugt i16 %_27, %_29
  br i1 %_26, label %bb11, label %bb10

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %15 = bitcast { i16, i16 }* %_8 to %"core::option::Option<u16>::Some"*
  %16 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %15, i32 0, i32 1
  %val = load i16, i16* %16, align 2
  %reading = call i16 @_ZN4tire16relativePressure17h00e38ad946681b37E(i16* noalias readonly align 2 dereferenceable(2) %seed)
  br label %bb7

bb7:                                              ; preds = %bb6
  %adjusted = call i16 @_ZN4tire12coldPressure17h8892e3580fb87861E(i16 %reading, i16* align 2 dereferenceable(2) %seed)
  br label %bb8

bb8:                                              ; preds = %bb7
  %_23 = icmp ult i16 %val, 5
  %17 = call i1 @llvm.expect.i1(i1 %_23, i1 true)
  br i1 %17, label %bb9, label %panic

bb9:                                              ; preds = %bb8
  %18 = getelementptr inbounds %History, %History* %rec, i32 0, i32 3
  %19 = getelementptr inbounds [5 x i16], [5 x i16]* %18, i16 0, i16 %val
  store i16 %adjusted, i16* %19, align 2
  %20 = load i16, i16* %mean, align 2
  %21 = add i16 %20, %adjusted
  store i16 %21, i16* %mean, align 2
  br label %bb2

bb10:                                             ; preds = %bb4
  store i16 0, i16* %_25, align 2
  br label %bb12

bb11:                                             ; preds = %bb4
  %22 = getelementptr inbounds %History, %History* %rec, i32 0, i32 3
  %23 = getelementptr inbounds [5 x i16], [5 x i16]* %22, i16 0, i16 1
  %_31 = load i16, i16* %23, align 2
  %24 = getelementptr inbounds %History, %History* %rec, i32 0, i32 3
  %25 = getelementptr inbounds [5 x i16], [5 x i16]* %24, i16 0, i16 0
  %_33 = load i16, i16* %25, align 2
  %26 = sub i16 %_31, %_33
  store i16 %26, i16* %_25, align 2
  br label %bb12

bb12:                                             ; preds = %bb11, %bb10
  %27 = getelementptr inbounds %History, %History* %rec, i32 0, i32 7
  %28 = load i16, i16* %_25, align 2
  store i16 %28, i16* %27, align 2
  %29 = getelementptr inbounds %History, %History* %rec, i32 0, i32 3
  %30 = getelementptr inbounds [5 x i16], [5 x i16]* %29, i16 0, i16 0
  %_35 = load i16, i16* %30, align 2
  %31 = getelementptr inbounds %History, %History* %rec, i32 0, i32 5
  store i16 %_35, i16* %31, align 2
  %32 = load i16, i16* %mean, align 2
  %33 = udiv i16 %32, 5
  store i16 %33, i16* %mean, align 2
  %_38 = load i16, i16* %mean, align 2
  %34 = bitcast %History* %rec to i16*
  store i16 %_38, i16* %34, align 2
  ret void

panic:                                            ; preds = %bb8
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 5, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc82 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define internal { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17ha723f69cdb07f821E"(i16 %self.0, i16 %self.1) unnamed_addr #0 {
start:
  %0 = insertvalue { i16, i16 } undef, i16 %self.0, 0
  %1 = insertvalue { i16, i16 } %0, i16 %self.1, 1
  ret { i16, i16 } %1
}

; Function Attrs: inlinehint nounwind
define internal { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h93f3136ef38c4f37E"({ i16, i16 }* align 2 dereferenceable(4) %self) unnamed_addr #1 {
start:
  %0 = alloca { i16, i16 }, align 2
  %_3 = bitcast { i16, i16 }* %self to i16*
  %_4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %self, i32 0, i32 1
  %_2 = call zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$u16$GT$2lt17haf273cef1841016cE"(i16* noalias readonly align 2 dereferenceable(2) %_3, i16* noalias readonly align 2 dereferenceable(2) %_4)
  br label %bb1

bb1:                                              ; preds = %start
  br i1 %_2, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  %1 = bitcast { i16, i16 }* %0 to i16*
  store i16 0, i16* %1, align 2
  br label %bb7

bb3:                                              ; preds = %bb1
  %_7 = bitcast { i16, i16 }* %self to i16*
  %_6 = call i16 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$u16$GT$5clone17h0e60b2fd5874ec2bE"(i16* noalias readonly align 2 dereferenceable(2) %_7)
  br label %bb4

bb4:                                              ; preds = %bb3
  %n = call i16 @"_ZN47_$LT$u16$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h9df8c8309313fc3cE"(i16 %_6, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  %_10 = bitcast { i16, i16 }* %self to i16*
  %_8 = call i16 @_ZN4core3mem7replace17h63417ac9e49e2041E(i16* align 2 dereferenceable(2) %_10, i16 %n)
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
define internal void @_ZN4tire16end_of_benchmark17hc49878f77d773b9aE(i16* noalias readonly align 2 dereferenceable(2) %urgent, i16* noalias readonly align 2 dereferenceable(2) %medium) unnamed_addr #0 {
start:
  call void @output_guard_start()
  br label %bb1

bb1:                                              ; preds = %start
  %_5 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [23 x i8] }>* @alloc5 to [0 x i8]*), i16 23)
  br label %bb2

bb2:                                              ; preds = %bb1
  %_10 = load i16, i16* %urgent, align 2
  %_9 = zext i16 %_10 to i32
  %_12 = load i16, i16* %medium, align 2
  %_11 = zext i16 %_12 to i32
  call void (i8*, ...) @printf(i8* %_5, i32 %_9, i32 %_11)
  br label %bb3

bb3:                                              ; preds = %bb2
  call void @output_guard_end()
  br label %bb4

bb4:                                              ; preds = %bb3
  ret void
}

; Function Attrs: nounwind
define internal void @_ZN4tire13acquireWindow17h334a29275df02eddE([3 x %threeAxis]* noalias nocapture sret dereferenceable(9) %window, i16* align 2 dereferenceable(2) %seed) unnamed_addr #0 {
start:
  %_27 = alloca %threeAxis, align 1
  %_24 = alloca i8, align 1
  %_21 = alloca i8, align 1
  %_18 = alloca i8, align 1
  %sample = alloca %threeAxis, align 1
  %_9 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_6 = alloca { i16, i16 }, align 2
  %_4 = alloca %threeAxis, align 1
  %_3 = alloca %threeAxis, align 1
  %_2 = alloca %threeAxis, align 1
  %0 = bitcast %threeAxis* %_2 to i8*
  store i8 0, i8* %0, align 1
  %1 = getelementptr inbounds %threeAxis, %threeAxis* %_2, i32 0, i32 3
  store i8 0, i8* %1, align 1
  %2 = getelementptr inbounds %threeAxis, %threeAxis* %_2, i32 0, i32 5
  store i8 0, i8* %2, align 1
  %3 = bitcast %threeAxis* %_3 to i8*
  store i8 0, i8* %3, align 1
  %4 = getelementptr inbounds %threeAxis, %threeAxis* %_3, i32 0, i32 3
  store i8 0, i8* %4, align 1
  %5 = getelementptr inbounds %threeAxis, %threeAxis* %_3, i32 0, i32 5
  store i8 0, i8* %5, align 1
  %6 = bitcast %threeAxis* %_4 to i8*
  store i8 0, i8* %6, align 1
  %7 = getelementptr inbounds %threeAxis, %threeAxis* %_4, i32 0, i32 3
  store i8 0, i8* %7, align 1
  %8 = getelementptr inbounds %threeAxis, %threeAxis* %_4, i32 0, i32 5
  store i8 0, i8* %8, align 1
  %9 = bitcast [3 x %threeAxis]* %window to %threeAxis*
  %10 = bitcast %threeAxis* %9 to i8*
  %11 = bitcast %threeAxis* %_2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %10, i8* align 1 %11, i16 3, i1 false)
  %12 = getelementptr inbounds [3 x %threeAxis], [3 x %threeAxis]* %window, i32 0, i32 1
  %13 = bitcast %threeAxis* %12 to i8*
  %14 = bitcast %threeAxis* %_3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %13, i8* align 1 %14, i16 3, i1 false)
  %15 = getelementptr inbounds [3 x %threeAxis], [3 x %threeAxis]* %window, i32 0, i32 2
  %16 = bitcast %threeAxis* %15 to i8*
  %17 = bitcast %threeAxis* %_4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %16, i8* align 1 %17, i16 3, i1 false)
  %18 = bitcast { i16, i16 }* %_6 to i16*
  store i16 0, i16* %18, align 2
  %19 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_6, i32 0, i32 1
  store i16 3, i16* %19, align 2
  %20 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_6, i32 0, i32 0
  %21 = load i16, i16* %20, align 2
  %22 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_6, i32 0, i32 1
  %23 = load i16, i16* %22, align 2
  %24 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h820c98c80fab166dE"(i16 %21, i16 %23)
  %_5.0 = extractvalue { i16, i16 } %24, 0
  %_5.1 = extractvalue { i16, i16 } %24, 1
  br label %bb1

bb1:                                              ; preds = %start
  %25 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_5.0, i16* %25, align 2
  %26 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_5.1, i16* %26, align 2
  br label %bb2

bb2:                                              ; preds = %bb20, %bb1
  %27 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %27, { i16, i16 }* %_9, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %28 = bitcast { i16, i16 }* %_9 to i16*
  %_12 = load i16, i16* %28, align 2, !range !0
  switch i16 %_12, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  ret void

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %29 = bitcast { i16, i16 }* %_9 to %"core::option::Option<u16>::Some"*
  %30 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %29, i32 0, i32 1
  %val = load i16, i16* %30, align 2
  call void @_ZN4tire11accelSample17hde04fb2025f58d7bE(%threeAxis* noalias nocapture sret dereferenceable(3) %sample, i16* noalias readonly align 2 dereferenceable(2) %seed)
  br label %bb7

bb7:                                              ; preds = %bb6
  %31 = bitcast %threeAxis* %sample to i8*
  %_20 = load i8, i8* %31, align 1
  %_19 = icmp ugt i8 %_20, 10
  br i1 %_19, label %bb9, label %bb8

bb8:                                              ; preds = %bb7
  store i8 0, i8* %_18, align 1
  br label %bb10

bb9:                                              ; preds = %bb7
  %32 = bitcast %threeAxis* %sample to i8*
  %33 = load i8, i8* %32, align 1
  store i8 %33, i8* %_18, align 1
  br label %bb10

bb10:                                             ; preds = %bb9, %bb8
  %34 = bitcast %threeAxis* %sample to i8*
  %35 = load i8, i8* %_18, align 1
  store i8 %35, i8* %34, align 1
  %36 = getelementptr inbounds %threeAxis, %threeAxis* %sample, i32 0, i32 3
  %_23 = load i8, i8* %36, align 1
  %_22 = icmp ugt i8 %_23, 10
  br i1 %_22, label %bb12, label %bb11

bb11:                                             ; preds = %bb10
  store i8 0, i8* %_21, align 1
  br label %bb13

bb12:                                             ; preds = %bb10
  %37 = getelementptr inbounds %threeAxis, %threeAxis* %sample, i32 0, i32 3
  %38 = load i8, i8* %37, align 1
  store i8 %38, i8* %_21, align 1
  br label %bb13

bb13:                                             ; preds = %bb12, %bb11
  %39 = getelementptr inbounds %threeAxis, %threeAxis* %sample, i32 0, i32 3
  %40 = load i8, i8* %_21, align 1
  store i8 %40, i8* %39, align 1
  %41 = getelementptr inbounds %threeAxis, %threeAxis* %sample, i32 0, i32 5
  %_26 = load i8, i8* %41, align 1
  %_25 = icmp ugt i8 %_26, 10
  br i1 %_25, label %bb15, label %bb14

bb14:                                             ; preds = %bb13
  store i8 0, i8* %_24, align 1
  br label %bb16

bb15:                                             ; preds = %bb13
  %42 = getelementptr inbounds %threeAxis, %threeAxis* %sample, i32 0, i32 5
  %43 = load i8, i8* %42, align 1
  store i8 %43, i8* %_24, align 1
  br label %bb16

bb16:                                             ; preds = %bb15, %bb14
  %44 = getelementptr inbounds %threeAxis, %threeAxis* %sample, i32 0, i32 5
  %45 = load i8, i8* %_24, align 1
  store i8 %45, i8* %44, align 1
  %46 = bitcast %threeAxis* %_27 to i8*
  %47 = bitcast %threeAxis* %sample to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %46, i8* align 1 %47, i16 3, i1 false)
  %_30 = icmp ult i16 %val, 3
  %48 = call i1 @llvm.expect.i1(i1 %_30, i1 true)
  br i1 %48, label %bb17, label %panic

bb17:                                             ; preds = %bb16
  %49 = getelementptr inbounds [3 x %threeAxis], [3 x %threeAxis]* %window, i16 0, i16 %val
  %50 = bitcast %threeAxis* %49 to i8*
  %51 = bitcast %threeAxis* %_27 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %50, i8* align 1 %51, i16 3, i1 false)
  %_33 = load i16, i16* %seed, align 2
  %_32 = urem i16 %_33, 5
  %_31 = icmp eq i16 %_32, 0
  br i1 %_31, label %bb19, label %bb18

bb18:                                             ; preds = %bb17
  br label %bb20

bb19:                                             ; preds = %bb17
  %52 = load i16, i16* %seed, align 2
  %53 = add i16 %52, 1
  store i16 %53, i16* %seed, align 2
  br label %bb20

bb20:                                             ; preds = %bb19, %bb18
  br label %bb2

panic:                                            ; preds = %bb16
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc62 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define internal zeroext i1 @_ZN4tire8isMoving17h75519792ea0be3a4E([3 x %threeAxis]* noalias readonly align 1 dereferenceable(9) %aWin) unnamed_addr #0 {
start:
  %_14 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_11 = alloca { i16, i16 }, align 2
  %likelyStopped = alloca i32, align 2
  %likelyMoving = alloca i32, align 2
  %z = alloca i8, align 1
  %y = alloca i8, align 1
  %x = alloca i8, align 1
  %0 = alloca i8, align 1
  %1 = getelementptr inbounds [3 x %threeAxis], [3 x %threeAxis]* %aWin, i16 0, i16 0
  %2 = bitcast %threeAxis* %1 to i8*
  %3 = load i8, i8* %2, align 1
  store i8 %3, i8* %x, align 1
  %4 = getelementptr inbounds [3 x %threeAxis], [3 x %threeAxis]* %aWin, i16 0, i16 0
  %5 = getelementptr inbounds %threeAxis, %threeAxis* %4, i32 0, i32 3
  %6 = load i8, i8* %5, align 1
  store i8 %6, i8* %y, align 1
  %7 = getelementptr inbounds [3 x %threeAxis], [3 x %threeAxis]* %aWin, i16 0, i16 0
  %8 = getelementptr inbounds %threeAxis, %threeAxis* %7, i32 0, i32 5
  %9 = load i8, i8* %8, align 1
  store i8 %9, i8* %z, align 1
  store i32 0, i32* %likelyMoving, align 2
  store i32 0, i32* %likelyStopped, align 2
  %10 = bitcast { i16, i16 }* %_11 to i16*
  store i16 1, i16* %10, align 2
  %11 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_11, i32 0, i32 1
  store i16 3, i16* %11, align 2
  %12 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_11, i32 0, i32 0
  %13 = load i16, i16* %12, align 2
  %14 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_11, i32 0, i32 1
  %15 = load i16, i16* %14, align 2
  %16 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h820c98c80fab166dE"(i16 %13, i16 %15)
  %_10.0 = extractvalue { i16, i16 } %16, 0
  %_10.1 = extractvalue { i16, i16 } %16, 1
  br label %bb1

bb1:                                              ; preds = %start
  %17 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_10.0, i16* %17, align 2
  %18 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_10.1, i16* %18, align 2
  br label %bb2

bb2:                                              ; preds = %bb21, %bb1
  %19 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %19, { i16, i16 }* %_14, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %20 = bitcast { i16, i16 }* %_14 to i16*
  %_17 = load i16, i16* %20, align 2, !range !0
  switch i16 %_17, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  %_55 = load i32, i32* %likelyMoving, align 2
  %_56 = load i32, i32* %likelyStopped, align 2
  %_54 = icmp sgt i32 %_55, %_56
  br i1 %_54, label %bb23, label %bb22

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %21 = bitcast { i16, i16 }* %_14 to %"core::option::Option<u16>::Some"*
  %22 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %21, i32 0, i32 1
  %val = load i16, i16* %22, align 2
  %_22 = load i8, i8* %x, align 1
  %_27 = icmp ult i16 %val, 3
  %23 = call i1 @llvm.expect.i1(i1 %_27, i1 true)
  br i1 %23, label %bb7, label %panic

bb7:                                              ; preds = %bb6
  %24 = getelementptr inbounds [3 x %threeAxis], [3 x %threeAxis]* %aWin, i16 0, i16 %val
  %25 = bitcast %threeAxis* %24 to i8*
  %_24 = load i8, i8* %25, align 1
  %_23 = add i8 %_24, 10
  %_21 = icmp ule i8 %_22, %_23
  br i1 %_21, label %bb9, label %bb8

bb8:                                              ; preds = %bb7
  %26 = load i32, i32* %likelyMoving, align 2
  %27 = add i32 %26, 1
  store i32 %27, i32* %likelyMoving, align 2
  br label %bb10

bb9:                                              ; preds = %bb7
  %28 = load i32, i32* %likelyStopped, align 2
  %29 = add i32 %28, 1
  store i32 %29, i32* %likelyStopped, align 2
  br label %bb10

bb10:                                             ; preds = %bb9, %bb8
  %_31 = icmp ult i16 %val, 3
  %30 = call i1 @llvm.expect.i1(i1 %_31, i1 true)
  br i1 %30, label %bb11, label %panic1

bb11:                                             ; preds = %bb10
  %31 = getelementptr inbounds [3 x %threeAxis], [3 x %threeAxis]* %aWin, i16 0, i16 %val
  %32 = bitcast %threeAxis* %31 to i8*
  %_28 = load i8, i8* %32, align 1
  store i8 %_28, i8* %x, align 1
  %_33 = load i8, i8* %y, align 1
  %_38 = icmp ult i16 %val, 3
  %33 = call i1 @llvm.expect.i1(i1 %_38, i1 true)
  br i1 %33, label %bb12, label %panic2

bb12:                                             ; preds = %bb11
  %34 = getelementptr inbounds [3 x %threeAxis], [3 x %threeAxis]* %aWin, i16 0, i16 %val
  %35 = getelementptr inbounds %threeAxis, %threeAxis* %34, i32 0, i32 3
  %_35 = load i8, i8* %35, align 1
  %_34 = add i8 %_35, 10
  %_32 = icmp ule i8 %_33, %_34
  br i1 %_32, label %bb14, label %bb13

bb13:                                             ; preds = %bb12
  %36 = load i32, i32* %likelyMoving, align 2
  %37 = add i32 %36, 1
  store i32 %37, i32* %likelyMoving, align 2
  br label %bb15

bb14:                                             ; preds = %bb12
  %38 = load i32, i32* %likelyStopped, align 2
  %39 = add i32 %38, 1
  store i32 %39, i32* %likelyStopped, align 2
  br label %bb15

bb15:                                             ; preds = %bb14, %bb13
  %_42 = icmp ult i16 %val, 3
  %40 = call i1 @llvm.expect.i1(i1 %_42, i1 true)
  br i1 %40, label %bb16, label %panic3

bb16:                                             ; preds = %bb15
  %41 = getelementptr inbounds [3 x %threeAxis], [3 x %threeAxis]* %aWin, i16 0, i16 %val
  %42 = getelementptr inbounds %threeAxis, %threeAxis* %41, i32 0, i32 3
  %_39 = load i8, i8* %42, align 1
  store i8 %_39, i8* %y, align 1
  %_44 = load i8, i8* %z, align 1
  %_49 = icmp ult i16 %val, 3
  %43 = call i1 @llvm.expect.i1(i1 %_49, i1 true)
  br i1 %43, label %bb17, label %panic4

bb17:                                             ; preds = %bb16
  %44 = getelementptr inbounds [3 x %threeAxis], [3 x %threeAxis]* %aWin, i16 0, i16 %val
  %45 = getelementptr inbounds %threeAxis, %threeAxis* %44, i32 0, i32 5
  %_46 = load i8, i8* %45, align 1
  %_45 = add i8 %_46, 10
  %_43 = icmp ule i8 %_44, %_45
  br i1 %_43, label %bb19, label %bb18

bb18:                                             ; preds = %bb17
  %46 = load i32, i32* %likelyMoving, align 2
  %47 = add i32 %46, 1
  store i32 %47, i32* %likelyMoving, align 2
  br label %bb20

bb19:                                             ; preds = %bb17
  %48 = load i32, i32* %likelyStopped, align 2
  %49 = add i32 %48, 1
  store i32 %49, i32* %likelyStopped, align 2
  br label %bb20

bb20:                                             ; preds = %bb19, %bb18
  %_53 = icmp ult i16 %val, 3
  %50 = call i1 @llvm.expect.i1(i1 %_53, i1 true)
  br i1 %50, label %bb21, label %panic5

bb21:                                             ; preds = %bb20
  %51 = getelementptr inbounds [3 x %threeAxis], [3 x %threeAxis]* %aWin, i16 0, i16 %val
  %52 = getelementptr inbounds %threeAxis, %threeAxis* %51, i32 0, i32 5
  %_50 = load i8, i8* %52, align 1
  store i8 %_50, i8* %z, align 1
  br label %bb2

bb22:                                             ; preds = %bb4
  store i8 0, i8* %0, align 1
  br label %bb24

bb23:                                             ; preds = %bb4
  store i8 1, i8* %0, align 1
  br label %bb24

bb24:                                             ; preds = %bb23, %bb22
  %53 = load i8, i8* %0, align 1, !range !1
  %54 = trunc i8 %53 to i1
  ret i1 %54

panic:                                            ; preds = %bb6
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc64 to %"core::panic::Location"*))
  unreachable

panic1:                                           ; preds = %bb10
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc66 to %"core::panic::Location"*))
  unreachable

panic2:                                           ; preds = %bb11
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc68 to %"core::panic::Location"*))
  unreachable

panic3:                                           ; preds = %bb15
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc70 to %"core::panic::Location"*))
  unreachable

panic4:                                           ; preds = %bb16
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc72 to %"core::panic::Location"*))
  unreachable

panic5:                                           ; preds = %bb20
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc74 to %"core::panic::Location"*))
  unreachable
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

declare void @log_entry(i8*, i8*, i16)

; Function Attrs: nounwind
define internal i16 @_ZN4tire16relativePressure17h00e38ad946681b37E(i16* noalias readonly align 2 dereferenceable(2) %seed) unnamed_addr #0 {
start:
  %_3 = call i16 @"_ZN60_$LT$$RF$u16$u20$as$u20$core..ops..arith..Mul$LT$u16$GT$$GT$3mul17h8a962d6e2626e67eE"(i16* noalias readonly align 2 dereferenceable(2) %seed, i16 17)
  br label %bb1

bb1:                                              ; preds = %start
  %_5 = call i16 @"_ZN60_$LT$$RF$u16$u20$as$u20$core..ops..arith..Rem$LT$u16$GT$$GT$3rem17h043089b42e291cbfE"(i16* noalias readonly align 2 dereferenceable(2) %seed, i16 17)
  br label %bb2

bb2:                                              ; preds = %bb1
  %_2 = sub i16 %_3, %_5
  %sample = call i16 @readPressure(i16 %_2)
  br label %bb3

bb3:                                              ; preds = %bb2
  ret i16 %sample
}

; Function Attrs: nounwind
define internal i16 @_ZN4tire12coldPressure17h8892e3580fb87861E(i16 %input, i16* align 2 dereferenceable(2) %seed) unnamed_addr #0 {
start:
  %tempTire = call i16 @readTemp(i16 1, i16* noalias readonly align 2 dereferenceable(2) %seed)
  br label %bb1

bb1:                                              ; preds = %start
  %tempAmbient = call i16 @readTemp(i16 2, i16* noalias readonly align 2 dereferenceable(2) %seed)
  br label %bb2

bb2:                                              ; preds = %bb1
  %0 = load i16, i16* %seed, align 2
  %1 = add i16 %0, 1
  store i16 %1, i16* %seed, align 2
  %_9 = sub i16 %tempTire, %tempAmbient
  %_8 = udiv i16 %_9, 10
  %result = sub i16 %input, %_8
  ret i16 %result
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
define internal void @_ZN4tire16updateHistorical17hb1ff916b822a9be9E(%History* align 2 dereferenceable(16) %data, i16 %newReading) unnamed_addr #0 {
start:
  %_15 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_12 = alloca { i16, i16 }, align 2
  %_4 = alloca i16, align 2
  %mean = alloca i16, align 2
  store i16 0, i16* %mean, align 2
  %0 = getelementptr inbounds %History, %History* %data, i32 0, i32 5
  %_6 = load i16, i16* %0, align 2
  %_5 = icmp ugt i16 %_6, %newReading
  br i1 %_5, label %bb2, label %bb1

bb1:                                              ; preds = %start
  store i16 0, i16* %_4, align 2
  br label %bb3

bb2:                                              ; preds = %start
  %1 = getelementptr inbounds %History, %History* %data, i32 0, i32 5
  %_8 = load i16, i16* %1, align 2
  %2 = sub i16 %_8, %newReading
  store i16 %2, i16* %_4, align 2
  br label %bb3

bb3:                                              ; preds = %bb2, %bb1
  %3 = getelementptr inbounds %History, %History* %data, i32 0, i32 7
  %4 = load i16, i16* %_4, align 2
  store i16 %4, i16* %3, align 2
  %5 = getelementptr inbounds %History, %History* %data, i32 0, i32 5
  store i16 %newReading, i16* %5, align 2
  %6 = bitcast { i16, i16 }* %_12 to i16*
  store i16 1, i16* %6, align 2
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_12, i32 0, i32 1
  store i16 5, i16* %7, align 2
  %8 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_12, i32 0, i32 0
  %9 = load i16, i16* %8, align 2
  %10 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_12, i32 0, i32 1
  %11 = load i16, i16* %10, align 2
  %12 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h820c98c80fab166dE"(i16 %9, i16 %11)
  %_11.0 = extractvalue { i16, i16 } %12, 0
  %_11.1 = extractvalue { i16, i16 } %12, 1
  br label %bb4

bb4:                                              ; preds = %bb3
  %13 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_11.0, i16* %13, align 2
  %14 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_11.1, i16* %14, align 2
  br label %bb5

bb5:                                              ; preds = %bb12, %bb4
  %15 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %15, { i16, i16 }* %_15, align 2
  br label %bb6

bb6:                                              ; preds = %bb5
  %16 = bitcast { i16, i16 }* %_15 to i16*
  %_18 = load i16, i16* %16, align 2, !range !0
  switch i16 %_18, label %bb8 [
    i16 0, label %bb7
    i16 1, label %bb9
  ]

bb7:                                              ; preds = %bb6
  %17 = getelementptr inbounds %History, %History* %data, i32 0, i32 3
  %18 = getelementptr inbounds [5 x i16], [5 x i16]* %17, i16 0, i16 0
  store i16 %newReading, i16* %18, align 2
  %19 = load i16, i16* %mean, align 2
  %20 = add i16 %19, %newReading
  store i16 %20, i16* %mean, align 2
  %21 = load i16, i16* %mean, align 2
  %22 = udiv i16 %21, 5
  store i16 %22, i16* %mean, align 2
  %_39 = load i16, i16* %mean, align 2
  %23 = bitcast %History* %data to i16*
  store i16 %_39, i16* %23, align 2
  ret void

bb8:                                              ; preds = %bb6
  unreachable

bb9:                                              ; preds = %bb6
  %24 = bitcast { i16, i16 }* %_15 to %"core::option::Option<u16>::Some"*
  %25 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %24, i32 0, i32 1
  %val = load i16, i16* %25, align 2
  %_23 = sub i16 %val, 1
  %_26 = icmp ult i16 %_23, 5
  %26 = call i1 @llvm.expect.i1(i1 %_26, i1 true)
  br i1 %26, label %bb10, label %panic

bb10:                                             ; preds = %bb9
  %27 = getelementptr inbounds %History, %History* %data, i32 0, i32 3
  %28 = getelementptr inbounds [5 x i16], [5 x i16]* %27, i16 0, i16 %_23
  %_22 = load i16, i16* %28, align 2
  %_29 = icmp ult i16 %val, 5
  %29 = call i1 @llvm.expect.i1(i1 %_29, i1 true)
  br i1 %29, label %bb11, label %panic1

bb11:                                             ; preds = %bb10
  %30 = getelementptr inbounds %History, %History* %data, i32 0, i32 3
  %31 = getelementptr inbounds [5 x i16], [5 x i16]* %30, i16 0, i16 %val
  store i16 %_22, i16* %31, align 2
  %_31 = sub i16 %val, 1
  %_34 = icmp ult i16 %_31, 5
  %32 = call i1 @llvm.expect.i1(i1 %_34, i1 true)
  br i1 %32, label %bb12, label %panic2

bb12:                                             ; preds = %bb11
  %33 = getelementptr inbounds %History, %History* %data, i32 0, i32 3
  %34 = getelementptr inbounds [5 x i16], [5 x i16]* %33, i16 0, i16 %_31
  %_30 = load i16, i16* %34, align 2
  %35 = load i16, i16* %mean, align 2
  %36 = add i16 %35, %_30
  store i16 %36, i16* %mean, align 2
  br label %bb5

panic:                                            ; preds = %bb9
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %_23, i16 5, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc76 to %"core::panic::Location"*))
  unreachable

panic1:                                           ; preds = %bb10
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 5, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc78 to %"core::panic::Location"*))
  unreachable

panic2:                                           ; preds = %bb11
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %_31, i16 5, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc80 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define internal void @_ZN4tire8sendData17hf159beeb0d41b37dE([0 x i8]* noalias nonnull readonly align 1 %data.0, i16 %data.1) unnamed_addr #0 {
start:
  %_2.i = alloca %"core::str::{{impl}}::as_bytes::Slices", align 2
  call void @output_guard_start()
  br label %bb1

bb1:                                              ; preds = %start
  %0 = bitcast %"core::str::{{impl}}::as_bytes::Slices"* %_2.i to { [0 x i8]*, i16 }*
  %1 = getelementptr inbounds { [0 x i8]*, i16 }, { [0 x i8]*, i16 }* %0, i32 0, i32 0
  store [0 x i8]* %data.0, [0 x i8]** %1, align 2, !noalias !2
  %2 = getelementptr inbounds { [0 x i8]*, i16 }, { [0 x i8]*, i16 }* %0, i32 0, i32 1
  store i16 %data.1, i16* %2, align 2, !noalias !2
  %3 = bitcast %"core::str::{{impl}}::as_bytes::Slices"* %_2.i to { [0 x i8]*, i16 }*
  %4 = getelementptr inbounds { [0 x i8]*, i16 }, { [0 x i8]*, i16 }* %3, i32 0, i32 0
  %5 = load [0 x i8]*, [0 x i8]** %4, align 2, !noalias !2, !nonnull !5
  %6 = getelementptr inbounds { [0 x i8]*, i16 }, { [0 x i8]*, i16 }* %3, i32 0, i32 1
  %7 = load i16, i16* %6, align 2, !noalias !2
  %8 = insertvalue { [0 x i8]*, i16 } undef, [0 x i8]* %5, 0
  %9 = insertvalue { [0 x i8]*, i16 } %8, i16 %7, 1
  %_6.0 = extractvalue { [0 x i8]*, i16 } %9, 0
  %_6.1 = extractvalue { [0 x i8]*, i16 } %9, 1
  br label %bb2

bb2:                                              ; preds = %bb1
  %_4 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 %_6.0, i16 %_6.1)
  br label %bb3

bb3:                                              ; preds = %bb2
  call void (i8*, ...) @printf(i8* %_4)
  br label %bb4

bb4:                                              ; preds = %bb3
  call void @output_guard_end()
  br label %bb5

bb5:                                              ; preds = %bb4
  ret void
}

; Function Attrs: nounwind
declare void @gpioTwiddle() unnamed_addr #0

; Function Attrs: nounwind
define void @output_guard_start() unnamed_addr #0 {
start:
  call void @start_atomic()
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: nounwind
declare void @printf(i8*, ...) unnamed_addr #0

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
declare void @start_atomic() unnamed_addr #0

; Function Attrs: nounwind readnone
declare i1 @llvm.expect.i1(i1, i1) #2

; Function Attrs: nounwind
define i16 @readTemp(i16 %sensor, i16* noalias readonly align 2 dereferenceable(2) %input) unnamed_addr #0 {
start:
  %0 = alloca i16, align 2
  %1 = icmp eq i16 %sensor, 1
  br i1 %1, label %bb2, label %bb1

bb1:                                              ; preds = %start
  %_10 = load i16, i16* %input, align 2
  %_9 = urem i16 %_10, 68
  %2 = add i16 32, %_9
  store i16 %2, i16* %0, align 2
  br label %bb3

bb2:                                              ; preds = %start
  %_6 = load i16, i16* %input, align 2
  %_5 = urem i16 %_6, 68
  %_4 = add i16 32, %_5
  %_8 = load i16, i16* %input, align 2
  %_7 = urem i16 %_8, 200
  %_3 = add i16 %_4, %_7
  %3 = urem i16 %_3, 255
  store i16 %3, i16* %0, align 2
  br label %bb3

bb3:                                              ; preds = %bb2, %bb1
  %4 = load i16, i16* %0, align 2
  ret i16 %4
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN60_$LT$$RF$u16$u20$as$u20$core..ops..arith..Mul$LT$u16$GT$$GT$3mul17h8a962d6e2626e67eE"(i16* noalias readonly align 2 dereferenceable(2) %self, i16 %other) unnamed_addr #1 {
start:
  %_3 = load i16, i16* %self, align 2
  %0 = call i16 @"_ZN45_$LT$u16$u20$as$u20$core..ops..arith..Mul$GT$3mul17h704aa962a82deadeE"(i16 %_3, i16 %other)
  br label %bb1

bb1:                                              ; preds = %start
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN60_$LT$$RF$u16$u20$as$u20$core..ops..arith..Rem$LT$u16$GT$$GT$3rem17h043089b42e291cbfE"(i16* noalias readonly align 2 dereferenceable(2) %self, i16 %other) unnamed_addr #1 {
start:
  %_3 = load i16, i16* %self, align 2
  %0 = call i16 @"_ZN45_$LT$u16$u20$as$u20$core..ops..arith..Rem$GT$3rem17h3833338bd78d64d3E"(i16 %_3, i16 %other)
  br label %bb1

bb1:                                              ; preds = %start
  ret i16 %0
}

; Function Attrs: nounwind
define i16 @readPressure(i16 %input) unnamed_addr #0 {
start:
  %res = alloca i16, align 2
  %_3 = urem i16 %input, 450
  %_2 = icmp ugt i16 %_3, 101
  br i1 %_2, label %bb2, label %bb1

bb1:                                              ; preds = %start
  %_6 = urem i16 %input, 450
  %0 = add i16 %_6, 101
  store i16 %0, i16* %res, align 2
  br label %bb3

bb2:                                              ; preds = %start
  %1 = urem i16 %input, 450
  store i16 %1, i16* %res, align 2
  br label %bb3

bb3:                                              ; preds = %bb2, %bb1
  %2 = load i16, i16* %res, align 2
  ret i16 %2
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN45_$LT$u16$u20$as$u20$core..ops..arith..Rem$GT$3rem17h3833338bd78d64d3E"(i16 %self, i16 %other) unnamed_addr #1 {
start:
  %_5 = icmp eq i16 %other, 0
  %0 = call i1 @llvm.expect.i1(i1 %_5, i1 false)
  br i1 %0, label %panic, label %bb1

bb1:                                              ; preds = %start
  %1 = urem i16 %self, %other
  ret i16 %1

panic:                                            ; preds = %start
  call void @_ZN4core9panicking5panic17h33d11d8bc643763fE([0 x i8]* noalias nonnull readonly align 1 bitcast ([57 x i8]* @str.0 to [0 x i8]*), i16 57, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc60 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN45_$LT$u16$u20$as$u20$core..ops..arith..Mul$GT$3mul17h704aa962a82deadeE"(i16 %self, i16 %other) unnamed_addr #1 {
start:
  %_5.0 = mul i16 %self, %other
  br label %bb1

bb1:                                              ; preds = %start
  ret i16 %_5.0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i16(i8* nocapture writeonly, i8* nocapture readonly, i16, i1 immarg) #3

; Function Attrs: nounwind
define internal void @_ZN4tire11accelSample17hde04fb2025f58d7bE(%threeAxis* noalias nocapture sret dereferenceable(3) %result, i16* noalias readonly align 2 dereferenceable(2) %seed) unnamed_addr #0 {
start:
  %_3 = call i16 @"_ZN60_$LT$$RF$u16$u20$as$u20$core..ops..arith..Mul$LT$u16$GT$$GT$3mul17h8a962d6e2626e67eE"(i16* noalias readonly align 2 dereferenceable(2) %seed, i16 8)
  br label %bb1

bb1:                                              ; preds = %start
  call void @atomic_start()
  %xs = call i8 @readAccel(i16 %_3)
  br label %bb2

bb2:                                              ; preds = %bb1
  br label %bb3

bb3:                                              ; preds = %bb2
  %_9 = call i16 @"_ZN60_$LT$$RF$u16$u20$as$u20$core..ops..arith..Mul$LT$u16$GT$$GT$3mul17h8a962d6e2626e67eE"(i16* noalias readonly align 2 dereferenceable(2) %seed, i16 8)
  br label %bb4

bb4:                                              ; preds = %bb3
  %_8 = mul i16 %_9, 8
  %ys = call i8 @readAccel(i16 %_8)
  br label %bb5

bb5:                                              ; preds = %bb4
  br label %bb6

bb6:                                              ; preds = %bb5
  %_16 = call i16 @"_ZN60_$LT$$RF$u16$u20$as$u20$core..ops..arith..Mul$LT$u16$GT$$GT$3mul17h8a962d6e2626e67eE"(i16* noalias readonly align 2 dereferenceable(2) %seed, i16 8)
  br label %bb7

bb7:                                              ; preds = %bb6
  %_15 = mul i16 %_16, 8
  %_14 = mul i16 %_15, 8
  %zs = call i8 @readAccel(i16 %_14)
  call void @atomic_end()
  br label %bb8

bb8:                                              ; preds = %bb7
  br label %bb9

bb9:                                              ; preds = %bb8
  %0 = bitcast %threeAxis* %result to i8*
  store i8 %xs, i8* %0, align 1
  %1 = getelementptr inbounds %threeAxis, %threeAxis* %result, i32 0, i32 3
  store i8 %ys, i8* %1, align 1
  %2 = getelementptr inbounds %threeAxis, %threeAxis* %result, i32 0, i32 5
  store i8 %zs, i8* %2, align 1
  ret void
}

; Function Attrs: nounwind
define i8 @readAccel(i16 %input) unnamed_addr #0 {
start:
  %_2 = urem i16 %input, 85
  %0 = trunc i16 %_2 to i8
  ret i8 %0
}

; Function Attrs: inlinehint nounwind
define internal zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$u16$GT$2lt17haf273cef1841016cE"(i16* noalias readonly align 2 dereferenceable(2) %self, i16* noalias readonly align 2 dereferenceable(2) %other) unnamed_addr #1 {
start:
  %_3 = load i16, i16* %self, align 2
  %_4 = load i16, i16* %other, align 2
  %0 = icmp ult i16 %_3, %_4
  ret i1 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$u16$GT$5clone17h0e60b2fd5874ec2bE"(i16* noalias readonly align 2 dereferenceable(2) %self) unnamed_addr #1 {
start:
  %0 = load i16, i16* %self, align 2
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN47_$LT$u16$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h9df8c8309313fc3cE"(i16 %start1, i16 %n) unnamed_addr #1 {
start:
  %0 = call i16 @"_ZN4core3num21_$LT$impl$u20$u16$GT$13unchecked_add17h189bfa753deda635E"(i16 %start1, i16 %n)
  br label %bb1

bb1:                                              ; preds = %start
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @_ZN4core3mem7replace17h63417ac9e49e2041E(i16* align 2 dereferenceable(2) %dest, i16) unnamed_addr #1 {
start:
  %src = alloca i16, align 2
  store i16 %0, i16* %src, align 2
  call void @_ZN4core3mem4swap17hecf3cc529c91817bE(i16* align 2 dereferenceable(2) %dest, i16* align 2 dereferenceable(2) %src)
  br label %bb1

bb1:                                              ; preds = %start
  %1 = load i16, i16* %src, align 2
  ret i16 %1
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3mem4swap17hecf3cc529c91817bE(i16* align 2 dereferenceable(2) %x, i16* align 2 dereferenceable(2) %y) unnamed_addr #1 {
start:
  call void @_ZN4core3ptr23swap_nonoverlapping_one17h48643592cea179dfE(i16* %x, i16* %y)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr23swap_nonoverlapping_one17h48643592cea179dfE(i16* %x, i16* %y) unnamed_addr #1 {
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
  call void @_ZN4core3ptr19swap_nonoverlapping17hf125ad77ce6569e2E(i16* %x, i16* %y, i16 1)
  br label %bb7

bb3:                                              ; preds = %bb1
  %z = call i16 @_ZN4core3ptr4read17ha9023473503be671E(i16* %x)
  br label %bb4

bb4:                                              ; preds = %bb3
  call void @_ZN4core10intrinsics19copy_nonoverlapping17h6fcd82407f831a73E(i16* %y, i16* %x, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  call void @_ZN4core3ptr5write17h77b017fd5dee146bE(i16* %y, i16 %z)
  br label %bb6

bb6:                                              ; preds = %bb5
  br label %bb8

bb7:                                              ; preds = %bb2
  br label %bb8

bb8:                                              ; preds = %bb7, %bb6
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr19swap_nonoverlapping17hf125ad77ce6569e2E(i16* %x, i16* %y, i16 %count) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %x1 = bitcast i16* %x to i8*
  %y2 = bitcast i16* %y to i8*
  store i16 2, i16* %0, align 2
  %1 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %len = mul i16 %1, %count
  call void @_ZN4core3ptr25swap_nonoverlapping_bytes17h49364869107a3417E(i8* %x1, i8* %y2, i16 %len)
  br label %bb2

bb2:                                              ; preds = %bb1
  ret void
}

; Function Attrs: inlinehint nounwind
define internal i16 @_ZN4core3ptr4read17ha9023473503be671E(i16* %src) unnamed_addr #1 {
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
  call void @_ZN4core10intrinsics19copy_nonoverlapping17h6fcd82407f831a73E(i16* %src, i16* %tmp, i16 1)
  br label %bb3

bb3:                                              ; preds = %bb2
  %_7 = load i16, i16* %tmp, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  ret i16 %_7
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core10intrinsics19copy_nonoverlapping17h6fcd82407f831a73E(i16* %src, i16* %dst, i16 %count) unnamed_addr #1 {
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
define internal void @_ZN4core3ptr5write17h77b017fd5dee146bE(i16* %dst, i16 %src) unnamed_addr #1 {
start:
  %0 = alloca {}, align 1
  store i16 %src, i16* %dst, align 2
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr25swap_nonoverlapping_bytes17h49364869107a3417E(i8* %x, i8* %y, i16 %len) unnamed_addr #1 {
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
define internal i16 @"_ZN4core3num21_$LT$impl$u20$u16$GT$13unchecked_add17h189bfa753deda635E"(i16 %self, i16 %rhs) unnamed_addr #1 {
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
define void @_ZN4core9panicking5panic17h33d11d8bc643763fE([0 x i8]* noalias nonnull readonly align 1 %expr.0, i16 %expr.1, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12)) unnamed_addr #4 {
start:
  %_6 = alloca [1 x { [0 x i8]*, i16 }], align 2
  %_2 = alloca %"fmt::Arguments", align 2
  %1 = bitcast [1 x { [0 x i8]*, i16 }]* %_6 to { [0 x i8]*, i16 }*
  %2 = getelementptr inbounds { [0 x i8]*, i16 }, { [0 x i8]*, i16 }* %1, i32 0, i32 0
  store [0 x i8]* %expr.0, [0 x i8]** %2, align 2
  %3 = getelementptr inbounds { [0 x i8]*, i16 }, { [0 x i8]*, i16 }* %1, i32 0, i32 1
  store i16 %expr.1, i16* %3, align 2
  %_3.0 = bitcast [1 x { [0 x i8]*, i16 }]* %_6 to [0 x { [0 x i8]*, i16 }]*
  %_11 = load [0 x { i8*, i8* }]*, [0 x { i8*, i8* }]** bitcast (<{ i8*, [0 x i8] }>* @anon.b7bafff2f871b915b57b152a19c6233b.10 to [0 x { i8*, i8* }]**), align 2, !nonnull !5
  call void @_ZN4core3fmt9Arguments6new_v117hcb862d1c1c522ce9E(%"fmt::Arguments"* noalias nocapture sret dereferenceable(12) %_2, [0 x { [0 x i8]*, i16 }]* noalias nonnull readonly align 2 %_3.0, i16 1, [0 x { i8*, i8* }]* noalias nonnull readonly align 2 %_11, i16 0)
  br label %bb1

bb1:                                              ; preds = %start
  call void @_ZN4core9panicking9panic_fmt17hd5daa03e51f33d00E(%"fmt::Arguments"* noalias nocapture dereferenceable(12) %_2, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) %0)
  unreachable
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
  %_22 = load [2 x { [0 x i8]*, i16 }]*, [2 x { [0 x i8]*, i16 }]** bitcast (<{ i8*, [0 x i8] }>* @anon.b7bafff2f871b915b57b152a19c6233b.18 to [2 x { [0 x i8]*, i16 }]**), align 2, !nonnull !5
  %_4.0 = bitcast [2 x { [0 x i8]*, i16 }]* %_22 to [0 x { [0 x i8]*, i16 }]*
  %3 = bitcast { i16*, i16* }* %_11 to i16**
  store i16* %len, i16** %3, align 2
  %4 = getelementptr inbounds { i16*, i16* }, { i16*, i16* }* %_11, i32 0, i32 1
  store i16* %index, i16** %4, align 2
  %5 = bitcast { i16*, i16* }* %_11 to i16**
  %arg0 = load i16*, i16** %5, align 2, !nonnull !5
  %6 = getelementptr inbounds { i16*, i16* }, { i16*, i16* }* %_11, i32 0, i32 1
  %arg1 = load i16*, i16** %6, align 2, !nonnull !5
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
  %_3 = load i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)*, i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)** %1, align 2, !nonnull !5
  br label %bb1

bb1:                                              ; preds = %start
  %4 = bitcast %"fmt::USIZE_MARKER::{{closure}}"** %0 to i16**
  store i16* %x, i16** %4, align 2
  %_5 = load %"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::USIZE_MARKER::{{closure}}"** %0, align 2, !nonnull !5
  br label %bb2

bb2:                                              ; preds = %bb1
  %5 = bitcast { i8*, i8* }* %2 to %"fmt::USIZE_MARKER::{{closure}}"**
  store %"fmt::USIZE_MARKER::{{closure}}"* %_5, %"fmt::USIZE_MARKER::{{closure}}"** %5, align 2
  %6 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 1
  %7 = bitcast i8** %6 to i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)**
  store i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)* %_3, i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)** %7, align 2
  %8 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 0
  %9 = load i8*, i8** %8, align 2, !nonnull !5
  %10 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 1
  %11 = load i8*, i8** %10, align 2, !nonnull !5
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
  %2 = load %"core::panic::Location"*, %"core::panic::Location"** %1, align 2, !nonnull !5
  br label %bb1

bb1:                                              ; preds = %start
  ret %"core::panic::Location"* %2
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core5panic9PanicInfo20internal_constructor17h3f579eac134a0316E(%"panic::PanicInfo"* noalias nocapture sret dereferenceable(8), i16* noalias readonly align 2 dereferenceable_or_null(12) %message, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) %location) unnamed_addr #1 {
start:
  %_8 = load %"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::USIZE_MARKER::{{closure}}"** bitcast (<{ i8*, [0 x i8] }>* @anon.b7bafff2f871b915b57b152a19c6233b.10 to %"fmt::USIZE_MARKER::{{closure}}"**), align 2, !nonnull !5
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
declare void @llvm.memset.p0i8.i16(i8* nocapture writeonly, i8, i16, i1 immarg) #3

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
  call void asm sideeffect "dint { nop", "~{memory}"() #5, !srcloc !6
  br label %bb1

bb1:                                              ; preds = %start
  br label %bb2

bb2:                                              ; preds = %bb3, %bb1
  call void asm sideeffect "", "~{memory}"() #5, !srcloc !7
  br label %bb3

bb3:                                              ; preds = %bb2
  br label %bb2
}

attributes #0 = { nounwind "target-cpu"="generic" }
attributes #1 = { inlinehint nounwind "target-cpu"="generic" }
attributes #2 = { nounwind readnone }
attributes #3 = { argmemonly nounwind }
attributes #4 = { cold noinline noreturn nounwind "target-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { nounwind readnone speculatable }
attributes #7 = { cold noreturn nounwind }
attributes #8 = { noreturn nounwind "target-cpu"="generic" }

!0 = !{i16 0, i16 2}
!1 = !{i8 0, i8 2}
!2 = !{!3}
!3 = distinct !{!3, !4, !"_ZN4core3str21_$LT$impl$u20$str$GT$8as_bytes17h4e9549b20dea6d54E: %self.0"}
!4 = distinct !{!4, !"_ZN4core3str21_$LT$impl$u20$str$GT$8as_bytes17h4e9549b20dea6d54E"}
!5 = !{}
!6 = !{i32 2974937}
!7 = !{i32 2974670}
