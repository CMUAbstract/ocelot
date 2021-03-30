; ModuleID = 'activity_post.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:16:16-i32:16-i64:16-f32:16-f64:16-a:8-n8:16-S16"
target triple = "msp430-none-unknown-elf"

%"fmt::USIZE_MARKER::{{closure}}" = type {}
%model_t = type { [0 x i16], [16 x { i16, i16 }], [0 x i16], [16 x { i16, i16 }], [0 x i16] }
%threeAxis_t_8 = type { [0 x i8], i8, [0 x i8], i8, [0 x i8], i8, [0 x i8] }
%"core::option::Option<u16>::Some" = type { [1 x i16], i16, [0 x i16] }
%"core::panic::Location" = type { [0 x i16], { [0 x i8]*, i16 }, [0 x i16], i32, [0 x i16], i32, [0 x i16] }
%stats_t = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16] }
%"core::mem::maybe_uninit::MaybeUninit<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>" = type { [16 x i16] }
%"core::mem::manually_drop::ManuallyDrop<core::ptr::swap_nonoverlapping_bytes::UnalignedBlock>" = type { [0 x i16], %"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock", [0 x i16] }
%"core::ptr::swap_nonoverlapping_bytes::UnalignedBlock" = type { [0 x i16], i64, [0 x i16], i64, [0 x i16], i64, [0 x i16], i64, [0 x i16] }
%"fmt::Arguments" = type { [0 x i16], { [0 x { [0 x i8]*, i16 }]*, i16 }, [0 x i16], { i16*, i16 }, [0 x i16], { [0 x { i8*, i8* }]*, i16 }, [0 x i16] }
%"fmt::Formatter" = type { [0 x i16], i32, [0 x i16], i32, [0 x i16], { i16, i16 }, [0 x i16], { i16, i16 }, [0 x i16], { {}*, [3 x i16]* }, [0 x i8], i8, [1 x i8] }
%"panic::PanicInfo" = type { [0 x i16], { {}*, [3 x i16]* }, [0 x i16], i16*, [0 x i16], %"core::panic::Location"*, [0 x i16] }

@num_dirty_gv = common externally_initialized global i16 0
@_numBoots = common externally_initialized global i16 0
@data_src = global [0 x i8*] zeroinitializer, section ".nv_vars", align 2
@data_dest = global [0 x i8*] zeroinitializer, section ".nv_vars", align 2
@data_size = global [0 x i16] zeroinitializer, section ".nv_vars", align 2
@_ZN8activity3app8MODEL_NV17he00a1f91e47c47c8E = internal global <{ [128 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN8activity3app7SEED_NV17hf4dafb7016d58b30E = internal global <{ [2 x i8] }> <{ [2 x i8] c"\01\00" }>, section ".nv_vars", align 2
@_ZN8activity3app8COUNT_NV17hcd2f9443c900b7f9E = internal global <{ [2 x i8] }> <{ [2 x i8] c"\01\00" }>, section ".nv_vars", align 2
@alloc118 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\C3\00\00\00\22\00\00\00" }>, align 2
@alloc120 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\C4\00\00\00 \00\00\00" }>, align 2
@alloc122 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\CE\00\00\00\22\00\00\00" }>, align 2
@alloc124 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\CF\00\00\00 \00\00\00" }>, align 2
@alloc131 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"src/lib.rs" }>, align 1
@alloc94 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\9A\00\00\00\13\00\00\00" }>, align 2
@alloc96 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\9B\00\00\00\13\00\00\00" }>, align 2
@alloc98 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\9C\00\00\00\13\00\00\00" }>, align 2
@alloc100 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A4\00\00\00\18\00\00\00" }>, align 2
@alloc102 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A4\00\00\00,\00\00\00" }>, align 2
@alloc104 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A5\00\00\00\13\00\00\00" }>, align 2
@alloc106 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A6\00\00\00\18\00\00\00" }>, align 2
@alloc108 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A6\00\00\00-\00\00\00" }>, align 2
@alloc110 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A7\00\00\00\16\00\00\00" }>, align 2
@alloc112 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A8\00\00\00\18\00\00\00" }>, align 2
@alloc114 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A8\00\00\00-\00\00\00" }>, align 2
@alloc116 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A9\00\00\00\18\00\00\00" }>, align 2
@alloc92 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\81\00\00\00-\00\00\00" }>, align 2
@alloc90 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00v\00\00\00\09\00\00\00" }>, align 2
@atomic_depth = external global i16
@alloc10 = private unnamed_addr constant <{ [52 x i8] }> <{ [52 x i8] c"stats: s %l (%lu%%) m %l (%l%%) sum/tot %l/%l: %c\0D\0A\00" }>, align 1
@str.0 = internal constant [25 x i8] c"attempt to divide by zero"
@alloc126 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\06\01\00\00\1F\00\00\00" }>, align 2
@alloc128 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\07\01\00\00\1B\00\00\00" }>, align 2
@alloc130 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\006\01\00\00\09\00\00\00" }>, align 2
@alloc132 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc131, i32 0, i32 0, i32 0), [10 x i8] c"\0A\007\01\00\00\05\00\00\00" }>, align 2
@alloc11 = private unnamed_addr constant <{ [43 x i8] }> <{ [43 x i8] c"An error occured during count, count = %d\0A\00" }>, align 1
@anon.b7bafff2f871b915b57b152a19c6233b.18 = private unnamed_addr constant <{ i8*, [0 x i8] }> <{ i8* bitcast (<{ i8*, [2 x i8], i8*, [2 x i8] }>* @alloc16077 to i8*), [0 x i8] zeroinitializer }>, align 2
@anon.b7bafff2f871b915b57b152a19c6233b.10 = private unnamed_addr constant <{ i8*, [0 x i8] }> <{ i8* getelementptr inbounds (<{ [0 x i8] }>, <{ [0 x i8] }>* @alloc18891, i32 0, i32 0, i32 0), [0 x i8] zeroinitializer }>, align 2
@vtable.c = private unnamed_addr constant { void (%"fmt::USIZE_MARKER::{{closure}}"*)*, i16, i16, i64 (%"fmt::USIZE_MARKER::{{closure}}"*)* } { void (%"fmt::USIZE_MARKER::{{closure}}"*)* undef, i16 0, i16 1, i64 (%"fmt::USIZE_MARKER::{{closure}}"*)* undef }, align 2
@alloc18891 = private unnamed_addr constant <{ [0 x i8] }> zeroinitializer, align 2
@alloc16077 = private unnamed_addr constant <{ i8*, [2 x i8], i8*, [2 x i8] }> <{ i8* getelementptr inbounds (<{ [32 x i8] }>, <{ [32 x i8] }>* @alloc16075, i32 0, i32 0, i32 0), [2 x i8] c" \00", i8* getelementptr inbounds (<{ [18 x i8] }>, <{ [18 x i8] }>* @alloc16076, i32 0, i32 0, i32 0), [2 x i8] c"\12\00" }>, align 2
@alloc16075 = private unnamed_addr constant <{ [32 x i8] }> <{ [32 x i8] c"index out of bounds: the len is " }>, align 1
@alloc16076 = private unnamed_addr constant <{ [18 x i8] }> <{ [18 x i8] c" but the index is " }>, align 1

; Function Attrs: nounwind
define i8 @readSensor(i16 %input) unnamed_addr #0 {
start:
  %_2 = urem i16 %input, 85
  %0 = trunc i16 %_2 to i8
  ret i8 %0
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
  %_40 = alloca i8, align 1
  %localSeed = alloca i16, align 2
  %model = alloca %model_t*, align 2
  %prev_pin_state = alloca i8, align 1
  store i8 3, i8* %prev_pin_state, align 1
  store %model_t* bitcast (<{ [128 x i8] }>* @_ZN8activity3app8MODEL_NV17he00a1f91e47c47c8E to %model_t*), %model_t** %model, align 2
  br label %bb1

bb1:                                              ; preds = %bb23, %start
  %0 = load i16, i16* bitcast (<{ [2 x i8] }>* @_ZN8activity3app7SEED_NV17hf4dafb7016d58b30E to i16*), align 2
  store i16 %0, i16* %localSeed, align 2
  %mode = call i8 @_ZN8activity11select_mode17h34fda9ff2a07cda7E(i8* align 1 dereferenceable(1) %prev_pin_state, i16* align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN8activity3app8COUNT_NV17hcd2f9443c900b7f9E to i16*))
  br label %bb2

bb2:                                              ; preds = %bb1
  %_19 = icmp eq i8 %mode, 2
  br i1 %_19, label %bb4, label %bb3

bb3:                                              ; preds = %bb2
  %_26 = icmp eq i8 %mode, 1
  br i1 %_26, label %bb7, label %bb6

bb4:                                              ; preds = %bb2
  %1 = load %model_t*, %model_t** %model, align 2, !nonnull !0
  %_23 = bitcast %model_t* %1 to [16 x { i16, i16 }]*
  call void @_ZN8activity5train17hf26d00d4dc8eed5dE([16 x { i16, i16 }]* align 2 dereferenceable(64) %_23, i16* align 2 dereferenceable(2) %localSeed)
  br label %bb5

bb5:                                              ; preds = %bb4
  br label %bb23

bb6:                                              ; preds = %bb3
  %_33 = icmp eq i8 %mode, 0
  br i1 %_33, label %bb10, label %bb9

bb7:                                              ; preds = %bb3
  %2 = load %model_t*, %model_t** %model, align 2, !nonnull !0
  %_30 = getelementptr inbounds %model_t, %model_t* %2, i32 0, i32 3
  call void @_ZN8activity5train17hf26d00d4dc8eed5dE([16 x { i16, i16 }]* align 2 dereferenceable(64) %_30, i16* align 2 dereferenceable(2) %localSeed)
  br label %bb8

bb8:                                              ; preds = %bb7
  br label %bb22

bb9:                                              ; preds = %bb6
  %_41 = icmp eq i8 %mode, 3
  br i1 %_41, label %bb14, label %bb13

bb10:                                             ; preds = %bb6
  %_36 = load %model_t*, %model_t** %model, align 2, !nonnull !0
  call void @_ZN8activity9recognize17h40f90937659dbee8E(%model_t* noalias readonly align 2 dereferenceable(128) %_36, i16* align 2 dereferenceable(2) %localSeed)
  br label %bb11

bb11:                                             ; preds = %bb10
  br label %bb21

bb12:                                             ; preds = %bb14
  store i8 1, i8* %_40, align 1
  br label %bb15

bb13:                                             ; preds = %bb14, %bb9
  store i8 0, i8* %_40, align 1
  br label %bb15

bb14:                                             ; preds = %bb9
  %_44 = load i16, i16* bitcast (<{ [2 x i8] }>* @_ZN8activity3app8COUNT_NV17hcd2f9443c900b7f9E to i16*), align 2
  %_43 = icmp eq i16 %_44, 7
  br i1 %_43, label %bb12, label %bb13

bb15:                                             ; preds = %bb13, %bb12
  %3 = load i8, i8* %_40, align 1, !range !1
  %4 = trunc i8 %3 to i1
  br i1 %4, label %bb17, label %bb16

bb16:                                             ; preds = %bb15
  br label %bb20

bb17:                                             ; preds = %bb15
  store i16 1, i16* %localSeed, align 2
  store i16 1, i16* bitcast (<{ [2 x i8] }>* @_ZN8activity3app8COUNT_NV17hcd2f9443c900b7f9E to i16*), align 2
  store i8 3, i8* %prev_pin_state, align 1
  call void @gpioTwiddle()
  br label %bb18

bb18:                                             ; preds = %bb17
  call void @gpioTwiddle()
  br label %bb19

bb19:                                             ; preds = %bb18
  br label %bb20

bb20:                                             ; preds = %bb19, %bb16
  br label %bb21

bb21:                                             ; preds = %bb20, %bb11
  br label %bb22

bb22:                                             ; preds = %bb21, %bb8
  br label %bb23

bb23:                                             ; preds = %bb22, %bb5
  %_47 = load i16, i16* %localSeed, align 2
  store i16 %_47, i16* bitcast (<{ [2 x i8] }>* @_ZN8activity3app7SEED_NV17hf4dafb7016d58b30E to i16*), align 2
  br label %bb1
}

; Function Attrs: nounwind
define internal i8 @_ZN8activity11select_mode17h34fda9ff2a07cda7E(i8* align 1 dereferenceable(1) %prev_pin_state, i16* align 2 dereferenceable(2) %count) unnamed_addr #0 {
start:
  %_10 = alloca i8, align 1
  %_9 = alloca i8, align 1
  %_5 = alloca {}, align 1
  %pin_state = alloca i8, align 1
  %0 = alloca i8, align 1
  store i8 3, i8* %pin_state, align 1
  %_4 = load i16, i16* %count, align 2
  %1 = add i16 %_4, 1
  store i16 %1, i16* %count, align 2
  %2 = load i16, i16* %count, align 2
  switch i16 %2, label %bb1 [
    i16 1, label %bb2
    i16 2, label %bb2
    i16 3, label %bb3
    i16 4, label %bb3
    i16 5, label %bb4
    i16 6, label %bb4
    i16 7, label %bb5
  ]

bb1:                                              ; preds = %start
  store i8 3, i8* %pin_state, align 1
  call void @_ZN8activity11count_error17h41ffa6e48cfced15E(i16* noalias readonly align 2 dereferenceable(2) %count)
  br label %bb6

bb2:                                              ; preds = %start, %start
  store i8 1, i8* %pin_state, align 1
  br label %bb7

bb3:                                              ; preds = %start, %start
  store i8 2, i8* %pin_state, align 1
  br label %bb7

bb4:                                              ; preds = %start, %start
  store i8 0, i8* %pin_state, align 1
  br label %bb7

bb5:                                              ; preds = %start
  call void @_ZN8activity16end_of_benchmark17he2a20200e78592b7E()
  br label %bb7

bb6:                                              ; preds = %bb1
  br label %bb7

bb7:                                              ; preds = %bb6, %bb5, %bb4, %bb3, %bb2
  %_8 = load i16, i16* %count, align 2
  %_7 = icmp eq i16 %_8, 7
  br i1 %_7, label %bb9, label %bb8

bb8:                                              ; preds = %bb7
  %_12 = load i8, i8* %pin_state, align 1
  %_11 = icmp eq i8 %_12, 2
  br i1 %_11, label %bb15, label %bb17

bb9:                                              ; preds = %bb7
  store i8 3, i8* %0, align 1
  br label %bb10

bb10:                                             ; preds = %bb21, %bb9
  %3 = load i8, i8* %0, align 1
  ret i8 %3

bb11:                                             ; preds = %bb13
  store i8 1, i8* %_9, align 1
  br label %bb14

bb12:                                             ; preds = %bb18, %bb13
  store i8 0, i8* %_9, align 1
  br label %bb14

bb13:                                             ; preds = %bb18
  %_18 = load i8, i8* %pin_state, align 1
  %_19 = load i8, i8* %prev_pin_state, align 1
  %_17 = icmp eq i8 %_18, %_19
  br i1 %_17, label %bb11, label %bb12

bb14:                                             ; preds = %bb12, %bb11
  %4 = load i8, i8* %_9, align 1, !range !1
  %5 = trunc i8 %4 to i1
  br i1 %5, label %bb20, label %bb19

bb15:                                             ; preds = %bb17, %bb8
  store i8 1, i8* %_10, align 1
  br label %bb18

bb16:                                             ; preds = %bb17
  store i8 0, i8* %_10, align 1
  br label %bb18

bb17:                                             ; preds = %bb8
  %_15 = load i8, i8* %pin_state, align 1
  %_14 = icmp eq i8 %_15, 1
  br i1 %_14, label %bb15, label %bb16

bb18:                                             ; preds = %bb16, %bb15
  %6 = load i8, i8* %_10, align 1, !range !1
  %7 = trunc i8 %6 to i1
  br i1 %7, label %bb13, label %bb12

bb19:                                             ; preds = %bb14
  %_21 = load i8, i8* %pin_state, align 1
  store i8 %_21, i8* %prev_pin_state, align 1
  br label %bb21

bb20:                                             ; preds = %bb14
  store i8 3, i8* %pin_state, align 1
  br label %bb21

bb21:                                             ; preds = %bb20, %bb19
  %8 = load i8, i8* %pin_state, align 1
  store i8 %8, i8* %0, align 1
  br label %bb10
}

; Function Attrs: nounwind
define internal void @_ZN8activity5train17hf26d00d4dc8eed5dE([16 x { i16, i16 }]* align 2 dereferenceable(64) %classModel, i16* align 2 dereferenceable(2) %seed) unnamed_addr #0 {
start:
  %_14 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_11 = alloca { i16, i16 }, align 2
  %features = alloca { i16, i16 }, align 2
  %_6 = alloca %threeAxis_t_8, align 1
  %_5 = alloca %threeAxis_t_8, align 1
  %_4 = alloca %threeAxis_t_8, align 1
  %sampleWindow = alloca [3 x %threeAxis_t_8], align 1
  %0 = bitcast %threeAxis_t_8* %_4 to i8*
  store i8 0, i8* %0, align 1
  %1 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_4, i32 0, i32 3
  store i8 0, i8* %1, align 1
  %2 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_4, i32 0, i32 5
  store i8 0, i8* %2, align 1
  %3 = bitcast %threeAxis_t_8* %_5 to i8*
  store i8 0, i8* %3, align 1
  %4 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_5, i32 0, i32 3
  store i8 0, i8* %4, align 1
  %5 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_5, i32 0, i32 5
  store i8 0, i8* %5, align 1
  %6 = bitcast %threeAxis_t_8* %_6 to i8*
  store i8 0, i8* %6, align 1
  %7 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_6, i32 0, i32 3
  store i8 0, i8* %7, align 1
  %8 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_6, i32 0, i32 5
  store i8 0, i8* %8, align 1
  %9 = bitcast [3 x %threeAxis_t_8]* %sampleWindow to %threeAxis_t_8*
  %10 = bitcast %threeAxis_t_8* %9 to i8*
  %11 = bitcast %threeAxis_t_8* %_4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %10, i8* align 1 %11, i16 3, i1 false)
  %12 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %sampleWindow, i32 0, i32 1
  %13 = bitcast %threeAxis_t_8* %12 to i8*
  %14 = bitcast %threeAxis_t_8* %_5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %13, i8* align 1 %14, i16 3, i1 false)
  %15 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %sampleWindow, i32 0, i32 2
  %16 = bitcast %threeAxis_t_8* %15 to i8*
  %17 = bitcast %threeAxis_t_8* %_6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %16, i8* align 1 %17, i16 3, i1 false)
  %18 = bitcast { i16, i16 }* %features to i16*
  store i16 0, i16* %18, align 2
  %19 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %features, i32 0, i32 1
  store i16 0, i16* %19, align 2
  call void @_ZN8activity13warmup_sensor17he7878671afcb6869E(i16* align 2 dereferenceable(2) %seed)
  br label %bb1

bb1:                                              ; preds = %start
  %20 = bitcast { i16, i16 }* %_11 to i16*
  store i16 0, i16* %20, align 2
  %21 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_11, i32 0, i32 1
  store i16 16, i16* %21, align 2
  %22 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_11, i32 0, i32 0
  %23 = load i16, i16* %22, align 2
  %24 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_11, i32 0, i32 1
  %25 = load i16, i16* %24, align 2
  %26 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h820c98c80fab166dE"(i16 %23, i16 %25)
  %_10.0 = extractvalue { i16, i16 } %26, 0
  %_10.1 = extractvalue { i16, i16 } %26, 1
  br label %bb2

bb2:                                              ; preds = %bb1
  %27 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_10.0, i16* %27, align 2
  %28 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_10.1, i16* %28, align 2
  br label %bb3

bb3:                                              ; preds = %bb12, %bb2
  %29 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %29, { i16, i16 }* %_14, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  %30 = bitcast { i16, i16 }* %_14 to i16*
  %_17 = load i16, i16* %30, align 2, !range !2
  switch i16 %_17, label %bb6 [
    i16 0, label %bb5
    i16 1, label %bb7
  ]

bb5:                                              ; preds = %bb4
  ret void

bb6:                                              ; preds = %bb4
  unreachable

bb7:                                              ; preds = %bb4
  %31 = bitcast { i16, i16 }* %_14 to %"core::option::Option<u16>::Some"*
  %32 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %31, i32 0, i32 1
  %val = load i16, i16* %32, align 2
  call void @_ZN8activity14acquire_window17hf97e6ac9e2e562c0E([3 x %threeAxis_t_8]* align 1 dereferenceable(9) %sampleWindow, i16* align 2 dereferenceable(2) %seed)
  br label %bb8

bb8:                                              ; preds = %bb7
  call void @_ZN8activity9transform17ha7d1d5edd306502aE([3 x %threeAxis_t_8]* align 1 dereferenceable(9) %sampleWindow)
  br label %bb9

bb9:                                              ; preds = %bb8
  call void @_ZN8activity9featurize17h8abf3f5c05526bc9E({ i16, i16 }* align 2 dereferenceable(4) %features, [3 x %threeAxis_t_8]* noalias readonly align 1 dereferenceable(9) %sampleWindow)
  br label %bb10

bb10:                                             ; preds = %bb9
  %33 = bitcast { i16, i16 }* %features to i16*
  %_33 = load i16, i16* %33, align 2
  %_36 = icmp ult i16 %val, 16
  %34 = call i1 @llvm.expect.i1(i1 %_36, i1 true)
  br i1 %34, label %bb11, label %panic

bb11:                                             ; preds = %bb10
  %35 = getelementptr inbounds [16 x { i16, i16 }], [16 x { i16, i16 }]* %classModel, i16 0, i16 %val
  %36 = bitcast { i16, i16 }* %35 to i16*
  store i16 %_33, i16* %36, align 2
  %37 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %features, i32 0, i32 1
  %_37 = load i16, i16* %37, align 2
  %_40 = icmp ult i16 %val, 16
  %38 = call i1 @llvm.expect.i1(i1 %_40, i1 true)
  br i1 %38, label %bb12, label %panic1

bb12:                                             ; preds = %bb11
  %39 = getelementptr inbounds [16 x { i16, i16 }], [16 x { i16, i16 }]* %classModel, i16 0, i16 %val
  %40 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %39, i32 0, i32 1
  store i16 %_37, i16* %40, align 2
  br label %bb3

panic:                                            ; preds = %bb10
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 16, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc130 to %"core::panic::Location"*))
  unreachable

panic1:                                           ; preds = %bb11
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 16, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc132 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define internal void @_ZN8activity9recognize17h40f90937659dbee8E(%model_t* noalias readonly align 2 dereferenceable(128) %model, i16* align 2 dereferenceable(2) %seed) unnamed_addr #0 {
start:
  %_14 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_11 = alloca { i16, i16 }, align 2
  %class = alloca i8, align 1
  %features = alloca { i16, i16 }, align 2
  %_7 = alloca %threeAxis_t_8, align 1
  %_6 = alloca %threeAxis_t_8, align 1
  %_5 = alloca %threeAxis_t_8, align 1
  %sampleWindow = alloca [3 x %threeAxis_t_8], align 1
  %stats = alloca %stats_t, align 2
  %0 = bitcast %stats_t* %stats to i16*
  store i16 0, i16* %0, align 2
  %1 = getelementptr inbounds %stats_t, %stats_t* %stats, i32 0, i32 3
  store i16 0, i16* %1, align 2
  %2 = getelementptr inbounds %stats_t, %stats_t* %stats, i32 0, i32 5
  store i16 0, i16* %2, align 2
  %3 = bitcast %threeAxis_t_8* %_5 to i8*
  store i8 0, i8* %3, align 1
  %4 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_5, i32 0, i32 3
  store i8 0, i8* %4, align 1
  %5 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_5, i32 0, i32 5
  store i8 0, i8* %5, align 1
  %6 = bitcast %threeAxis_t_8* %_6 to i8*
  store i8 0, i8* %6, align 1
  %7 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_6, i32 0, i32 3
  store i8 0, i8* %7, align 1
  %8 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_6, i32 0, i32 5
  store i8 0, i8* %8, align 1
  %9 = bitcast %threeAxis_t_8* %_7 to i8*
  store i8 0, i8* %9, align 1
  %10 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_7, i32 0, i32 3
  store i8 0, i8* %10, align 1
  %11 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_7, i32 0, i32 5
  store i8 0, i8* %11, align 1
  %12 = bitcast [3 x %threeAxis_t_8]* %sampleWindow to %threeAxis_t_8*
  %13 = bitcast %threeAxis_t_8* %12 to i8*
  %14 = bitcast %threeAxis_t_8* %_5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %13, i8* align 1 %14, i16 3, i1 false)
  %15 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %sampleWindow, i32 0, i32 1
  %16 = bitcast %threeAxis_t_8* %15 to i8*
  %17 = bitcast %threeAxis_t_8* %_6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %16, i8* align 1 %17, i16 3, i1 false)
  %18 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %sampleWindow, i32 0, i32 2
  %19 = bitcast %threeAxis_t_8* %18 to i8*
  %20 = bitcast %threeAxis_t_8* %_7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %19, i8* align 1 %20, i16 3, i1 false)
  %21 = bitcast { i16, i16 }* %features to i16*
  store i16 0, i16* %21, align 2
  %22 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %features, i32 0, i32 1
  store i16 0, i16* %22, align 2
  %23 = bitcast { i16, i16 }* %_11 to i16*
  store i16 0, i16* %23, align 2
  %24 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_11, i32 0, i32 1
  store i16 128, i16* %24, align 2
  %25 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_11, i32 0, i32 0
  %26 = load i16, i16* %25, align 2
  %27 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_11, i32 0, i32 1
  %28 = load i16, i16* %27, align 2
  %29 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hdc7eb11e15c9fef2E"(i16 %26, i16 %28)
  %_10.0 = extractvalue { i16, i16 } %29, 0
  %_10.1 = extractvalue { i16, i16 } %29, 1
  br label %bb1

bb1:                                              ; preds = %start
  %30 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_10.0, i16* %30, align 2
  %31 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_10.1, i16* %31, align 2
  br label %bb2

bb2:                                              ; preds = %bb12, %bb1
  %32 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h39265d3a01910333E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %32, { i16, i16 }* %_14, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %33 = bitcast { i16, i16 }* %_14 to i16*
  %_17 = load i16, i16* %33, align 2, !range !2
  switch i16 %_17, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  call void @_ZN8activity11print_stats17h1cc85696f5fee32bE(%stats_t* noalias readonly align 2 dereferenceable(6) %stats)
  br label %bb13

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %34 = bitcast { i16, i16 }* %_14 to %"core::option::Option<u16>::Some"*
  %35 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %34, i32 0, i32 1
  %val = load i16, i16* %35, align 2
  call void @atomic_start()
  call void @_ZN8activity14acquire_window17hf97e6ac9e2e562c0E([3 x %threeAxis_t_8]* align 1 dereferenceable(9) %sampleWindow, i16* align 2 dereferenceable(2) %seed)
  br label %bb7

bb7:                                              ; preds = %bb6
  call void @_ZN8activity9transform17ha7d1d5edd306502aE([3 x %threeAxis_t_8]* align 1 dereferenceable(9) %sampleWindow)
  br label %bb8

bb8:                                              ; preds = %bb7
  call void @_ZN8activity9featurize17h8abf3f5c05526bc9E({ i16, i16 }* align 2 dereferenceable(4) %features, [3 x %threeAxis_t_8]* noalias readonly align 1 dereferenceable(9) %sampleWindow)
  br label %bb9

bb9:                                              ; preds = %bb8
  %_33 = call zeroext i1 @_ZN8activity8classify17hf85326ac24ac80feE({ i16, i16 }* noalias readonly align 2 dereferenceable(4) %features, %model_t* noalias readonly align 2 dereferenceable(128) %model)
  br label %bb10

bb10:                                             ; preds = %bb9
  %36 = zext i1 %_33 to i8
  store i8 %36, i8* %class, align 1
  br label %bb11

bb11:                                             ; preds = %bb10
  %37 = load i8, i8* %class, align 1, !range !1
  %_42 = trunc i8 %37 to i1
  call void @_ZN8activity12record_stats17h6d68c2daa7082338E(%stats_t* align 2 dereferenceable(6) %stats, i1 zeroext %_42)
  call void @atomic_end()
  br label %bb12

bb12:                                             ; preds = %bb11
  br label %bb2

bb13:                                             ; preds = %bb4
  ret void
}

; Function Attrs: nounwind
declare void @gpioTwiddle() unnamed_addr #0

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i16(i8* nocapture writeonly, i8* nocapture readonly, i16, i1 immarg) #1

; Function Attrs: nounwind
define internal { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17hdc7eb11e15c9fef2E"(i16 %self.0, i16 %self.1) unnamed_addr #0 {
start:
  %0 = insertvalue { i16, i16 } undef, i16 %self.0, 0
  %1 = insertvalue { i16, i16 } %0, i16 %self.1, 1
  ret { i16, i16 } %1
}

; Function Attrs: inlinehint nounwind
define internal { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h39265d3a01910333E"({ i16, i16 }* align 2 dereferenceable(4) %self) unnamed_addr #2 {
start:
  %0 = alloca { i16, i16 }, align 2
  %_3 = bitcast { i16, i16 }* %self to i16*
  %_4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %self, i32 0, i32 1
  %_2 = call zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$u16$GT$2lt17hb538d7d011c40015E"(i16* noalias readonly align 2 dereferenceable(2) %_3, i16* noalias readonly align 2 dereferenceable(2) %_4)
  br label %bb1

bb1:                                              ; preds = %start
  br i1 %_2, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  %1 = bitcast { i16, i16 }* %0 to i16*
  store i16 0, i16* %1, align 2
  br label %bb7

bb3:                                              ; preds = %bb1
  %_7 = bitcast { i16, i16 }* %self to i16*
  %_6 = call i16 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$u16$GT$5clone17h05f23cea223ff2c3E"(i16* noalias readonly align 2 dereferenceable(2) %_7)
  br label %bb4

bb4:                                              ; preds = %bb3
  %n = call i16 @"_ZN47_$LT$u16$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h96e2de61b28cc265E"(i16 %_6, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  %_10 = bitcast { i16, i16 }* %self to i16*
  %_8 = call i16 @_ZN4core3mem7replace17h84e8cec08f3f1630E(i16* align 2 dereferenceable(2) %_10, i16 %n)
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
  %6 = load i16, i16* %5, align 2, !range !2
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %0, i32 0, i32 1
  %8 = load i16, i16* %7, align 2
  %9 = insertvalue { i16, i16 } undef, i16 %6, 0
  %10 = insertvalue { i16, i16 } %9, i16 %8, 1
  ret { i16, i16 } %10
}

; Function Attrs: nounwind
define internal void @_ZN8activity11print_stats17h1cc85696f5fee32bE(%stats_t* noalias readonly align 2 dereferenceable(6) %stats) unnamed_addr #0 {
start:
  %_34 = alloca i8, align 1
  %_33 = alloca i32, align 2
  %0 = getelementptr inbounds %stats_t, %stats_t* %stats, i32 0, i32 5
  %_4 = load i16, i16* %0, align 2
  %_3 = mul i16 %_4, 100
  %1 = bitcast %stats_t* %stats to i16*
  %_5 = load i16, i16* %1, align 2
  %_6 = icmp eq i16 %_5, 0
  %2 = call i1 @llvm.expect.i1(i1 %_6, i1 false)
  br i1 %2, label %panic, label %bb1

bb1:                                              ; preds = %start
  %resultStationaryPct = udiv i16 %_3, %_5
  %3 = getelementptr inbounds %stats_t, %stats_t* %stats, i32 0, i32 3
  %_9 = load i16, i16* %3, align 2
  %_8 = mul i16 %_9, 100
  %4 = bitcast %stats_t* %stats to i16*
  %_10 = load i16, i16* %4, align 2
  %_11 = icmp eq i16 %_10, 0
  %5 = call i1 @llvm.expect.i1(i1 %_11, i1 false)
  br i1 %5, label %panic1, label %bb2

bb2:                                              ; preds = %bb1
  %resultMovingPct = udiv i16 %_8, %_10
  %6 = getelementptr inbounds %stats_t, %stats_t* %stats, i32 0, i32 5
  %_13 = load i16, i16* %6, align 2
  %7 = getelementptr inbounds %stats_t, %stats_t* %stats, i32 0, i32 3
  %_14 = load i16, i16* %7, align 2
  %sum = add i16 %_13, %_14
  call void @output_guard_start()
  br label %bb3

bb3:                                              ; preds = %bb2
  %_17 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [52 x i8] }>* @alloc10 to [0 x i8]*), i16 52)
  br label %bb4

bb4:                                              ; preds = %bb3
  %8 = getelementptr inbounds %stats_t, %stats_t* %stats, i32 0, i32 5
  %_22 = load i16, i16* %8, align 2
  %_21 = zext i16 %_22 to i32
  %_23 = zext i16 %resultStationaryPct to i32
  %9 = getelementptr inbounds %stats_t, %stats_t* %stats, i32 0, i32 3
  %_26 = load i16, i16* %9, align 2
  %_25 = zext i16 %_26 to i32
  %_27 = zext i16 %resultMovingPct to i32
  %10 = bitcast %stats_t* %stats to i16*
  %_30 = load i16, i16* %10, align 2
  %_29 = zext i16 %_30 to i32
  %_31 = zext i16 %sum to i32
  %11 = bitcast %stats_t* %stats to i16*
  %_37 = load i16, i16* %11, align 2
  %_35 = icmp eq i16 %sum, %_37
  br i1 %_35, label %bb7, label %bb6

bb5:                                              ; preds = %bb7
  store i8 1, i8* %_34, align 1
  br label %bb8

bb6:                                              ; preds = %bb7, %bb4
  store i8 0, i8* %_34, align 1
  br label %bb8

bb7:                                              ; preds = %bb4
  %_38 = icmp eq i16 %sum, 128
  br i1 %_38, label %bb5, label %bb6

bb8:                                              ; preds = %bb6, %bb5
  %12 = load i8, i8* %_34, align 1, !range !1
  %13 = trunc i8 %12 to i1
  br i1 %13, label %bb10, label %bb9

bb9:                                              ; preds = %bb8
  store i32 88, i32* %_33, align 2
  br label %bb11

bb10:                                             ; preds = %bb8
  store i32 86, i32* %_33, align 2
  br label %bb11

bb11:                                             ; preds = %bb10, %bb9
  %14 = load i32, i32* %_33, align 2, !range !3
  call void (i8*, ...) @printf(i8* %_17, i32 %_21, i32 %_23, i32 %_25, i32 %_27, i32 %_29, i32 %_31, i32 %14)
  br label %bb12

bb12:                                             ; preds = %bb11
  call void @output_guard_end()
  br label %bb13

bb13:                                             ; preds = %bb12
  ret void

panic:                                            ; preds = %start
  call void @_ZN4core9panicking5panic17h33d11d8bc643763fE([0 x i8]* noalias nonnull readonly align 1 bitcast ([25 x i8]* @str.0 to [0 x i8]*), i16 25, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc126 to %"core::panic::Location"*))
  unreachable

panic1:                                           ; preds = %bb1
  call void @_ZN4core9panicking5panic17h33d11d8bc643763fE([0 x i8]* noalias nonnull readonly align 1 bitcast ([25 x i8]* @str.0 to [0 x i8]*), i16 25, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc128 to %"core::panic::Location"*))
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

; Function Attrs: nounwind
define internal void @_ZN8activity14acquire_window17hf97e6ac9e2e562c0E([3 x %threeAxis_t_8]* align 1 dereferenceable(9) %window, i16* align 2 dereferenceable(2) %seed) unnamed_addr #0 {
start:
  %_8 = alloca %threeAxis_t_8, align 1
  %sample = alloca %threeAxis_t_8, align 1
  %samplesInWindow = alloca i16, align 2
  store i16 0, i16* %samplesInWindow, align 2
  br label %bb1

bb1:                                              ; preds = %bb5, %start
  %_5 = load i16, i16* %samplesInWindow, align 2
  %_4 = icmp ult i16 %_5, 3
  br i1 %_4, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  ret void

bb3:                                              ; preds = %bb1
  call void @_ZN8activity12accel_sample17habeed4fee8dc460dE(%threeAxis_t_8* noalias nocapture sret dereferenceable(3) %sample, i16* align 2 dereferenceable(2) %seed)
  br label %bb4

bb4:                                              ; preds = %bb3
  %0 = bitcast %threeAxis_t_8* %_8 to i8*
  %1 = bitcast %threeAxis_t_8* %sample to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %0, i8* align 1 %1, i16 3, i1 false)
  %_9 = load i16, i16* %samplesInWindow, align 2
  %_11 = icmp ult i16 %_9, 3
  %2 = call i1 @llvm.expect.i1(i1 %_11, i1 true)
  br i1 %2, label %bb5, label %panic

bb5:                                              ; preds = %bb4
  %3 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %window, i16 0, i16 %_9
  %4 = bitcast %threeAxis_t_8* %3 to i8*
  %5 = bitcast %threeAxis_t_8* %_8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %4, i8* align 1 %5, i16 3, i1 false)
  %6 = load i16, i16* %samplesInWindow, align 2
  %7 = add i16 %6, 1
  store i16 %7, i16* %samplesInWindow, align 2
  br label %bb1

panic:                                            ; preds = %bb4
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %_9, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc90 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define internal void @_ZN8activity9transform17ha7d1d5edd306502aE([3 x %threeAxis_t_8]* align 1 dereferenceable(9) %window) unnamed_addr #0 {
start:
  %_32 = alloca i8, align 1
  %_29 = alloca i8, align 1
  %_26 = alloca i8, align 1
  %_19 = alloca i8, align 1
  %_18 = alloca i8, align 1
  %_6 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_3 = alloca { i16, i16 }, align 2
  %0 = bitcast { i16, i16 }* %_3 to i16*
  store i16 0, i16* %0, align 2
  %1 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_3, i32 0, i32 1
  store i16 3, i16* %1, align 2
  %2 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_3, i32 0, i32 0
  %3 = load i16, i16* %2, align 2
  %4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_3, i32 0, i32 1
  %5 = load i16, i16* %4, align 2
  %6 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h820c98c80fab166dE"(i16 %3, i16 %5)
  %_2.0 = extractvalue { i16, i16 } %6, 0
  %_2.1 = extractvalue { i16, i16 } %6, 1
  br label %bb1

bb1:                                              ; preds = %start
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_2.0, i16* %7, align 2
  %8 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_2.1, i16* %8, align 2
  br label %bb2

bb2:                                              ; preds = %bb27, %bb1
  %9 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %9, { i16, i16 }* %_6, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %10 = bitcast { i16, i16 }* %_6 to i16*
  %_9 = load i16, i16* %10, align 2, !range !2
  switch i16 %_9, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  ret void

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %11 = bitcast { i16, i16 }* %_6 to %"core::option::Option<u16>::Some"*
  %12 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %11, i32 0, i32 1
  %val = load i16, i16* %12, align 2
  %_17 = icmp ult i16 %val, 3
  %13 = call i1 @llvm.expect.i1(i1 %_17, i1 true)
  br i1 %13, label %bb7, label %panic

bb7:                                              ; preds = %bb6
  %_14 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %window, i16 0, i16 %val
  %14 = bitcast %threeAxis_t_8* %_14 to i8*
  %_21 = load i8, i8* %14, align 1
  %_20 = icmp ult i8 %_21, 10
  br i1 %_20, label %bb12, label %bb14

bb8:                                              ; preds = %bb15, %bb10
  store i8 1, i8* %_18, align 1
  br label %bb11

bb9:                                              ; preds = %bb10
  store i8 0, i8* %_18, align 1
  br label %bb11

bb10:                                             ; preds = %bb15
  %15 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_14, i32 0, i32 5
  %_25 = load i8, i8* %15, align 1
  %_24 = icmp ult i8 %_25, 10
  br i1 %_24, label %bb8, label %bb9

bb11:                                             ; preds = %bb9, %bb8
  %16 = load i8, i8* %_18, align 1, !range !1
  %17 = trunc i8 %16 to i1
  br i1 %17, label %bb17, label %bb16

bb12:                                             ; preds = %bb14, %bb7
  store i8 1, i8* %_19, align 1
  br label %bb15

bb13:                                             ; preds = %bb14
  store i8 0, i8* %_19, align 1
  br label %bb15

bb14:                                             ; preds = %bb7
  %18 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_14, i32 0, i32 3
  %_23 = load i8, i8* %18, align 1
  %_22 = icmp ult i8 %_23, 10
  br i1 %_22, label %bb12, label %bb13

bb15:                                             ; preds = %bb13, %bb12
  %19 = load i8, i8* %_19, align 1, !range !1
  %20 = trunc i8 %19 to i1
  br i1 %20, label %bb8, label %bb10

bb16:                                             ; preds = %bb11
  br label %bb27

bb17:                                             ; preds = %bb11
  %21 = bitcast %threeAxis_t_8* %_14 to i8*
  %_28 = load i8, i8* %21, align 1
  %_27 = icmp ugt i8 %_28, 10
  br i1 %_27, label %bb19, label %bb18

bb18:                                             ; preds = %bb17
  store i8 0, i8* %_26, align 1
  br label %bb20

bb19:                                             ; preds = %bb17
  %22 = bitcast %threeAxis_t_8* %_14 to i8*
  %23 = load i8, i8* %22, align 1
  store i8 %23, i8* %_26, align 1
  br label %bb20

bb20:                                             ; preds = %bb19, %bb18
  %24 = bitcast %threeAxis_t_8* %_14 to i8*
  %25 = load i8, i8* %_26, align 1
  store i8 %25, i8* %24, align 1
  %26 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_14, i32 0, i32 3
  %_31 = load i8, i8* %26, align 1
  %_30 = icmp ugt i8 %_31, 10
  br i1 %_30, label %bb22, label %bb21

bb21:                                             ; preds = %bb20
  store i8 0, i8* %_29, align 1
  br label %bb23

bb22:                                             ; preds = %bb20
  %27 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_14, i32 0, i32 3
  %28 = load i8, i8* %27, align 1
  store i8 %28, i8* %_29, align 1
  br label %bb23

bb23:                                             ; preds = %bb22, %bb21
  %29 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_14, i32 0, i32 3
  %30 = load i8, i8* %_29, align 1
  store i8 %30, i8* %29, align 1
  %31 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_14, i32 0, i32 5
  %_34 = load i8, i8* %31, align 1
  %_33 = icmp ugt i8 %_34, 10
  br i1 %_33, label %bb25, label %bb24

bb24:                                             ; preds = %bb23
  store i8 0, i8* %_32, align 1
  br label %bb26

bb25:                                             ; preds = %bb23
  %32 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_14, i32 0, i32 5
  %33 = load i8, i8* %32, align 1
  store i8 %33, i8* %_32, align 1
  br label %bb26

bb26:                                             ; preds = %bb25, %bb24
  %34 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %_14, i32 0, i32 5
  %35 = load i8, i8* %_32, align 1
  store i8 %35, i8* %34, align 1
  br label %bb27

bb27:                                             ; preds = %bb26, %bb16
  br label %bb2

panic:                                            ; preds = %bb6
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc92 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define internal void @_ZN8activity9featurize17h8abf3f5c05526bc9E({ i16, i16 }* align 2 dereferenceable(4) %features, [3 x %threeAxis_t_8]* noalias readonly align 1 dereferenceable(9) %aWin) unnamed_addr #0 {
start:
  %_73 = alloca i8, align 1
  %_56 = alloca i8, align 1
  %_39 = alloca i8, align 1
  %_32 = alloca { i16, i16 }, align 2
  %iter1 = alloca { i16, i16 }, align 2
  %_29 = alloca { i16, i16 }, align 2
  %_9 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_6 = alloca { i16, i16 }, align 2
  %stddev = alloca %threeAxis_t_8, align 1
  %mean = alloca %threeAxis_t_8, align 1
  %0 = bitcast %threeAxis_t_8* %mean to i8*
  store i8 0, i8* %0, align 1
  %1 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 3
  store i8 0, i8* %1, align 1
  %2 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 5
  store i8 0, i8* %2, align 1
  %3 = bitcast %threeAxis_t_8* %stddev to i8*
  store i8 0, i8* %3, align 1
  %4 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 3
  store i8 0, i8* %4, align 1
  %5 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 5
  store i8 0, i8* %5, align 1
  %6 = bitcast { i16, i16 }* %_6 to i16*
  store i16 0, i16* %6, align 2
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_6, i32 0, i32 1
  store i16 3, i16* %7, align 2
  %8 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_6, i32 0, i32 0
  %9 = load i16, i16* %8, align 2
  %10 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_6, i32 0, i32 1
  %11 = load i16, i16* %10, align 2
  %12 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h820c98c80fab166dE"(i16 %9, i16 %11)
  %_5.0 = extractvalue { i16, i16 } %12, 0
  %_5.1 = extractvalue { i16, i16 } %12, 1
  br label %bb1

bb1:                                              ; preds = %start
  %13 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_5.0, i16* %13, align 2
  %14 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_5.1, i16* %14, align 2
  br label %bb2

bb2:                                              ; preds = %bb9, %bb1
  %15 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %15, { i16, i16 }* %_9, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %16 = bitcast { i16, i16 }* %_9 to i16*
  %_12 = load i16, i16* %16, align 2, !range !2
  switch i16 %_12, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  %17 = bitcast %threeAxis_t_8* %mean to i8*
  %18 = bitcast %threeAxis_t_8* %mean to i8*
  %19 = load i8, i8* %18, align 1
  %20 = lshr i8 %19, 2
  store i8 %20, i8* %17, align 1
  %21 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 3
  %22 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 3
  %23 = load i8, i8* %22, align 1
  %24 = lshr i8 %23, 2
  store i8 %24, i8* %21, align 1
  %25 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 5
  %26 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 5
  %27 = load i8, i8* %26, align 1
  %28 = lshr i8 %27, 2
  store i8 %28, i8* %25, align 1
  %29 = bitcast { i16, i16 }* %_29 to i16*
  store i16 0, i16* %29, align 2
  %30 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_29, i32 0, i32 1
  store i16 3, i16* %30, align 2
  %31 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_29, i32 0, i32 0
  %32 = load i16, i16* %31, align 2
  %33 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_29, i32 0, i32 1
  %34 = load i16, i16* %33, align 2
  %35 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h820c98c80fab166dE"(i16 %32, i16 %34)
  %_28.0 = extractvalue { i16, i16 } %35, 0
  %_28.1 = extractvalue { i16, i16 } %35, 1
  br label %bb10

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %36 = bitcast { i16, i16 }* %_9 to %"core::option::Option<u16>::Some"*
  %37 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %36, i32 0, i32 1
  %val = load i16, i16* %37, align 2
  %_19 = icmp ult i16 %val, 3
  %38 = call i1 @llvm.expect.i1(i1 %_19, i1 true)
  br i1 %38, label %bb7, label %panic

bb7:                                              ; preds = %bb6
  %39 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %aWin, i16 0, i16 %val
  %40 = bitcast %threeAxis_t_8* %39 to i8*
  %_16 = load i8, i8* %40, align 1
  %41 = bitcast %threeAxis_t_8* %mean to i8*
  %42 = bitcast %threeAxis_t_8* %mean to i8*
  %43 = load i8, i8* %42, align 1
  %44 = add i8 %43, %_16
  store i8 %44, i8* %41, align 1
  %_23 = icmp ult i16 %val, 3
  %45 = call i1 @llvm.expect.i1(i1 %_23, i1 true)
  br i1 %45, label %bb8, label %panic2

bb8:                                              ; preds = %bb7
  %46 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %aWin, i16 0, i16 %val
  %47 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %46, i32 0, i32 3
  %_20 = load i8, i8* %47, align 1
  %48 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 3
  %49 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 3
  %50 = load i8, i8* %49, align 1
  %51 = add i8 %50, %_20
  store i8 %51, i8* %48, align 1
  %_27 = icmp ult i16 %val, 3
  %52 = call i1 @llvm.expect.i1(i1 %_27, i1 true)
  br i1 %52, label %bb9, label %panic3

bb9:                                              ; preds = %bb8
  %53 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %aWin, i16 0, i16 %val
  %54 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %53, i32 0, i32 5
  %_24 = load i8, i8* %54, align 1
  %55 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 5
  %56 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 5
  %57 = load i8, i8* %56, align 1
  %58 = add i8 %57, %_24
  store i8 %58, i8* %55, align 1
  br label %bb2

bb10:                                             ; preds = %bb4
  %59 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter1, i32 0, i32 0
  store i16 %_28.0, i16* %59, align 2
  %60 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter1, i32 0, i32 1
  store i16 %_28.1, i16* %60, align 2
  br label %bb11

bb11:                                             ; preds = %bb33, %bb10
  %61 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %iter1)
  store { i16, i16 } %61, { i16, i16 }* %_32, align 2
  br label %bb12

bb12:                                             ; preds = %bb11
  %62 = bitcast { i16, i16 }* %_32 to i16*
  %_35 = load i16, i16* %62, align 2, !range !2
  switch i16 %_35, label %bb14 [
    i16 0, label %bb13
    i16 1, label %bb15
  ]

bb13:                                             ; preds = %bb12
  %63 = bitcast %threeAxis_t_8* %stddev to i8*
  %64 = bitcast %threeAxis_t_8* %stddev to i8*
  %65 = load i8, i8* %64, align 1
  %66 = lshr i8 %65, 2
  store i8 %66, i8* %63, align 1
  %67 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 3
  %68 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 3
  %69 = load i8, i8* %68, align 1
  %70 = lshr i8 %69, 2
  store i8 %70, i8* %67, align 1
  %71 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 5
  %72 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 5
  %73 = load i8, i8* %72, align 1
  %74 = lshr i8 %73, 2
  store i8 %74, i8* %71, align 1
  %75 = bitcast %threeAxis_t_8* %mean to i8*
  %_94 = load i8, i8* %75, align 1
  %_93 = zext i8 %_94 to i32
  %76 = bitcast %threeAxis_t_8* %mean to i8*
  %_96 = load i8, i8* %76, align 1
  %_95 = zext i8 %_96 to i32
  %_92 = mul i32 %_93, %_95
  %77 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 3
  %_99 = load i8, i8* %77, align 1
  %_98 = zext i8 %_99 to i32
  %78 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 3
  %_101 = load i8, i8* %78, align 1
  %_100 = zext i8 %_101 to i32
  %_97 = mul i32 %_98, %_100
  %_91 = add i32 %_92, %_97
  %79 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 5
  %_104 = load i8, i8* %79, align 1
  %_103 = zext i8 %_104 to i32
  %80 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 5
  %_106 = load i8, i8* %80, align 1
  %_105 = zext i8 %_106 to i32
  %_102 = mul i32 %_103, %_105
  %meanmag = add i32 %_91, %_102
  %81 = bitcast %threeAxis_t_8* %stddev to i8*
  %_111 = load i8, i8* %81, align 1
  %_110 = zext i8 %_111 to i32
  %82 = bitcast %threeAxis_t_8* %stddev to i8*
  %_113 = load i8, i8* %82, align 1
  %_112 = zext i8 %_113 to i32
  %_109 = mul i32 %_110, %_112
  %83 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 3
  %_116 = load i8, i8* %83, align 1
  %_115 = zext i8 %_116 to i32
  %84 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 3
  %_118 = load i8, i8* %84, align 1
  %_117 = zext i8 %_118 to i32
  %_114 = mul i32 %_115, %_117
  %_108 = add i32 %_109, %_114
  %85 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 5
  %_121 = load i8, i8* %85, align 1
  %_120 = zext i8 %_121 to i32
  %86 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 5
  %_123 = load i8, i8* %86, align 1
  %_122 = zext i8 %_123 to i32
  %_119 = mul i32 %_120, %_122
  %stddevmag = add i32 %_108, %_119
  %_124 = call i16 @sqrt16(i32 %meanmag)
  br label %bb34

bb14:                                             ; preds = %bb12
  unreachable

bb15:                                             ; preds = %bb12
  %87 = bitcast { i16, i16 }* %_32 to %"core::option::Option<u16>::Some"*
  %88 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %87, i32 0, i32 1
  %val4 = load i16, i16* %88, align 2
  %_44 = icmp ult i16 %val4, 3
  %89 = call i1 @llvm.expect.i1(i1 %_44, i1 true)
  br i1 %89, label %bb16, label %panic5

bb16:                                             ; preds = %bb15
  %90 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %aWin, i16 0, i16 %val4
  %91 = bitcast %threeAxis_t_8* %90 to i8*
  %_41 = load i8, i8* %91, align 1
  %92 = bitcast %threeAxis_t_8* %mean to i8*
  %_45 = load i8, i8* %92, align 1
  %_40 = icmp ugt i8 %_41, %_45
  br i1 %_40, label %bb18, label %bb17

bb17:                                             ; preds = %bb16
  %93 = bitcast %threeAxis_t_8* %mean to i8*
  %_51 = load i8, i8* %93, align 1
  %_55 = icmp ult i16 %val4, 3
  %94 = call i1 @llvm.expect.i1(i1 %_55, i1 true)
  br i1 %94, label %bb20, label %panic7

bb18:                                             ; preds = %bb16
  %_49 = icmp ult i16 %val4, 3
  %95 = call i1 @llvm.expect.i1(i1 %_49, i1 true)
  br i1 %95, label %bb19, label %panic6

bb19:                                             ; preds = %bb18
  %96 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %aWin, i16 0, i16 %val4
  %97 = bitcast %threeAxis_t_8* %96 to i8*
  %_46 = load i8, i8* %97, align 1
  %98 = bitcast %threeAxis_t_8* %mean to i8*
  %_50 = load i8, i8* %98, align 1
  %99 = sub i8 %_46, %_50
  store i8 %99, i8* %_39, align 1
  br label %bb21

bb20:                                             ; preds = %bb17
  %100 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %aWin, i16 0, i16 %val4
  %101 = bitcast %threeAxis_t_8* %100 to i8*
  %_52 = load i8, i8* %101, align 1
  %102 = sub i8 %_51, %_52
  store i8 %102, i8* %_39, align 1
  br label %bb21

bb21:                                             ; preds = %bb20, %bb19
  %103 = bitcast %threeAxis_t_8* %stddev to i8*
  %104 = bitcast %threeAxis_t_8* %stddev to i8*
  %105 = load i8, i8* %104, align 1
  %106 = load i8, i8* %_39, align 1
  %107 = add i8 %105, %106
  store i8 %107, i8* %103, align 1
  %_61 = icmp ult i16 %val4, 3
  %108 = call i1 @llvm.expect.i1(i1 %_61, i1 true)
  br i1 %108, label %bb22, label %panic8

bb22:                                             ; preds = %bb21
  %109 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %aWin, i16 0, i16 %val4
  %110 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %109, i32 0, i32 3
  %_58 = load i8, i8* %110, align 1
  %111 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 3
  %_62 = load i8, i8* %111, align 1
  %_57 = icmp ugt i8 %_58, %_62
  br i1 %_57, label %bb24, label %bb23

bb23:                                             ; preds = %bb22
  %112 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 3
  %_68 = load i8, i8* %112, align 1
  %_72 = icmp ult i16 %val4, 3
  %113 = call i1 @llvm.expect.i1(i1 %_72, i1 true)
  br i1 %113, label %bb26, label %panic10

bb24:                                             ; preds = %bb22
  %_66 = icmp ult i16 %val4, 3
  %114 = call i1 @llvm.expect.i1(i1 %_66, i1 true)
  br i1 %114, label %bb25, label %panic9

bb25:                                             ; preds = %bb24
  %115 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %aWin, i16 0, i16 %val4
  %116 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %115, i32 0, i32 3
  %_63 = load i8, i8* %116, align 1
  %117 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 3
  %_67 = load i8, i8* %117, align 1
  %118 = sub i8 %_63, %_67
  store i8 %118, i8* %_56, align 1
  br label %bb27

bb26:                                             ; preds = %bb23
  %119 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %aWin, i16 0, i16 %val4
  %120 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %119, i32 0, i32 3
  %_69 = load i8, i8* %120, align 1
  %121 = sub i8 %_68, %_69
  store i8 %121, i8* %_56, align 1
  br label %bb27

bb27:                                             ; preds = %bb26, %bb25
  %122 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 3
  %123 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 3
  %124 = load i8, i8* %123, align 1
  %125 = load i8, i8* %_56, align 1
  %126 = add i8 %124, %125
  store i8 %126, i8* %122, align 1
  %_78 = icmp ult i16 %val4, 3
  %127 = call i1 @llvm.expect.i1(i1 %_78, i1 true)
  br i1 %127, label %bb28, label %panic11

bb28:                                             ; preds = %bb27
  %128 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %aWin, i16 0, i16 %val4
  %129 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %128, i32 0, i32 5
  %_75 = load i8, i8* %129, align 1
  %130 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 5
  %_79 = load i8, i8* %130, align 1
  %_74 = icmp ugt i8 %_75, %_79
  br i1 %_74, label %bb30, label %bb29

bb29:                                             ; preds = %bb28
  %131 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 5
  %_85 = load i8, i8* %131, align 1
  %_89 = icmp ult i16 %val4, 3
  %132 = call i1 @llvm.expect.i1(i1 %_89, i1 true)
  br i1 %132, label %bb32, label %panic13

bb30:                                             ; preds = %bb28
  %_83 = icmp ult i16 %val4, 3
  %133 = call i1 @llvm.expect.i1(i1 %_83, i1 true)
  br i1 %133, label %bb31, label %panic12

bb31:                                             ; preds = %bb30
  %134 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %aWin, i16 0, i16 %val4
  %135 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %134, i32 0, i32 5
  %_80 = load i8, i8* %135, align 1
  %136 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %mean, i32 0, i32 5
  %_84 = load i8, i8* %136, align 1
  %137 = sub i8 %_80, %_84
  store i8 %137, i8* %_73, align 1
  br label %bb33

bb32:                                             ; preds = %bb29
  %138 = getelementptr inbounds [3 x %threeAxis_t_8], [3 x %threeAxis_t_8]* %aWin, i16 0, i16 %val4
  %139 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %138, i32 0, i32 5
  %_86 = load i8, i8* %139, align 1
  %140 = sub i8 %_85, %_86
  store i8 %140, i8* %_73, align 1
  br label %bb33

bb33:                                             ; preds = %bb32, %bb31
  %141 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 5
  %142 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %stddev, i32 0, i32 5
  %143 = load i8, i8* %142, align 1
  %144 = load i8, i8* %_73, align 1
  %145 = add i8 %143, %144
  store i8 %145, i8* %141, align 1
  br label %bb11

bb34:                                             ; preds = %bb13
  %146 = bitcast { i16, i16 }* %features to i16*
  store i16 %_124, i16* %146, align 2
  %_126 = call i16 @sqrt16(i32 %stddevmag)
  br label %bb35

bb35:                                             ; preds = %bb34
  %147 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %features, i32 0, i32 1
  store i16 %_126, i16* %147, align 2
  ret void

panic:                                            ; preds = %bb6
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc94 to %"core::panic::Location"*))
  unreachable

panic2:                                           ; preds = %bb7
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc96 to %"core::panic::Location"*))
  unreachable

panic3:                                           ; preds = %bb8
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc98 to %"core::panic::Location"*))
  unreachable

panic5:                                           ; preds = %bb15
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val4, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc100 to %"core::panic::Location"*))
  unreachable

panic6:                                           ; preds = %bb18
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val4, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc102 to %"core::panic::Location"*))
  unreachable

panic7:                                           ; preds = %bb17
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val4, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc104 to %"core::panic::Location"*))
  unreachable

panic8:                                           ; preds = %bb21
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val4, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc106 to %"core::panic::Location"*))
  unreachable

panic9:                                           ; preds = %bb24
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val4, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc108 to %"core::panic::Location"*))
  unreachable

panic10:                                          ; preds = %bb23
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val4, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc110 to %"core::panic::Location"*))
  unreachable

panic11:                                          ; preds = %bb27
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val4, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc112 to %"core::panic::Location"*))
  unreachable

panic12:                                          ; preds = %bb30
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val4, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc114 to %"core::panic::Location"*))
  unreachable

panic13:                                          ; preds = %bb29
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val4, i16 3, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc116 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define internal zeroext i1 @_ZN8activity8classify17hf85326ac24ac80feE({ i16, i16 }* noalias readonly align 2 dereferenceable(4) %features, %model_t* noalias readonly align 2 dereferenceable(128) %model) unnamed_addr #0 {
start:
  %move_sd_err = alloca i32, align 2
  %move_mean_err = alloca i32, align 2
  %stat_sd_err = alloca i32, align 2
  %stat_mean_err = alloca i32, align 2
  %_10 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_7 = alloca { i16, i16 }, align 2
  %model_features = alloca { i16, i16 }, align 2
  %stat_less_error = alloca i16, align 2
  %move_less_error = alloca i16, align 2
  %class = alloca i8, align 1
  store i16 0, i16* %move_less_error, align 2
  store i16 0, i16* %stat_less_error, align 2
  %0 = bitcast { i16, i16 }* %model_features to i16*
  store i16 0, i16* %0, align 2
  %1 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %model_features, i32 0, i32 1
  store i16 0, i16* %1, align 2
  %2 = bitcast { i16, i16 }* %_7 to i16*
  store i16 0, i16* %2, align 2
  %3 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_7, i32 0, i32 1
  store i16 16, i16* %3, align 2
  %4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_7, i32 0, i32 0
  %5 = load i16, i16* %4, align 2
  %6 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_7, i32 0, i32 1
  %7 = load i16, i16* %6, align 2
  %8 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h820c98c80fab166dE"(i16 %5, i16 %7)
  %_6.0 = extractvalue { i16, i16 } %8, 0
  %_6.1 = extractvalue { i16, i16 } %8, 1
  br label %bb1

bb1:                                              ; preds = %start
  %9 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_6.0, i16* %9, align 2
  %10 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_6.1, i16* %10, align 2
  br label %bb2

bb2:                                              ; preds = %bb28, %bb1
  %11 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %11, { i16, i16 }* %_10, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %12 = bitcast { i16, i16 }* %_10 to i16*
  %_13 = load i16, i16* %12, align 2, !range !2
  switch i16 %_13, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  %_80 = load i16, i16* %move_less_error, align 2
  %_81 = load i16, i16* %stat_less_error, align 2
  %_79 = icmp sgt i16 %_80, %_81
  br i1 %_79, label %bb30, label %bb29

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %13 = bitcast { i16, i16 }* %_10 to %"core::option::Option<u16>::Some"*
  %14 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %13, i32 0, i32 1
  %val = load i16, i16* %14, align 2
  %_20 = icmp ult i16 %val, 16
  %15 = call i1 @llvm.expect.i1(i1 %_20, i1 true)
  br i1 %15, label %bb7, label %panic

bb7:                                              ; preds = %bb6
  %16 = bitcast %model_t* %model to [16 x { i16, i16 }]*
  %17 = getelementptr inbounds [16 x { i16, i16 }], [16 x { i16, i16 }]* %16, i16 0, i16 %val
  %18 = bitcast { i16, i16 }* %17 to i16*
  %_17 = load i16, i16* %18, align 2
  %19 = bitcast { i16, i16 }* %model_features to i16*
  store i16 %_17, i16* %19, align 2
  %_24 = icmp ult i16 %val, 16
  %20 = call i1 @llvm.expect.i1(i1 %_24, i1 true)
  br i1 %20, label %bb8, label %panic1

bb8:                                              ; preds = %bb7
  %21 = bitcast %model_t* %model to [16 x { i16, i16 }]*
  %22 = getelementptr inbounds [16 x { i16, i16 }], [16 x { i16, i16 }]* %21, i16 0, i16 %val
  %23 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %22, i32 0, i32 1
  %_21 = load i16, i16* %23, align 2
  %24 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %model_features, i32 0, i32 1
  store i16 %_21, i16* %24, align 2
  %25 = bitcast { i16, i16 }* %model_features to i16*
  %_27 = load i16, i16* %25, align 2
  %26 = bitcast { i16, i16 }* %features to i16*
  %_28 = load i16, i16* %26, align 2
  %_26 = icmp ugt i16 %_27, %_28
  br i1 %_26, label %bb10, label %bb9

bb9:                                              ; preds = %bb8
  %27 = bitcast { i16, i16 }* %features to i16*
  %_33 = load i16, i16* %27, align 2
  %28 = bitcast { i16, i16 }* %model_features to i16*
  %_34 = load i16, i16* %28, align 2
  %_32 = sub i16 %_33, %_34
  %29 = zext i16 %_32 to i32
  store i32 %29, i32* %stat_mean_err, align 2
  br label %bb11

bb10:                                             ; preds = %bb8
  %30 = bitcast { i16, i16 }* %model_features to i16*
  %_30 = load i16, i16* %30, align 2
  %31 = bitcast { i16, i16 }* %features to i16*
  %_31 = load i16, i16* %31, align 2
  %_29 = sub i16 %_30, %_31
  %32 = zext i16 %_29 to i32
  store i32 %32, i32* %stat_mean_err, align 2
  br label %bb11

bb11:                                             ; preds = %bb10, %bb9
  %33 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %model_features, i32 0, i32 1
  %_37 = load i16, i16* %33, align 2
  %34 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %features, i32 0, i32 1
  %_38 = load i16, i16* %34, align 2
  %_36 = icmp ugt i16 %_37, %_38
  br i1 %_36, label %bb13, label %bb12

bb12:                                             ; preds = %bb11
  %35 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %features, i32 0, i32 1
  %_43 = load i16, i16* %35, align 2
  %36 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %model_features, i32 0, i32 1
  %_44 = load i16, i16* %36, align 2
  %_42 = sub i16 %_43, %_44
  %37 = zext i16 %_42 to i32
  store i32 %37, i32* %stat_sd_err, align 2
  br label %bb14

bb13:                                             ; preds = %bb11
  %38 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %model_features, i32 0, i32 1
  %_40 = load i16, i16* %38, align 2
  %39 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %features, i32 0, i32 1
  %_41 = load i16, i16* %39, align 2
  %_39 = sub i16 %_40, %_41
  %40 = zext i16 %_39 to i32
  store i32 %40, i32* %stat_sd_err, align 2
  br label %bb14

bb14:                                             ; preds = %bb13, %bb12
  %_48 = icmp ult i16 %val, 16
  %41 = call i1 @llvm.expect.i1(i1 %_48, i1 true)
  br i1 %41, label %bb15, label %panic2

bb15:                                             ; preds = %bb14
  %42 = getelementptr inbounds %model_t, %model_t* %model, i32 0, i32 3
  %43 = getelementptr inbounds [16 x { i16, i16 }], [16 x { i16, i16 }]* %42, i16 0, i16 %val
  %44 = bitcast { i16, i16 }* %43 to i16*
  %_45 = load i16, i16* %44, align 2
  %45 = bitcast { i16, i16 }* %model_features to i16*
  store i16 %_45, i16* %45, align 2
  %_52 = icmp ult i16 %val, 16
  %46 = call i1 @llvm.expect.i1(i1 %_52, i1 true)
  br i1 %46, label %bb16, label %panic3

bb16:                                             ; preds = %bb15
  %47 = getelementptr inbounds %model_t, %model_t* %model, i32 0, i32 3
  %48 = getelementptr inbounds [16 x { i16, i16 }], [16 x { i16, i16 }]* %47, i16 0, i16 %val
  %49 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %48, i32 0, i32 1
  %_49 = load i16, i16* %49, align 2
  %50 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %model_features, i32 0, i32 1
  store i16 %_49, i16* %50, align 2
  %51 = bitcast { i16, i16 }* %model_features to i16*
  %_55 = load i16, i16* %51, align 2
  %52 = bitcast { i16, i16 }* %features to i16*
  %_56 = load i16, i16* %52, align 2
  %_54 = icmp ugt i16 %_55, %_56
  br i1 %_54, label %bb18, label %bb17

bb17:                                             ; preds = %bb16
  %53 = bitcast { i16, i16 }* %features to i16*
  %_61 = load i16, i16* %53, align 2
  %54 = bitcast { i16, i16 }* %model_features to i16*
  %_62 = load i16, i16* %54, align 2
  %_60 = sub i16 %_61, %_62
  %55 = zext i16 %_60 to i32
  store i32 %55, i32* %move_mean_err, align 2
  br label %bb19

bb18:                                             ; preds = %bb16
  %56 = bitcast { i16, i16 }* %model_features to i16*
  %_58 = load i16, i16* %56, align 2
  %57 = bitcast { i16, i16 }* %features to i16*
  %_59 = load i16, i16* %57, align 2
  %_57 = sub i16 %_58, %_59
  %58 = zext i16 %_57 to i32
  store i32 %58, i32* %move_mean_err, align 2
  br label %bb19

bb19:                                             ; preds = %bb18, %bb17
  %59 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %model_features, i32 0, i32 1
  %_65 = load i16, i16* %59, align 2
  %60 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %features, i32 0, i32 1
  %_66 = load i16, i16* %60, align 2
  %_64 = icmp ugt i16 %_65, %_66
  br i1 %_64, label %bb21, label %bb20

bb20:                                             ; preds = %bb19
  %61 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %features, i32 0, i32 1
  %_71 = load i16, i16* %61, align 2
  %62 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %model_features, i32 0, i32 1
  %_72 = load i16, i16* %62, align 2
  %_70 = sub i16 %_71, %_72
  %63 = zext i16 %_70 to i32
  store i32 %63, i32* %move_sd_err, align 2
  br label %bb22

bb21:                                             ; preds = %bb19
  %64 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %model_features, i32 0, i32 1
  %_68 = load i16, i16* %64, align 2
  %65 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %features, i32 0, i32 1
  %_69 = load i16, i16* %65, align 2
  %_67 = sub i16 %_68, %_69
  %66 = zext i16 %_67 to i32
  store i32 %66, i32* %move_sd_err, align 2
  br label %bb22

bb22:                                             ; preds = %bb21, %bb20
  %_74 = load i32, i32* %move_mean_err, align 2
  %_75 = load i32, i32* %stat_mean_err, align 2
  %_73 = icmp slt i32 %_74, %_75
  br i1 %_73, label %bb24, label %bb23

bb23:                                             ; preds = %bb22
  %67 = load i16, i16* %stat_less_error, align 2
  %68 = add i16 %67, 1
  store i16 %68, i16* %stat_less_error, align 2
  br label %bb25

bb24:                                             ; preds = %bb22
  %69 = load i16, i16* %move_less_error, align 2
  %70 = add i16 %69, 1
  store i16 %70, i16* %move_less_error, align 2
  br label %bb25

bb25:                                             ; preds = %bb24, %bb23
  %_77 = load i32, i32* %move_sd_err, align 2
  %_78 = load i32, i32* %stat_sd_err, align 2
  %_76 = icmp slt i32 %_77, %_78
  br i1 %_76, label %bb27, label %bb26

bb26:                                             ; preds = %bb25
  %71 = load i16, i16* %stat_less_error, align 2
  %72 = add i16 %71, 1
  store i16 %72, i16* %stat_less_error, align 2
  br label %bb28

bb27:                                             ; preds = %bb25
  %73 = load i16, i16* %move_less_error, align 2
  %74 = add i16 %73, 1
  store i16 %74, i16* %move_less_error, align 2
  br label %bb28

bb28:                                             ; preds = %bb27, %bb26
  br label %bb2

bb29:                                             ; preds = %bb4
  store i8 0, i8* %class, align 1
  br label %bb31

bb30:                                             ; preds = %bb4
  store i8 1, i8* %class, align 1
  br label %bb31

bb31:                                             ; preds = %bb30, %bb29
  %75 = load i8, i8* %class, align 1, !range !1
  %76 = trunc i8 %75 to i1
  ret i1 %76

panic:                                            ; preds = %bb6
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 16, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc118 to %"core::panic::Location"*))
  unreachable

panic1:                                           ; preds = %bb7
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 16, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc120 to %"core::panic::Location"*))
  unreachable

panic2:                                           ; preds = %bb14
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 16, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc122 to %"core::panic::Location"*))
  unreachable

panic3:                                           ; preds = %bb15
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 16, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc124 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define internal void @_ZN8activity12record_stats17h6d68c2daa7082338E(%stats_t* align 2 dereferenceable(6) %stats, i1 zeroext) unnamed_addr #0 {
start:
  %1 = alloca {}, align 1
  %class = alloca i8, align 1
  %2 = zext i1 %0 to i8
  store i8 %2, i8* %class, align 1
  %3 = bitcast %stats_t* %stats to i16*
  %4 = bitcast %stats_t* %stats to i16*
  %5 = load i16, i16* %4, align 2
  %6 = add i16 %5, 1
  store i16 %6, i16* %3, align 2
  %7 = load i8, i8* %class, align 1, !range !1
  %8 = trunc i8 %7 to i1
  %_3 = zext i1 %8 to i16
  switch i16 %_3, label %bb2 [
    i16 0, label %bb1
    i16 1, label %bb3
  ]

bb1:                                              ; preds = %start
  %9 = getelementptr inbounds %stats_t, %stats_t* %stats, i32 0, i32 5
  %10 = getelementptr inbounds %stats_t, %stats_t* %stats, i32 0, i32 5
  %11 = load i16, i16* %10, align 2
  %12 = add i16 %11, 1
  store i16 %12, i16* %9, align 2
  br label %bb4

bb2:                                              ; preds = %start
  unreachable

bb3:                                              ; preds = %start
  %13 = getelementptr inbounds %stats_t, %stats_t* %stats, i32 0, i32 3
  %14 = getelementptr inbounds %stats_t, %stats_t* %stats, i32 0, i32 3
  %15 = load i16, i16* %14, align 2
  %16 = add i16 %15, 1
  store i16 %16, i16* %13, align 2
  br label %bb4

bb4:                                              ; preds = %bb3, %bb1
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
declare void @end_atomic() unnamed_addr #0

; Function Attrs: nounwind readnone
declare i1 @llvm.expect.i1(i1, i1) #3

; Function Attrs: nounwind
declare i16 @sqrt16(i32) unnamed_addr #0

; Function Attrs: nounwind
define internal void @_ZN8activity12accel_sample17habeed4fee8dc460dE(%threeAxis_t_8* noalias nocapture sret dereferenceable(3) %result, i16* align 2 dereferenceable(2) %nv_seed) unnamed_addr #0 {
start:
  %seed = alloca i16, align 2
  %0 = load i16, i16* %nv_seed, align 2
  store i16 %0, i16* %seed, align 2
  %_5 = load i16, i16* %seed, align 2
  %_4 = mul i16 %_5, 17
  call void @atomic_start()
  %xs = call i8 @readSensor(i16 %_4)
  br label %bb1

bb1:                                              ; preds = %start
  br label %bb2

bb2:                                              ; preds = %bb1
  %_11 = load i16, i16* %seed, align 2
  %_10 = mul i16 %_11, 17
  %_9 = mul i16 %_10, 17
  %ys = call i8 @readSensor(i16 %_9)
  br label %bb3

bb3:                                              ; preds = %bb2
  br label %bb4

bb4:                                              ; preds = %bb3
  %_18 = load i16, i16* %seed, align 2
  %_17 = mul i16 %_18, 17
  %_16 = mul i16 %_17, 17
  %_15 = mul i16 %_16, 17
  %zs = call i8 @readSensor(i16 %_15)
  call void @atomic_end()
  br label %bb5

bb5:                                              ; preds = %bb4
  br label %bb6

bb6:                                              ; preds = %bb5
  %1 = bitcast %threeAxis_t_8* %result to i8*
  store i8 %xs, i8* %1, align 1
  %2 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %result, i32 0, i32 3
  store i8 %ys, i8* %2, align 1
  %3 = getelementptr inbounds %threeAxis_t_8, %threeAxis_t_8* %result, i32 0, i32 5
  store i8 %zs, i8* %3, align 1
  %_24 = load i16, i16* %seed, align 2
  %4 = add i16 %_24, 1
  store i16 %4, i16* %seed, align 2
  %_25 = load i16, i16* %seed, align 2
  store i16 %_25, i16* %nv_seed, align 2
  ret void
}

; Function Attrs: nounwind
declare void @start_atomic() unnamed_addr #0

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

; Function Attrs: inlinehint nounwind
define internal zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$u16$GT$2lt17hb538d7d011c40015E"(i16* noalias readonly align 2 dereferenceable(2) %self, i16* noalias readonly align 2 dereferenceable(2) %other) unnamed_addr #2 {
start:
  %_3 = load i16, i16* %self, align 2
  %_4 = load i16, i16* %other, align 2
  %0 = icmp ult i16 %_3, %_4
  ret i1 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$u16$GT$5clone17h05f23cea223ff2c3E"(i16* noalias readonly align 2 dereferenceable(2) %self) unnamed_addr #2 {
start:
  %0 = load i16, i16* %self, align 2
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN47_$LT$u16$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h96e2de61b28cc265E"(i16 %start1, i16 %n) unnamed_addr #2 {
start:
  %0 = call i16 @"_ZN4core3num21_$LT$impl$u20$u16$GT$13unchecked_add17h4353a595b8c3d9c7E"(i16 %start1, i16 %n)
  br label %bb1

bb1:                                              ; preds = %start
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @_ZN4core3mem7replace17h84e8cec08f3f1630E(i16* align 2 dereferenceable(2) %dest, i16) unnamed_addr #2 {
start:
  %src = alloca i16, align 2
  store i16 %0, i16* %src, align 2
  call void @_ZN4core3mem4swap17ha511f9dce8b05d0cE(i16* align 2 dereferenceable(2) %dest, i16* align 2 dereferenceable(2) %src)
  br label %bb1

bb1:                                              ; preds = %start
  %1 = load i16, i16* %src, align 2
  ret i16 %1
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3mem4swap17ha511f9dce8b05d0cE(i16* align 2 dereferenceable(2) %x, i16* align 2 dereferenceable(2) %y) unnamed_addr #2 {
start:
  call void @_ZN4core3ptr23swap_nonoverlapping_one17h4d6bb216e0404ce6E(i16* %x, i16* %y)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr23swap_nonoverlapping_one17h4d6bb216e0404ce6E(i16* %x, i16* %y) unnamed_addr #2 {
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
  call void @_ZN4core3ptr19swap_nonoverlapping17h290f388ae5d70dffE(i16* %x, i16* %y, i16 1)
  br label %bb7

bb3:                                              ; preds = %bb1
  %z = call i16 @_ZN4core3ptr4read17h6286217333d05028E(i16* %x)
  br label %bb4

bb4:                                              ; preds = %bb3
  call void @_ZN4core10intrinsics19copy_nonoverlapping17h927455cddaf3b286E(i16* %y, i16* %x, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  call void @_ZN4core3ptr5write17hdf3c86c44f306d0eE(i16* %y, i16 %z)
  br label %bb6

bb6:                                              ; preds = %bb5
  br label %bb8

bb7:                                              ; preds = %bb2
  br label %bb8

bb8:                                              ; preds = %bb7, %bb6
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr19swap_nonoverlapping17h290f388ae5d70dffE(i16* %x, i16* %y, i16 %count) unnamed_addr #2 {
start:
  %0 = alloca i16, align 2
  %x1 = bitcast i16* %x to i8*
  %y2 = bitcast i16* %y to i8*
  store i16 2, i16* %0, align 2
  %1 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %len = mul i16 %1, %count
  call void @_ZN4core3ptr25swap_nonoverlapping_bytes17h2d70ae4f459f10e3E(i8* %x1, i8* %y2, i16 %len)
  br label %bb2

bb2:                                              ; preds = %bb1
  ret void
}

; Function Attrs: inlinehint nounwind
define internal i16 @_ZN4core3ptr4read17h6286217333d05028E(i16* %src) unnamed_addr #2 {
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
  call void @_ZN4core10intrinsics19copy_nonoverlapping17h927455cddaf3b286E(i16* %src, i16* %tmp, i16 1)
  br label %bb3

bb3:                                              ; preds = %bb2
  %_7 = load i16, i16* %tmp, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  ret i16 %_7
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core10intrinsics19copy_nonoverlapping17h927455cddaf3b286E(i16* %src, i16* %dst, i16 %count) unnamed_addr #2 {
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
define internal void @_ZN4core3ptr5write17hdf3c86c44f306d0eE(i16* %dst, i16 %src) unnamed_addr #2 {
start:
  %0 = alloca {}, align 1
  store i16 %src, i16* %dst, align 2
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr25swap_nonoverlapping_bytes17h2d70ae4f459f10e3E(i8* %x, i8* %y, i16 %len) unnamed_addr #2 {
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
define internal i16 @"_ZN4core3num21_$LT$impl$u20$u16$GT$13unchecked_add17h4353a595b8c3d9c7E"(i16 %self, i16 %rhs) unnamed_addr #2 {
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
define internal void @_ZN8activity13warmup_sensor17he7878671afcb6869E(i16* align 2 dereferenceable(2) %seed) unnamed_addr #0 {
start:
  %_6 = alloca %threeAxis_t_8, align 1
  %_sample = alloca %threeAxis_t_8, align 1
  %discardedSamplesCount = alloca i16, align 2
  store i16 0, i16* %discardedSamplesCount, align 2
  br label %bb1

bb1:                                              ; preds = %bb4, %start
  %_5 = load i16, i16* %discardedSamplesCount, align 2
  %_4 = icmp ult i16 %_5, 3
  br i1 %_4, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  ret void

bb3:                                              ; preds = %bb1
  call void @_ZN8activity12accel_sample17habeed4fee8dc460dE(%threeAxis_t_8* noalias nocapture sret dereferenceable(3) %_6, i16* align 2 dereferenceable(2) %seed)
  br label %bb4

bb4:                                              ; preds = %bb3
  %0 = bitcast %threeAxis_t_8* %_sample to i8*
  %1 = bitcast %threeAxis_t_8* %_6 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i16(i8* align 1 %0, i8* align 1 %1, i16 3, i1 false)
  %2 = load i16, i16* %discardedSamplesCount, align 2
  %3 = add i16 %2, 1
  store i16 %3, i16* %discardedSamplesCount, align 2
  br label %bb1
}

; Function Attrs: nounwind
define internal void @_ZN8activity11count_error17h41ffa6e48cfced15E(i16* noalias readonly align 2 dereferenceable(2) %count) unnamed_addr #0 {
start:
  %_3 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [43 x i8] }>* @alloc11 to [0 x i8]*), i16 43)
  br label %bb1

bb1:                                              ; preds = %start
  %_8 = load i16, i16* %count, align 2
  %_7 = zext i16 %_8 to i32
  call void (i8*, ...) @printf(i8* %_3, i32 %_7)
  br label %bb2

bb2:                                              ; preds = %bb1
  ret void
}

; Function Attrs: nounwind
define internal void @_ZN8activity16end_of_benchmark17he2a20200e78592b7E() unnamed_addr #0 {
start:
  ret void
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
  %_11 = load [0 x { i8*, i8* }]*, [0 x { i8*, i8* }]** bitcast (<{ i8*, [0 x i8] }>* @anon.b7bafff2f871b915b57b152a19c6233b.10 to [0 x { i8*, i8* }]**), align 2, !nonnull !0
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
  %_22 = load [2 x { [0 x i8]*, i16 }]*, [2 x { [0 x i8]*, i16 }]** bitcast (<{ i8*, [0 x i8] }>* @anon.b7bafff2f871b915b57b152a19c6233b.18 to [2 x { [0 x i8]*, i16 }]**), align 2, !nonnull !0
  %_4.0 = bitcast [2 x { [0 x i8]*, i16 }]* %_22 to [0 x { [0 x i8]*, i16 }]*
  %3 = bitcast { i16*, i16* }* %_11 to i16**
  store i16* %len, i16** %3, align 2
  %4 = getelementptr inbounds { i16*, i16* }, { i16*, i16* }* %_11, i32 0, i32 1
  store i16* %index, i16** %4, align 2
  %5 = bitcast { i16*, i16* }* %_11 to i16**
  %arg0 = load i16*, i16** %5, align 2, !nonnull !0
  %6 = getelementptr inbounds { i16*, i16* }, { i16*, i16* }* %_11, i32 0, i32 1
  %arg1 = load i16*, i16** %6, align 2, !nonnull !0
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
  %_3 = load i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)*, i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)** %1, align 2, !nonnull !0
  br label %bb1

bb1:                                              ; preds = %start
  %4 = bitcast %"fmt::USIZE_MARKER::{{closure}}"** %0 to i16**
  store i16* %x, i16** %4, align 2
  %_5 = load %"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::USIZE_MARKER::{{closure}}"** %0, align 2, !nonnull !0
  br label %bb2

bb2:                                              ; preds = %bb1
  %5 = bitcast { i8*, i8* }* %2 to %"fmt::USIZE_MARKER::{{closure}}"**
  store %"fmt::USIZE_MARKER::{{closure}}"* %_5, %"fmt::USIZE_MARKER::{{closure}}"** %5, align 2
  %6 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 1
  %7 = bitcast i8** %6 to i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)**
  store i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)* %_3, i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)** %7, align 2
  %8 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 0
  %9 = load i8*, i8** %8, align 2, !nonnull !0
  %10 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 1
  %11 = load i8*, i8** %10, align 2, !nonnull !0
  %12 = insertvalue { i8*, i8* } undef, i8* %9, 0
  %13 = insertvalue { i8*, i8* } %12, i8* %11, 1
  ret { i8*, i8* } %13
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3fmt9Arguments6new_v117hcb862d1c1c522ce9E(%"fmt::Arguments"* noalias nocapture sret dereferenceable(12), [0 x { [0 x i8]*, i16 }]* noalias nonnull readonly align 2 %pieces.0, i16 %pieces.1, [0 x { i8*, i8* }]* noalias nonnull readonly align 2 %args.0, i16 %args.1) unnamed_addr #2 {
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
  %2 = load %"core::panic::Location"*, %"core::panic::Location"** %1, align 2, !nonnull !0
  br label %bb1

bb1:                                              ; preds = %start
  ret %"core::panic::Location"* %2
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core5panic9PanicInfo20internal_constructor17h3f579eac134a0316E(%"panic::PanicInfo"* noalias nocapture sret dereferenceable(8), i16* noalias readonly align 2 dereferenceable_or_null(12) %message, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) %location) unnamed_addr #2 {
start:
  %_8 = load %"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::USIZE_MARKER::{{closure}}"** bitcast (<{ i8*, [0 x i8] }>* @anon.b7bafff2f871b915b57b152a19c6233b.10 to %"fmt::USIZE_MARKER::{{closure}}"**), align 2, !nonnull !0
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
declare void @llvm.memset.p0i8.i16(i8* nocapture writeonly, i8, i16, i1 immarg) #1

; Function Attrs: inlinehint nounwind
define i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 %self.0, i16 %self.1) unnamed_addr #2 {
start:
  %0 = bitcast [0 x i8]* %self.0 to i8*
  ret i8* %0
}

; Function Attrs: inlinehint nounwind
define i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$6offset17h2e1a7811e3081d04E"(i8* %self, i16 %count) unnamed_addr #2 {
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
define void @_ZN4core10intrinsics19copy_nonoverlapping17hae661117b796ce7aE(i8* %src, i8* %dst, i16 %count) unnamed_addr #2 {
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
define { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17ha67c2acd5b97c935E"({ i16, i16 }* align 2 dereferenceable(4) %self) unnamed_addr #2 {
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
  %6 = load i16, i16* %5, align 2, !range !2
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %0, i32 0, i32 1
  %8 = load i16, i16* %7, align 2
  %9 = insertvalue { i16, i16 } undef, i16 %6, 0
  %10 = insertvalue { i16, i16 } %9, i16 %8, 1
  ret { i16, i16 } %10
}

; Function Attrs: inlinehint nounwind
define internal zeroext i1 @"_ZN4core3cmp5impls57_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$usize$GT$2lt17h0750a5d1d0a2d0e5E"(i16* noalias readonly align 2 dereferenceable(2) %self, i16* noalias readonly align 2 dereferenceable(2) %other) unnamed_addr #2 {
start:
  %_3 = load i16, i16* %self, align 2
  %_4 = load i16, i16* %other, align 2
  %0 = icmp ult i16 %_3, %_4
  ret i1 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN4core5clone5impls54_$LT$impl$u20$core..clone..Clone$u20$for$u20$usize$GT$5clone17h35de8cec8ce1ca85E"(i16* noalias readonly align 2 dereferenceable(2) %self) unnamed_addr #2 {
start:
  %0 = load i16, i16* %self, align 2
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN49_$LT$usize$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17h967f7533a954ac6cE"(i16 %start1, i16 %n) unnamed_addr #2 {
start:
  %0 = call i16 @"_ZN4core3num23_$LT$impl$u20$usize$GT$13unchecked_add17h985a7d3f93b73fe5E"(i16 %start1, i16 %n)
  br label %bb1

bb1:                                              ; preds = %start
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define i16 @_ZN4core3mem7replace17h2a3746616bd5c532E(i16* align 2 dereferenceable(2) %dest, i16) unnamed_addr #2 {
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
define void @_ZN4core3mem4swap17h5780128ab4410f1bE(i16* align 2 dereferenceable(2) %x, i16* align 2 dereferenceable(2) %y) unnamed_addr #2 {
start:
  call void @_ZN4core3ptr23swap_nonoverlapping_one17h794dcea844776eb6E(i16* %x, i16* %y)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define void @_ZN4core3ptr23swap_nonoverlapping_one17h794dcea844776eb6E(i16* %x, i16* %y) unnamed_addr #2 {
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
define void @_ZN4core3ptr19swap_nonoverlapping17hce1af3a4ad5262f2E(i16* %x, i16* %y, i16 %count) unnamed_addr #2 {
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
define i16 @_ZN4core3ptr4read17ha381715c75e05d0dE(i16* %src) unnamed_addr #2 {
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
define void @_ZN4core10intrinsics19copy_nonoverlapping17h9dce94ffe69dd9feE(i16* %src, i16* %dst, i16 %count) unnamed_addr #2 {
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
define void @_ZN4core3ptr5write17h2798392a937a2f1cE(i16* %dst, i16 %src) unnamed_addr #2 {
start:
  %0 = alloca {}, align 1
  store i16 %src, i16* %dst, align 2
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr25swap_nonoverlapping_bytes17h9e5ff4c1ae9cd9eaE(i8* %x, i8* %y, i16 %len) unnamed_addr #2 {
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
define i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$3add17h02212dc06e61a034E"(i8* %self, i16 %count) unnamed_addr #2 {
start:
  %0 = call i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$6offset17h2e1a7811e3081d04E"(i8* %self, i16 %count)
  br label %bb1

bb1:                                              ; preds = %start
  ret i8* %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN4core3num23_$LT$impl$u20$usize$GT$13unchecked_add17h985a7d3f93b73fe5E"(i16 %self, i16 %rhs) unnamed_addr #2 {
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
  call void asm sideeffect "dint { nop", "~{memory}"() #5, !srcloc !4
  br label %bb1

bb1:                                              ; preds = %start
  br label %bb2

bb2:                                              ; preds = %bb3, %bb1
  call void asm sideeffect "", "~{memory}"() #5, !srcloc !5
  br label %bb3

bb3:                                              ; preds = %bb2
  br label %bb2
}

attributes #0 = { nounwind "target-cpu"="generic" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { inlinehint nounwind "target-cpu"="generic" }
attributes #3 = { nounwind readnone }
attributes #4 = { cold noinline noreturn nounwind "target-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { nounwind readnone speculatable }
attributes #7 = { cold noreturn nounwind }
attributes #8 = { noreturn nounwind "target-cpu"="generic" }

!0 = !{}
!1 = !{i8 0, i8 2}
!2 = !{i16 0, i16 2}
!3 = !{i32 0, i32 1114112}
!4 = !{i32 2974937}
!5 = !{i32 2974670}
