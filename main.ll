; ModuleID = 'main.cpp'
source_filename = "main.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

module asm ".globl _ZSt21ios_base_library_initv"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.1 = private unnamed_addr constant [21 x i8] c"we outside the loop\0A\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"we in the loop\0A\00", align 1
@.str.3 = private unnamed_addr constant [22 x i8] c"we in the subcase 10\0A\00", align 1
@.str.4 = private unnamed_addr constant [22 x i8] c"we in the subcase 11\0A\00", align 1
@.str.5 = private unnamed_addr constant [24 x i8] c"we in the else subcase\0A\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: mustprogress noinline norecurse optnone uwtable
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %4 = call i32 (ptr, ...) @__isoc23_scanf(ptr noundef @.str, ptr noundef %2)
  store i32 50, ptr %3, align 4
  %5 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  br label %6

6:                                                ; preds = %0
  br label %7

7:                                                ; preds = %48, %47, %45, %39, %6
  %8 = load i32, ptr %2, align 4
  %9 = icmp slt i32 %8, 100
  %10 = alloca i32, align 4
  store i32 1, ptr %10, align 4
  %11 = load i32, ptr %10, align 4
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %44, label %13

13:                                               ; preds = %44, %7, <null operand!>
  %14 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  %15 = load i32, ptr %2, align 4
  %16 = icmp eq i32 %15, 10
  br i1 %16, label %17, label %23

17:                                               ; preds = %13
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %19 = load i32, ptr %2, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, ptr %2, align 4
  %21 = load i32, ptr %3, align 4
  %22 = add nsw i32 %21, 10
  store i32 %22, ptr %3, align 4
  br label %39

23:                                               ; preds = %13
  %24 = load i32, ptr %2, align 4
  %25 = icmp eq i32 %24, 11
  br i1 %25, label %26, label %32

26:                                               ; preds = %23
  %27 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  %28 = load i32, ptr %2, align 4
  %29 = add nsw i32 %28, 2
  store i32 %29, ptr %2, align 4
  %30 = load i32, ptr %3, align 4
  %31 = sub nsw i32 %30, 10
  store i32 %31, ptr %3, align 4
  br label %38

32:                                               ; preds = %23
  %33 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  %34 = load i32, ptr %2, align 4
  %35 = add nsw i32 %34, 3
  store i32 %35, ptr %2, align 4
  %36 = load i32, ptr %3, align 4
  %37 = sub nsw i32 %36, 20
  store i32 %37, ptr %3, align 4
  br label %38

38:                                               ; preds = %32, %26
  br label %39

39:                                               ; preds = %38, %17
  br label %7, !llvm.loop !5

40:                                               ; preds = %44, <null operand!>
  %41 = load i32, ptr %2, align 4
  %42 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %41)
  %43 = load i32, ptr %2, align 4
  ret i32 %43

44:                                               ; preds = %7
  switch i32 %11, label %40 [
    i32 1, label %45
    i32 2, label %46
    i32 3, label %13
  ]

45:                                               ; preds = %44
  store i32 2, ptr %10, align 4
  br label %7

46:                                               ; preds = %44
  br i1 %9, label %47, label %48

47:                                               ; preds = %46
  store i32 3, ptr %10, align 4
  br label %7

48:                                               ; preds = %46
  store i32 0, ptr %10, align 4
  br label %7
}

declare i32 @__isoc23_scanf(ptr noundef, ...) #1

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { mustprogress noinline norecurse optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 7, !"frame-pointer", i32 2}
!4 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
