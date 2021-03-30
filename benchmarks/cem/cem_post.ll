; ModuleID = 'cem_post.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:16:16-i32:16-i64:16-f32:16-f64:16-a:8-n8:16-S16"
target triple = "msp430-none-unknown-elf"

%"fmt::USIZE_MARKER::{{closure}}" = type {}
%Node = type { [0 x i16], i16, [0 x i16], i16, [0 x i16], i16, [0 x i16] }
%"core::option::Option<u16>::Some" = type { [1 x i16], i16, [0 x i16] }
%"core::panic::Location" = type { [0 x i16], { [0 x i8]*, i16 }, [0 x i16], i32, [0 x i16], i32, [0 x i16] }
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
@_ZN8cem_rust3app5LOGNV17h749ff42144808487E = internal global <{ [128 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN8cem_rust3app6DICTNV17hfbe4b2fb8e190ca7E = internal global <{ [3072 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN8cem_rust3app12NODE_COUNTNV17h182529e7d7a22582E = internal global <{ [2 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN8cem_rust3app17LOG_SAMPLECOUNTNV17h8df88dc6ce8f7280E = internal global <{ [2 x i8] }> zeroinitializer, section ".nv_vars", align 2
@_ZN8cem_rust3app11LOG_COUNTNV17heb176871f3cfee12E = internal global <{ [2 x i8] }> zeroinitializer, section ".nv_vars", align 2
@alloc6 = private unnamed_addr constant <{ [29 x i8] }> <{ [29 x i8] c"rate: samples/block: %l/%l\0D\0A\00" }>, align 1
@alloc8 = private unnamed_addr constant <{ [3 x i8] }> <{ [3 x i8] c"\0D\0A\00" }>, align 1
@alloc7 = private unnamed_addr constant <{ [6 x i8] }> <{ [6 x i8] c"%04x \00" }>, align 1
@alloc9 = private unnamed_addr constant <{ [26 x i8] }> <{ [26 x i8] c"print log exit tripped!\0D\0A\00" }>, align 1
@alloc43 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00E\00\00\00%\00\00\00" }>, align 2
@alloc68 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"src/lib.rs" }>, align 1
@alloc10 = private unnamed_addr constant <{ [23 x i8] }> <{ [23 x i8] c"add node: table full\0D\0A\00" }>, align 1
@alloc55 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\A3\00\00\00\17\00\00\00" }>, align 2
@alloc57 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\B1\00\00\00\18\00\00\00" }>, align 2
@alloc59 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\B6\00\00\00\05\00\00\00" }>, align 2
@alloc61 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\B9\00\00\00\05\00\00\00" }>, align 2
@alloc63 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\BB\00\00\00\05\00\00\00" }>, align 2
@alloc65 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\BC\00\00\00\05\00\00\00" }>, align 2
@alloc67 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\BD\00\00\00\05\00\00\00" }>, align 2
@alloc69 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\C4\00\00\00\05\00\00\00" }>, align 2
@alloc51 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00w\00\00\00\1E\00\00\00" }>, align 2
@alloc53 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00\83\00\00\00#\00\00\00" }>, align 2
@atomic_depth = external global i16
@alloc45 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00h\00\00\00\05\00\00\00" }>, align 2
@alloc47 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00i\00\00\00\05\00\00\00" }>, align 2
@alloc49 = private unnamed_addr constant <{ i8*, [10 x i8] }> <{ i8* getelementptr inbounds (<{ [10 x i8] }>, <{ [10 x i8] }>* @alloc68, i32 0, i32 0, i32 0), [10 x i8] c"\0A\00j\00\00\00\05\00\00\00" }>, align 2
@anon.b7bafff2f871b915b57b152a19c6233b.18 = private unnamed_addr constant <{ i8*, [0 x i8] }> <{ i8* bitcast (<{ i8*, [2 x i8], i8*, [2 x i8] }>* @alloc16077 to i8*), [0 x i8] zeroinitializer }>, align 2
@anon.b7bafff2f871b915b57b152a19c6233b.10 = private unnamed_addr constant <{ i8*, [0 x i8] }> <{ i8* getelementptr inbounds (<{ [0 x i8] }>, <{ [0 x i8] }>* @alloc18891, i32 0, i32 0, i32 0), [0 x i8] zeroinitializer }>, align 2
@vtable.c = private unnamed_addr constant { void (%"fmt::USIZE_MARKER::{{closure}}"*)*, i16, i16, i64 (%"fmt::USIZE_MARKER::{{closure}}"*)* } { void (%"fmt::USIZE_MARKER::{{closure}}"*)* undef, i16 0, i16 1, i64 (%"fmt::USIZE_MARKER::{{closure}}"*)* undef }, align 2
@alloc18891 = private unnamed_addr constant <{ [0 x i8] }> zeroinitializer, align 2
@alloc16077 = private unnamed_addr constant <{ i8*, [2 x i8], i8*, [2 x i8] }> <{ i8* getelementptr inbounds (<{ [32 x i8] }>, <{ [32 x i8] }>* @alloc16075, i32 0, i32 0, i32 0), [2 x i8] c" \00", i8* getelementptr inbounds (<{ [18 x i8] }>, <{ [18 x i8] }>* @alloc16076, i32 0, i32 0, i32 0), [2 x i8] c"\12\00" }>, align 2
@alloc16075 = private unnamed_addr constant <{ [32 x i8] }> <{ [32 x i8] c"index out of bounds: the len is " }>, align 1
@alloc16076 = private unnamed_addr constant <{ [18 x i8] }> <{ [18 x i8] c" but the index is " }>, align 1

; Function Attrs: nounwind
define internal i16 @_ZN8cem_rust14acquire_sample17h6d68832a463879d8E(i16 %prev_sample) unnamed_addr #0 {
start:
  %_2 = add i16 %prev_sample, 1
  %sample = and i16 %_2, 3
  ret i16 %sample
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
  %_77 = alloca i16, align 2
  %_71 = alloca i16, align 2
  %_60 = alloca i16, align 2
  %letter_shift = alloca i16, align 2
  %letter_idx_tmp = alloca i16, align 2
  %child = alloca i16, align 2
  %prev_sample = alloca i16, align 2
  %parent = alloca i16, align 2
  %letter_idx = alloca i16, align 2
  %letter = alloca i16, align 2
  %_25 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_22 = alloca { i16, i16 }, align 2
  %node_count = alloca i16*, align 2
  %dict = alloca [512 x %Node]*, align 2
  %log = alloca [64 x i16]*, align 2
  store [64 x i16]* bitcast (<{ [128 x i8] }>* @_ZN8cem_rust3app5LOGNV17h749ff42144808487E to [64 x i16]*), [64 x i16]** %log, align 2
  store [512 x %Node]* bitcast (<{ [3072 x i8] }>* @_ZN8cem_rust3app6DICTNV17hfbe4b2fb8e190ca7E to [512 x %Node]*), [512 x %Node]** %dict, align 2
  store i16* bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app12NODE_COUNTNV17h182529e7d7a22582E to i16*), i16** %node_count, align 2
  br label %bb1

bb1:                                              ; preds = %bb41, %start
  %0 = bitcast { i16, i16 }* %_22 to i16*
  store i16 0, i16* %0, align 2
  %1 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_22, i32 0, i32 1
  store i16 5, i16* %1, align 2
  %2 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_22, i32 0, i32 0
  %3 = load i16, i16* %2, align 2
  %4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_22, i32 0, i32 1
  %5 = load i16, i16* %4, align 2
  %6 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h3ff2602e08c1d7d7E"(i16 %3, i16 %5)
  %_21.0 = extractvalue { i16, i16 } %6, 0
  %_21.1 = extractvalue { i16, i16 } %6, 1
  br label %bb2

bb2:                                              ; preds = %bb1
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_21.0, i16* %7, align 2
  %8 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_21.1, i16* %8, align 2
  br label %bb3

bb3:                                              ; preds = %bb39, %bb2
  %9 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h1db0d967d62d2379E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %9, { i16, i16 }* %_25, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  %10 = bitcast { i16, i16 }* %_25 to i16*
  %_28 = load i16, i16* %10, align 2, !range !0
  switch i16 %_28, label %bb6 [
    i16 0, label %bb5
    i16 1, label %bb7
  ]

bb5:                                              ; preds = %bb4
  call void @gpioTwiddle()
  br label %bb40

bb6:                                              ; preds = %bb4
  unreachable

bb7:                                              ; preds = %bb4
  %11 = bitcast { i16, i16 }* %_25 to %"core::option::Option<u16>::Some"*
  %12 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %11, i32 0, i32 1
  %val = load i16, i16* %12, align 2
  %_33 = load [512 x %Node]*, [512 x %Node]** %dict, align 2, !nonnull !1
  %_35 = load i16*, i16** %node_count, align 2, !nonnull !1
  call void @_ZN8cem_rust9init_dict17h3b9a79dd4c8352dcE([512 x %Node]* align 2 dereferenceable(3072) %_33, i16* align 2 dereferenceable(2) %_35)
  br label %bb8

bb8:                                              ; preds = %bb7
  store i16 0, i16* %letter, align 2
  store i16 0, i16* %letter_idx, align 2
  store i16 0, i16* %parent, align 2
  store i16 0, i16* %prev_sample, align 2
  store i16 1, i16* bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app17LOG_SAMPLECOUNTNV17h8df88dc6ce8f7280E to i16*), align 2
  store i16 0, i16* bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app11LOG_COUNTNV17heb176871f3cfee12E to i16*), align 2
  br label %bb9

bb9:                                              ; preds = %bb37, %bb8
  %_43 = load i16, i16* %letter, align 2
  store i16 %_43, i16* %child, align 2
  %_45 = load i16, i16* %letter_idx, align 2
  %_44 = icmp eq i16 %_45, 0
  br i1 %_44, label %bb11, label %bb10

bb10:                                             ; preds = %bb9
  br label %bb14

bb11:                                             ; preds = %bb9
  %_47 = load i16, i16* %prev_sample, align 2
  call void @atomic_start()
  %sample = call i16 @_ZN8cem_rust14acquire_sample17h6d68832a463879d8E(i16 %_47)
  br label %bb12

bb12:                                             ; preds = %bb11
  br label %bb13

bb13:                                             ; preds = %bb12
  store i16 %sample, i16* %prev_sample, align 2
  call void @atomic_end()
  br label %bb14

bb14:                                             ; preds = %bb13, %bb10
  %13 = load i16, i16* %letter_idx, align 2
  %14 = add i16 %13, 1
  store i16 %14, i16* %letter_idx, align 2
  %_52 = load i16, i16* %letter_idx, align 2
  %_51 = icmp eq i16 %_52, 2
  br i1 %_51, label %bb16, label %bb15

bb15:                                             ; preds = %bb14
  br label %bb17

bb16:                                             ; preds = %bb14
  store i16 0, i16* %letter_idx, align 2
  br label %bb17

bb17:                                             ; preds = %bb16, %bb15
  %_55 = load i16, i16* %letter_idx, align 2
  %_54 = icmp eq i16 %_55, 0
  br i1 %_54, label %bb19, label %bb18

bb18:                                             ; preds = %bb17
  %_56 = load i16, i16* %letter_idx, align 2
  %15 = sub i16 %_56, 1
  store i16 %15, i16* %letter_idx_tmp, align 2
  br label %bb20

bb19:                                             ; preds = %bb17
  store i16 2, i16* %letter_idx_tmp, align 2
  br label %bb20

bb20:                                             ; preds = %bb19, %bb18
  %_59 = load i16, i16* %letter_idx_tmp, align 2
  %16 = mul i16 8, %_59
  store i16 %16, i16* %letter_shift, align 2
  %_62 = load i16, i16* %letter_shift, align 2
  %_61 = icmp eq i16 %_62, 16
  br i1 %_61, label %bb22, label %bb21

bb21:                                             ; preds = %bb20
  store i16 0, i16* %_60, align 2
  br label %bb23

bb22:                                             ; preds = %bb20
  store i16 0, i16* %_60, align 2
  br label %bb23

bb23:                                             ; preds = %bb22, %bb21
  %17 = load i16, i16* %_60, align 2
  store i16 %17, i16* %letter, align 2
  %18 = load i16, i16* bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app17LOG_SAMPLECOUNTNV17h8df88dc6ce8f7280E to i16*), align 2
  %19 = add i16 %18, 1
  store i16 %19, i16* bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app17LOG_SAMPLECOUNTNV17h8df88dc6ce8f7280E to i16*), align 2
  %_64 = load i16, i16* %child, align 2
  store i16 %_64, i16* %parent, align 2
  %_66 = load i16, i16* %letter, align 2
  %_67 = load i16, i16* %parent, align 2
  %_68 = load [512 x %Node]*, [512 x %Node]** %dict, align 2, !nonnull !1
  %_65 = call i16 @_ZN8cem_rust10find_child17h505c0f8555289c54E(i16 %_66, i16 %_67, [512 x %Node]* noalias readonly align 2 dereferenceable(3072) %_68)
  br label %bb24

bb24:                                             ; preds = %bb23
  store i16 %_65, i16* %child, align 2
  br label %bb25

bb25:                                             ; preds = %bb34, %bb24
  %_70 = load i16, i16* %child, align 2
  %_69 = icmp ne i16 %_70, 0
  br i1 %_69, label %bb27, label %bb26

bb26:                                             ; preds = %bb25
  %_87 = load i16, i16* %parent, align 2
  %_88 = load [64 x i16]*, [64 x i16]** %log, align 2, !nonnull !1
  call void @_ZN8cem_rust17append_compressed17h235b14694022953dE(i16 %_87, [64 x i16]* align 2 dereferenceable(128) %_88, i16* align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app11LOG_COUNTNV17heb176871f3cfee12E to i16*))
  br label %bb35

bb27:                                             ; preds = %bb25
  %_73 = load i16, i16* %letter_idx, align 2
  %_72 = icmp eq i16 %_73, 0
  br i1 %_72, label %bb29, label %bb28

bb28:                                             ; preds = %bb27
  %_74 = load i16, i16* %letter_idx, align 2
  %20 = sub i16 %_74, 1
  store i16 %20, i16* %_71, align 2
  br label %bb30

bb29:                                             ; preds = %bb27
  store i16 2, i16* %_71, align 2
  br label %bb30

bb30:                                             ; preds = %bb29, %bb28
  %21 = load i16, i16* %_71, align 2
  store i16 %21, i16* %letter_idx_tmp, align 2
  %_76 = load i16, i16* %letter_idx_tmp, align 2
  %22 = mul i16 8, %_76
  store i16 %22, i16* %letter_shift, align 2
  %_79 = load i16, i16* %letter_shift, align 2
  %_78 = icmp eq i16 %_79, 16
  br i1 %_78, label %bb32, label %bb31

bb31:                                             ; preds = %bb30
  store i16 0, i16* %_77, align 2
  br label %bb33

bb32:                                             ; preds = %bb30
  store i16 0, i16* %_77, align 2
  br label %bb33

bb33:                                             ; preds = %bb32, %bb31
  %23 = load i16, i16* %_77, align 2
  store i16 %23, i16* %letter, align 2
  %24 = load i16, i16* bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app17LOG_SAMPLECOUNTNV17h8df88dc6ce8f7280E to i16*), align 2
  %25 = add i16 %24, 1
  store i16 %25, i16* bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app17LOG_SAMPLECOUNTNV17h8df88dc6ce8f7280E to i16*), align 2
  %_81 = load i16, i16* %child, align 2
  store i16 %_81, i16* %parent, align 2
  %_83 = load i16, i16* %letter, align 2
  %_84 = load i16, i16* %parent, align 2
  %_85 = load [512 x %Node]*, [512 x %Node]** %dict, align 2, !nonnull !1
  %_82 = call i16 @_ZN8cem_rust10find_child17h505c0f8555289c54E(i16 %_83, i16 %_84, [512 x %Node]* noalias readonly align 2 dereferenceable(3072) %_85)
  br label %bb34

bb34:                                             ; preds = %bb33
  store i16 %_82, i16* %child, align 2
  br label %bb25

bb35:                                             ; preds = %bb26
  %_91 = load i16, i16* %letter, align 2
  %_92 = load i16, i16* %parent, align 2
  %_93 = load [512 x %Node]*, [512 x %Node]** %dict, align 2, !nonnull !1
  %_94 = load i16*, i16** %node_count, align 2, !nonnull !1
  call void @_ZN8cem_rust8add_node17hcc92e6fe2378bfb4E(i16 %_91, i16 %_92, [512 x %Node]* align 2 dereferenceable(3072) %_93, i16* align 2 dereferenceable(2) %_94)
  br label %bb36

bb36:                                             ; preds = %bb35
  %_96 = load i16, i16* bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app11LOG_COUNTNV17heb176871f3cfee12E to i16*), align 2
  %_95 = icmp eq i16 %_96, 64
  br i1 %_95, label %bb38, label %bb37

bb37:                                             ; preds = %bb36
  br label %bb9

bb38:                                             ; preds = %bb36
  %_98 = load [64 x i16]*, [64 x i16]** %log, align 2, !nonnull !1
  call void @_ZN8cem_rust9print_log17hd8a4b3a7b3c229fbE([64 x i16]* noalias readonly align 2 dereferenceable(128) %_98, i16* noalias readonly align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app11LOG_COUNTNV17heb176871f3cfee12E to i16*), i16* noalias readonly align 2 dereferenceable(2) bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app17LOG_SAMPLECOUNTNV17h8df88dc6ce8f7280E to i16*))
  br label %bb39

bb39:                                             ; preds = %bb38
  store i16 0, i16* bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app11LOG_COUNTNV17heb176871f3cfee12E to i16*), align 2
  store i16 0, i16* bitcast (<{ [2 x i8] }>* @_ZN8cem_rust3app17LOG_SAMPLECOUNTNV17h8df88dc6ce8f7280E to i16*), align 2
  br label %bb3

bb40:                                             ; preds = %bb5
  call void @gpioTwiddle()
  br label %bb41

bb41:                                             ; preds = %bb40
  br label %bb1
}

; Function Attrs: nounwind
define internal { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h3ff2602e08c1d7d7E"(i16 %self.0, i16 %self.1) unnamed_addr #0 {
start:
  %0 = insertvalue { i16, i16 } undef, i16 %self.0, 0
  %1 = insertvalue { i16, i16 } %0, i16 %self.1, 1
  ret { i16, i16 } %1
}

; Function Attrs: inlinehint nounwind
define internal { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h1db0d967d62d2379E"({ i16, i16 }* align 2 dereferenceable(4) %self) unnamed_addr #1 {
start:
  %0 = alloca { i16, i16 }, align 2
  %_3 = bitcast { i16, i16 }* %self to i16*
  %_4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %self, i32 0, i32 1
  %_2 = call zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$u16$GT$2lt17hd6e7e8871cf4fb90E"(i16* noalias readonly align 2 dereferenceable(2) %_3, i16* noalias readonly align 2 dereferenceable(2) %_4)
  br label %bb1

bb1:                                              ; preds = %start
  br i1 %_2, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  %1 = bitcast { i16, i16 }* %0 to i16*
  store i16 0, i16* %1, align 2
  br label %bb7

bb3:                                              ; preds = %bb1
  %_7 = bitcast { i16, i16 }* %self to i16*
  %_6 = call i16 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$u16$GT$5clone17h509965a3e393c998E"(i16* noalias readonly align 2 dereferenceable(2) %_7)
  br label %bb4

bb4:                                              ; preds = %bb3
  %n = call i16 @"_ZN47_$LT$u16$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17hae0ec5b9f9372492E"(i16 %_6, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  %_10 = bitcast { i16, i16 }* %self to i16*
  %_8 = call i16 @_ZN4core3mem7replace17he5e8272bf54f1ca9E(i16* align 2 dereferenceable(2) %_10, i16 %n)
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
define internal void @_ZN8cem_rust9init_dict17h3b9a79dd4c8352dcE([512 x %Node]* align 2 dereferenceable(3072) %dict, i16* align 2 dereferenceable(2) %node_count) unnamed_addr #0 {
start:
  %_7 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_4 = alloca { i16, i16 }, align 2
  %0 = bitcast { i16, i16 }* %_4 to i16*
  store i16 0, i16* %0, align 2
  %1 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_4, i32 0, i32 1
  store i16 256, i16* %1, align 2
  %2 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_4, i32 0, i32 0
  %3 = load i16, i16* %2, align 2
  %4 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_4, i32 0, i32 1
  %5 = load i16, i16* %4, align 2
  %6 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h3ff2602e08c1d7d7E"(i16 %3, i16 %5)
  %_3.0 = extractvalue { i16, i16 } %6, 0
  %_3.1 = extractvalue { i16, i16 } %6, 1
  br label %bb1

bb1:                                              ; preds = %start
  %7 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_3.0, i16* %7, align 2
  %8 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_3.1, i16* %8, align 2
  br label %bb2

bb2:                                              ; preds = %bb9, %bb1
  %9 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h1db0d967d62d2379E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %9, { i16, i16 }* %_7, align 2
  br label %bb3

bb3:                                              ; preds = %bb2
  %10 = bitcast { i16, i16 }* %_7 to i16*
  %_10 = load i16, i16* %10, align 2, !range !0
  switch i16 %_10, label %bb5 [
    i16 0, label %bb4
    i16 1, label %bb6
  ]

bb4:                                              ; preds = %bb3
  store i16 256, i16* %node_count, align 2
  ret void

bb5:                                              ; preds = %bb3
  unreachable

bb6:                                              ; preds = %bb3
  %11 = bitcast { i16, i16 }* %_7 to %"core::option::Option<u16>::Some"*
  %12 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %11, i32 0, i32 1
  %val = load i16, i16* %12, align 2
  %_18 = icmp ult i16 %val, 512
  %13 = call i1 @llvm.expect.i1(i1 %_18, i1 true)
  br i1 %13, label %bb7, label %panic

bb7:                                              ; preds = %bb6
  %14 = getelementptr inbounds [512 x %Node], [512 x %Node]* %dict, i16 0, i16 %val
  %15 = bitcast %Node* %14 to i16*
  store i16 %val, i16* %15, align 2
  %_22 = icmp ult i16 %val, 512
  %16 = call i1 @llvm.expect.i1(i1 %_22, i1 true)
  br i1 %16, label %bb8, label %panic1

bb8:                                              ; preds = %bb7
  %17 = getelementptr inbounds [512 x %Node], [512 x %Node]* %dict, i16 0, i16 %val
  %18 = getelementptr inbounds %Node, %Node* %17, i32 0, i32 3
  store i16 0, i16* %18, align 2
  %_26 = icmp ult i16 %val, 512
  %19 = call i1 @llvm.expect.i1(i1 %_26, i1 true)
  br i1 %19, label %bb9, label %panic2

bb9:                                              ; preds = %bb8
  %20 = getelementptr inbounds [512 x %Node], [512 x %Node]* %dict, i16 0, i16 %val
  %21 = getelementptr inbounds %Node, %Node* %20, i32 0, i32 5
  store i16 0, i16* %21, align 2
  br label %bb2

panic:                                            ; preds = %bb6
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 512, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc45 to %"core::panic::Location"*))
  unreachable

panic1:                                           ; preds = %bb7
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 512, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc47 to %"core::panic::Location"*))
  unreachable

panic2:                                           ; preds = %bb8
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 512, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc49 to %"core::panic::Location"*))
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
define void @atomic_end() unnamed_addr #0 {
start:
  call void @end_atomic()
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: nounwind
define internal i16 @_ZN8cem_rust10find_child17h505c0f8555289c54E(i16 %letter, i16 %parent, [512 x %Node]* noalias readonly align 2 dereferenceable(3072) %dict) unnamed_addr #0 {
start:
  %sibling = alloca i16, align 2
  %ret = alloca i16, align 2
  %0 = alloca i16, align 2
  %_8 = icmp ult i16 %parent, 512
  %1 = call i1 @llvm.expect.i1(i1 %_8, i1 true)
  br i1 %1, label %bb1, label %panic

bb1:                                              ; preds = %start
  %_5 = getelementptr inbounds [512 x %Node], [512 x %Node]* %dict, i16 0, i16 %parent
  store i16 0, i16* %ret, align 2
  %2 = getelementptr inbounds %Node, %Node* %_5, i32 0, i32 5
  %_11 = load i16, i16* %2, align 2
  %_10 = icmp eq i16 %_11, 0
  br i1 %_10, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  %3 = getelementptr inbounds %Node, %Node* %_5, i32 0, i32 5
  %4 = load i16, i16* %3, align 2
  store i16 %4, i16* %sibling, align 2
  br label %bb5

bb3:                                              ; preds = %bb1
  store i16 0, i16* %0, align 2
  br label %bb4

bb4:                                              ; preds = %bb11, %bb3
  %5 = load i16, i16* %0, align 2
  ret i16 %5

bb5:                                              ; preds = %bb9, %bb2
  %_14 = load i16, i16* %sibling, align 2
  %_13 = icmp ne i16 %_14, 0
  br i1 %_13, label %bb7, label %bb6

bb6:                                              ; preds = %bb5
  br label %bb11

bb7:                                              ; preds = %bb5
  %_17 = load i16, i16* %sibling, align 2
  %_19 = icmp ult i16 %_17, 512
  %6 = call i1 @llvm.expect.i1(i1 %_19, i1 true)
  br i1 %6, label %bb8, label %panic1

bb8:                                              ; preds = %bb7
  %_16 = getelementptr inbounds [512 x %Node], [512 x %Node]* %dict, i16 0, i16 %_17
  %7 = bitcast %Node* %_16 to i16*
  %_21 = load i16, i16* %7, align 2
  %_20 = icmp eq i16 %_21, %letter
  br i1 %_20, label %bb10, label %bb9

bb9:                                              ; preds = %bb8
  %8 = getelementptr inbounds %Node, %Node* %_16, i32 0, i32 3
  %_24 = load i16, i16* %8, align 2
  store i16 %_24, i16* %sibling, align 2
  br label %bb5

bb10:                                             ; preds = %bb8
  %_23 = load i16, i16* %sibling, align 2
  store i16 %_23, i16* %ret, align 2
  br label %bb11

bb11:                                             ; preds = %bb10, %bb6
  %9 = load i16, i16* %ret, align 2
  store i16 %9, i16* %0, align 2
  br label %bb4

panic:                                            ; preds = %start
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %parent, i16 512, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc51 to %"core::panic::Location"*))
  unreachable

panic1:                                           ; preds = %bb7
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %_17, i16 512, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc53 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define internal void @_ZN8cem_rust17append_compressed17h235b14694022953dE(i16 %parent, [64 x i16]* align 2 dereferenceable(128) %log, i16* align 2 dereferenceable(2) %log_count) unnamed_addr #0 {
start:
  %_6 = load i16, i16* %log_count, align 2
  %_8 = icmp ult i16 %_6, 64
  %0 = call i1 @llvm.expect.i1(i1 %_8, i1 true)
  br i1 %0, label %bb1, label %panic

bb1:                                              ; preds = %start
  %1 = getelementptr inbounds [64 x i16], [64 x i16]* %log, i16 0, i16 %_6
  store i16 %parent, i16* %1, align 2
  %_9 = load i16, i16* %log_count, align 2
  %2 = add i16 %_9, 1
  store i16 %2, i16* %log_count, align 2
  ret void

panic:                                            ; preds = %start
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %_6, i16 64, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc69 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define internal void @_ZN8cem_rust8add_node17hcc92e6fe2378bfb4E(i16 %letter, i16 %parent, [512 x %Node]* align 2 dereferenceable(3072) %dict, i16* align 2 dereferenceable(2) %node_count) unnamed_addr #0 {
start:
  %sibling_next = alloca i16, align 2
  %sibling = alloca i16, align 2
  %node = alloca %Node, align 2
  %0 = alloca {}, align 1
  %_6 = load i16, i16* %node_count, align 2
  %_5 = icmp eq i16 %_6, 512
  br i1 %_5, label %bb2, label %bb1

bb1:                                              ; preds = %start
  %1 = bitcast %Node* %node to i16*
  store i16 %letter, i16* %1, align 2
  %2 = getelementptr inbounds %Node, %Node* %node, i32 0, i32 3
  store i16 0, i16* %2, align 2
  %3 = getelementptr inbounds %Node, %Node* %node, i32 0, i32 5
  store i16 0, i16* %3, align 2
  %_15 = load i16, i16* %node_count, align 2
  %_19 = icmp ult i16 %parent, 512
  %4 = call i1 @llvm.expect.i1(i1 %_19, i1 true)
  br i1 %4, label %bb6, label %panic

bb2:                                              ; preds = %start
  %_8 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [23 x i8] }>* @alloc10 to [0 x i8]*), i16 23)
  br label %bb3

bb3:                                              ; preds = %bb2
  call void (i8*, ...) @printf(i8* %_8)
  br label %bb4

bb4:                                              ; preds = %bb3
  br label %bb5

bb5:                                              ; preds = %bb18, %bb4
  ret void

bb6:                                              ; preds = %bb1
  %5 = getelementptr inbounds [512 x %Node], [512 x %Node]* %dict, i16 0, i16 %parent
  %6 = getelementptr inbounds %Node, %Node* %5, i32 0, i32 5
  %child = load i16, i16* %6, align 2
  %_20 = load i16, i16* %node_count, align 2
  %7 = add i16 %_20, 1
  store i16 %7, i16* %node_count, align 2
  %_21 = icmp ne i16 %child, 0
  br i1 %_21, label %bb8, label %bb7

bb7:                                              ; preds = %bb6
  %_39 = icmp ult i16 %parent, 512
  %8 = call i1 @llvm.expect.i1(i1 %_39, i1 true)
  br i1 %8, label %bb14, label %panic3

bb8:                                              ; preds = %bb6
  store i16 %child, i16* %sibling, align 2
  %9 = load i16, i16* %sibling, align 2
  store i16 %9, i16* %sibling_next, align 2
  br label %bb9

bb9:                                              ; preds = %bb12, %bb8
  %_26 = load i16, i16* %sibling_next, align 2
  %_25 = icmp ne i16 %_26, 0
  br i1 %_25, label %bb11, label %bb10

bb10:                                             ; preds = %bb9
  %_33 = load i16, i16* %sibling, align 2
  %_35 = icmp ult i16 %_33, 512
  %10 = call i1 @llvm.expect.i1(i1 %_35, i1 true)
  br i1 %10, label %bb13, label %panic2

bb11:                                             ; preds = %bb9
  %_27 = load i16, i16* %sibling_next, align 2
  store i16 %_27, i16* %sibling, align 2
  %_29 = load i16, i16* %sibling, align 2
  %_31 = icmp ult i16 %_29, 512
  %11 = call i1 @llvm.expect.i1(i1 %_31, i1 true)
  br i1 %11, label %bb12, label %panic1

bb12:                                             ; preds = %bb11
  %12 = getelementptr inbounds [512 x %Node], [512 x %Node]* %dict, i16 0, i16 %_29
  %13 = getelementptr inbounds %Node, %Node* %12, i32 0, i32 3
  %_28 = load i16, i16* %13, align 2
  store i16 %_28, i16* %sibling_next, align 2
  br label %bb9

bb13:                                             ; preds = %bb10
  %14 = getelementptr inbounds [512 x %Node], [512 x %Node]* %dict, i16 0, i16 %_33
  %15 = getelementptr inbounds %Node, %Node* %14, i32 0, i32 3
  store i16 %_15, i16* %15, align 2
  br label %bb15

bb14:                                             ; preds = %bb7
  %16 = getelementptr inbounds [512 x %Node], [512 x %Node]* %dict, i16 0, i16 %parent
  %17 = getelementptr inbounds %Node, %Node* %16, i32 0, i32 5
  store i16 %_15, i16* %17, align 2
  br label %bb15

bb15:                                             ; preds = %bb14, %bb13
  %18 = bitcast %Node* %node to i16*
  %_40 = load i16, i16* %18, align 2
  %_43 = icmp ult i16 %_15, 512
  %19 = call i1 @llvm.expect.i1(i1 %_43, i1 true)
  br i1 %19, label %bb16, label %panic4

bb16:                                             ; preds = %bb15
  %20 = getelementptr inbounds [512 x %Node], [512 x %Node]* %dict, i16 0, i16 %_15
  %21 = bitcast %Node* %20 to i16*
  store i16 %_40, i16* %21, align 2
  %22 = getelementptr inbounds %Node, %Node* %node, i32 0, i32 3
  %_44 = load i16, i16* %22, align 2
  %_47 = icmp ult i16 %_15, 512
  %23 = call i1 @llvm.expect.i1(i1 %_47, i1 true)
  br i1 %23, label %bb17, label %panic5

bb17:                                             ; preds = %bb16
  %24 = getelementptr inbounds [512 x %Node], [512 x %Node]* %dict, i16 0, i16 %_15
  %25 = getelementptr inbounds %Node, %Node* %24, i32 0, i32 3
  store i16 %_44, i16* %25, align 2
  %26 = getelementptr inbounds %Node, %Node* %node, i32 0, i32 5
  %_48 = load i16, i16* %26, align 2
  %_51 = icmp ult i16 %_15, 512
  %27 = call i1 @llvm.expect.i1(i1 %_51, i1 true)
  br i1 %27, label %bb18, label %panic6

bb18:                                             ; preds = %bb17
  %28 = getelementptr inbounds [512 x %Node], [512 x %Node]* %dict, i16 0, i16 %_15
  %29 = getelementptr inbounds %Node, %Node* %28, i32 0, i32 5
  store i16 %_48, i16* %29, align 2
  br label %bb5

panic:                                            ; preds = %bb1
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %parent, i16 512, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc55 to %"core::panic::Location"*))
  unreachable

panic1:                                           ; preds = %bb11
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %_29, i16 512, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc57 to %"core::panic::Location"*))
  unreachable

panic2:                                           ; preds = %bb10
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %_33, i16 512, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc59 to %"core::panic::Location"*))
  unreachable

panic3:                                           ; preds = %bb7
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %parent, i16 512, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc61 to %"core::panic::Location"*))
  unreachable

panic4:                                           ; preds = %bb15
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %_15, i16 512, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc63 to %"core::panic::Location"*))
  unreachable

panic5:                                           ; preds = %bb16
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %_15, i16 512, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc65 to %"core::panic::Location"*))
  unreachable

panic6:                                           ; preds = %bb17
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %_15, i16 512, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc67 to %"core::panic::Location"*))
  unreachable
}

; Function Attrs: nounwind
define internal void @_ZN8cem_rust9print_log17hd8a4b3a7b3c229fbE([64 x i16]* noalias readonly align 2 dereferenceable(128) %log, i16* noalias readonly align 2 dereferenceable(2) %log_count, i16* noalias readonly align 2 dereferenceable(2) %log_sample_count) unnamed_addr #0 {
start:
  %_21 = alloca { i16, i16 }, align 2
  %iter = alloca { i16, i16 }, align 2
  %_17 = alloca { i16, i16 }, align 2
  %0 = alloca {}, align 1
  call void @output_guard_start()
  br label %bb1

bb1:                                              ; preds = %start
  %_6 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [29 x i8] }>* @alloc6 to [0 x i8]*), i16 29)
  br label %bb2

bb2:                                              ; preds = %bb1
  %_11 = load i16, i16* %log_sample_count, align 2
  %_10 = zext i16 %_11 to i32
  %_13 = load i16, i16* %log_count, align 2
  %_12 = zext i16 %_13 to i32
  call void (i8*, ...) @printf(i8* %_6, i32 %_10, i32 %_12)
  br label %bb3

bb3:                                              ; preds = %bb2
  call void @output_guard_end()
  br label %bb4

bb4:                                              ; preds = %bb3
  call void @output_guard_start()
  br label %bb5

bb5:                                              ; preds = %bb4
  %_18 = load i16, i16* %log_count, align 2
  %1 = bitcast { i16, i16 }* %_17 to i16*
  store i16 0, i16* %1, align 2
  %2 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_17, i32 0, i32 1
  store i16 %_18, i16* %2, align 2
  %3 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_17, i32 0, i32 0
  %4 = load i16, i16* %3, align 2
  %5 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %_17, i32 0, i32 1
  %6 = load i16, i16* %5, align 2
  %7 = call { i16, i16 } @"_ZN63_$LT$I$u20$as$u20$core..iter..traits..collect..IntoIterator$GT$9into_iter17h3ff2602e08c1d7d7E"(i16 %4, i16 %6)
  %_16.0 = extractvalue { i16, i16 } %7, 0
  %_16.1 = extractvalue { i16, i16 } %7, 1
  br label %bb6

bb6:                                              ; preds = %bb5
  %8 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 0
  store i16 %_16.0, i16* %8, align 2
  %9 = getelementptr inbounds { i16, i16 }, { i16, i16 }* %iter, i32 0, i32 1
  store i16 %_16.1, i16* %9, align 2
  br label %bb7

bb7:                                              ; preds = %bb14, %bb6
  %10 = call { i16, i16 } @"_ZN4core4iter5range101_$LT$impl$u20$core..iter..traits..iterator..Iterator$u20$for$u20$core..ops..range..Range$LT$A$GT$$GT$4next17h1db0d967d62d2379E"({ i16, i16 }* align 2 dereferenceable(4) %iter)
  store { i16, i16 } %10, { i16, i16 }* %_21, align 2
  br label %bb8

bb8:                                              ; preds = %bb7
  %11 = bitcast { i16, i16 }* %_21 to i16*
  %_24 = load i16, i16* %11, align 2, !range !0
  switch i16 %_24, label %bb10 [
    i16 0, label %bb9
    i16 1, label %bb11
  ]

bb9:                                              ; preds = %bb8
  %_40 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [3 x i8] }>* @alloc8 to [0 x i8]*), i16 3)
  br label %bb15

bb10:                                             ; preds = %bb8
  unreachable

bb11:                                             ; preds = %bb8
  %12 = bitcast { i16, i16 }* %_21 to %"core::option::Option<u16>::Some"*
  %13 = getelementptr inbounds %"core::option::Option<u16>::Some", %"core::option::Option<u16>::Some"* %12, i32 0, i32 1
  %val = load i16, i16* %13, align 2
  %_29 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [6 x i8] }>* @alloc7 to [0 x i8]*), i16 6)
  br label %bb12

bb12:                                             ; preds = %bb11
  %_38 = icmp ult i16 %val, 64
  %14 = call i1 @llvm.expect.i1(i1 %_38, i1 true)
  br i1 %14, label %bb13, label %panic

bb13:                                             ; preds = %bb12
  %15 = getelementptr inbounds [64 x i16], [64 x i16]* %log, i16 0, i16 %val
  %_34 = load i16, i16* %15, align 2
  %_33 = zext i16 %_34 to i32
  call void (i8*, ...) @printf(i8* %_29, i32 %_33)
  br label %bb14

bb14:                                             ; preds = %bb13
  br label %bb7

bb15:                                             ; preds = %bb9
  call void (i8*, ...) @printf(i8* %_40)
  br label %bb16

bb16:                                             ; preds = %bb15
  call void @output_guard_end()
  br label %bb17

bb17:                                             ; preds = %bb16
  %_46 = load i16, i16* %log_sample_count, align 2
  %_45 = icmp ne i16 %_46, 353
  br i1 %_45, label %bb19, label %bb18

bb18:                                             ; preds = %bb17
  br label %bb24

bb19:                                             ; preds = %bb17
  call void @output_guard_start()
  br label %bb20

bb20:                                             ; preds = %bb19
  %_49 = call i8* @"_ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hf39dfd8b214f2a88E"([0 x i8]* noalias nonnull readonly align 1 bitcast (<{ [26 x i8] }>* @alloc9 to [0 x i8]*), i16 26)
  br label %bb21

bb21:                                             ; preds = %bb20
  call void (i8*, ...) @printf(i8* %_49)
  br label %bb22

bb22:                                             ; preds = %bb21
  call void @output_guard_end()
  br label %bb23

bb23:                                             ; preds = %bb22
  br label %bb24

bb24:                                             ; preds = %bb23, %bb18
  ret void

panic:                                            ; preds = %bb12
  call void @_ZN4core9panicking18panic_bounds_check17h6e32b121061350d0E(i16 %val, i16 64, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) bitcast (<{ i8*, [10 x i8] }>* @alloc43 to %"core::panic::Location"*))
  unreachable
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
declare void @printf(i8*, ...) unnamed_addr #0

; Function Attrs: nounwind
define void @output_guard_end() unnamed_addr #0 {
start:
  call void @end_atomic()
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: nounwind readnone
declare i1 @llvm.expect.i1(i1, i1) #2

; Function Attrs: nounwind
declare void @end_atomic() unnamed_addr #0

; Function Attrs: nounwind
declare void @start_atomic() unnamed_addr #0

; Function Attrs: inlinehint nounwind
define internal zeroext i1 @"_ZN4core3cmp5impls55_$LT$impl$u20$core..cmp..PartialOrd$u20$for$u20$u16$GT$2lt17hd6e7e8871cf4fb90E"(i16* noalias readonly align 2 dereferenceable(2) %self, i16* noalias readonly align 2 dereferenceable(2) %other) unnamed_addr #1 {
start:
  %_3 = load i16, i16* %self, align 2
  %_4 = load i16, i16* %other, align 2
  %0 = icmp ult i16 %_3, %_4
  ret i1 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN4core5clone5impls52_$LT$impl$u20$core..clone..Clone$u20$for$u20$u16$GT$5clone17h509965a3e393c998E"(i16* noalias readonly align 2 dereferenceable(2) %self) unnamed_addr #1 {
start:
  %0 = load i16, i16* %self, align 2
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @"_ZN47_$LT$u16$u20$as$u20$core..iter..range..Step$GT$17forward_unchecked17hae0ec5b9f9372492E"(i16 %start1, i16 %n) unnamed_addr #1 {
start:
  %0 = call i16 @"_ZN4core3num21_$LT$impl$u20$u16$GT$13unchecked_add17h8cf7bf836884a7caE"(i16 %start1, i16 %n)
  br label %bb1

bb1:                                              ; preds = %start
  ret i16 %0
}

; Function Attrs: inlinehint nounwind
define internal i16 @_ZN4core3mem7replace17he5e8272bf54f1ca9E(i16* align 2 dereferenceable(2) %dest, i16) unnamed_addr #1 {
start:
  %src = alloca i16, align 2
  store i16 %0, i16* %src, align 2
  call void @_ZN4core3mem4swap17h2fff05b7cb09cdf1E(i16* align 2 dereferenceable(2) %dest, i16* align 2 dereferenceable(2) %src)
  br label %bb1

bb1:                                              ; preds = %start
  %1 = load i16, i16* %src, align 2
  ret i16 %1
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3mem4swap17h2fff05b7cb09cdf1E(i16* align 2 dereferenceable(2) %x, i16* align 2 dereferenceable(2) %y) unnamed_addr #1 {
start:
  call void @_ZN4core3ptr23swap_nonoverlapping_one17h673872a82023b3cbE(i16* %x, i16* %y)
  br label %bb1

bb1:                                              ; preds = %start
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr23swap_nonoverlapping_one17h673872a82023b3cbE(i16* %x, i16* %y) unnamed_addr #1 {
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
  call void @_ZN4core3ptr19swap_nonoverlapping17hc249043be558fe16E(i16* %x, i16* %y, i16 1)
  br label %bb7

bb3:                                              ; preds = %bb1
  %z = call i16 @_ZN4core3ptr4read17h4c21b643eb66c3c0E(i16* %x)
  br label %bb4

bb4:                                              ; preds = %bb3
  call void @_ZN4core10intrinsics19copy_nonoverlapping17h00d0856ff017a997E(i16* %y, i16* %x, i16 1)
  br label %bb5

bb5:                                              ; preds = %bb4
  call void @_ZN4core3ptr5write17hc9c4828e4a1ed529E(i16* %y, i16 %z)
  br label %bb6

bb6:                                              ; preds = %bb5
  br label %bb8

bb7:                                              ; preds = %bb2
  br label %bb8

bb8:                                              ; preds = %bb7, %bb6
  ret void
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr19swap_nonoverlapping17hc249043be558fe16E(i16* %x, i16* %y, i16 %count) unnamed_addr #1 {
start:
  %0 = alloca i16, align 2
  %x1 = bitcast i16* %x to i8*
  %y2 = bitcast i16* %y to i8*
  store i16 2, i16* %0, align 2
  %1 = load i16, i16* %0, align 2
  br label %bb1

bb1:                                              ; preds = %start
  %len = mul i16 %1, %count
  call void @_ZN4core3ptr25swap_nonoverlapping_bytes17h43e3de926066dcb6E(i8* %x1, i8* %y2, i16 %len)
  br label %bb2

bb2:                                              ; preds = %bb1
  ret void
}

; Function Attrs: inlinehint nounwind
define internal i16 @_ZN4core3ptr4read17h4c21b643eb66c3c0E(i16* %src) unnamed_addr #1 {
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
  call void @_ZN4core10intrinsics19copy_nonoverlapping17h00d0856ff017a997E(i16* %src, i16* %tmp, i16 1)
  br label %bb3

bb3:                                              ; preds = %bb2
  %_7 = load i16, i16* %tmp, align 2
  br label %bb4

bb4:                                              ; preds = %bb3
  ret i16 %_7
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core10intrinsics19copy_nonoverlapping17h00d0856ff017a997E(i16* %src, i16* %dst, i16 %count) unnamed_addr #1 {
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
define internal void @_ZN4core3ptr5write17hc9c4828e4a1ed529E(i16* %dst, i16 %src) unnamed_addr #1 {
start:
  %0 = alloca {}, align 1
  store i16 %src, i16* %dst, align 2
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i16(i8* nocapture writeonly, i8* nocapture readonly, i16, i1 immarg) #3

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core3ptr25swap_nonoverlapping_bytes17h43e3de926066dcb6E(i8* %x, i8* %y, i16 %len) unnamed_addr #1 {
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
define internal i16 @"_ZN4core3num21_$LT$impl$u20$u16$GT$13unchecked_add17h8cf7bf836884a7caE"(i16 %self, i16 %rhs) unnamed_addr #1 {
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
  %_22 = load [2 x { [0 x i8]*, i16 }]*, [2 x { [0 x i8]*, i16 }]** bitcast (<{ i8*, [0 x i8] }>* @anon.b7bafff2f871b915b57b152a19c6233b.18 to [2 x { [0 x i8]*, i16 }]**), align 2, !nonnull !1
  %_4.0 = bitcast [2 x { [0 x i8]*, i16 }]* %_22 to [0 x { [0 x i8]*, i16 }]*
  %3 = bitcast { i16*, i16* }* %_11 to i16**
  store i16* %len, i16** %3, align 2
  %4 = getelementptr inbounds { i16*, i16* }, { i16*, i16* }* %_11, i32 0, i32 1
  store i16* %index, i16** %4, align 2
  %5 = bitcast { i16*, i16* }* %_11 to i16**
  %arg0 = load i16*, i16** %5, align 2, !nonnull !1
  %6 = getelementptr inbounds { i16*, i16* }, { i16*, i16* }* %_11, i32 0, i32 1
  %arg1 = load i16*, i16** %6, align 2, !nonnull !1
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
  %_3 = load i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)*, i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)** %1, align 2, !nonnull !1
  br label %bb1

bb1:                                              ; preds = %start
  %4 = bitcast %"fmt::USIZE_MARKER::{{closure}}"** %0 to i16**
  store i16* %x, i16** %4, align 2
  %_5 = load %"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::USIZE_MARKER::{{closure}}"** %0, align 2, !nonnull !1
  br label %bb2

bb2:                                              ; preds = %bb1
  %5 = bitcast { i8*, i8* }* %2 to %"fmt::USIZE_MARKER::{{closure}}"**
  store %"fmt::USIZE_MARKER::{{closure}}"* %_5, %"fmt::USIZE_MARKER::{{closure}}"** %5, align 2
  %6 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 1
  %7 = bitcast i8** %6 to i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)**
  store i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)* %_3, i1 (%"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::Formatter"*)** %7, align 2
  %8 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 0
  %9 = load i8*, i8** %8, align 2, !nonnull !1
  %10 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 1
  %11 = load i8*, i8** %10, align 2, !nonnull !1
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
  %2 = load %"core::panic::Location"*, %"core::panic::Location"** %1, align 2, !nonnull !1
  br label %bb1

bb1:                                              ; preds = %start
  ret %"core::panic::Location"* %2
}

; Function Attrs: inlinehint nounwind
define internal void @_ZN4core5panic9PanicInfo20internal_constructor17h3f579eac134a0316E(%"panic::PanicInfo"* noalias nocapture sret dereferenceable(8), i16* noalias readonly align 2 dereferenceable_or_null(12) %message, %"core::panic::Location"* noalias readonly align 2 dereferenceable(12) %location) unnamed_addr #1 {
start:
  %_8 = load %"fmt::USIZE_MARKER::{{closure}}"*, %"fmt::USIZE_MARKER::{{closure}}"** bitcast (<{ i8*, [0 x i8] }>* @anon.b7bafff2f871b915b57b152a19c6233b.10 to %"fmt::USIZE_MARKER::{{closure}}"**), align 2, !nonnull !1
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

; Function Attrs: inlinehint nounwind
define i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$3add17h02212dc06e61a034E"(i8* %self, i16 %count) unnamed_addr #1 {
start:
  %0 = call i8* @"_ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$6offset17h2e1a7811e3081d04E"(i8* %self, i16 %count)
  br label %bb1

bb1:                                              ; preds = %start
  ret i8* %0
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
  call void asm sideeffect "dint { nop", "~{memory}"() #5, !srcloc !2
  br label %bb1

bb1:                                              ; preds = %start
  br label %bb2

bb2:                                              ; preds = %bb3, %bb1
  call void asm sideeffect "", "~{memory}"() #5, !srcloc !3
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
!1 = !{}
!2 = !{i32 2974937}
!3 = !{i32 2974670}
