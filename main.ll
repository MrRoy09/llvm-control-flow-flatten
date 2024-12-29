; ModuleID = 'main.cpp'
source_filename = "main.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

module asm ".globl _ZSt21ios_base_library_initv"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.1 = private unnamed_addr constant [21 x i8] c"we outside the loop\0A\00", align 1
@.str.2 = private unnamed_addr constant [22 x i8] c"we in the subcase 10\0A\00", align 1
@.str.3 = private unnamed_addr constant [22 x i8] c"we in the subcase 11\0A\00", align 1
@.str.4 = private unnamed_addr constant [24 x i8] c"we in the else subcase\0A\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

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

7:                                                ; preds = %6
  %8 = alloca i32, align 4
  store i32 1, ptr %8, align 4
  br label %9

9:                                                ; preds = %51, %50, %47, %41, %7
  %10 = load i32, ptr %8, align 4
  %11 = load i32, ptr %2, align 4
  %12 = icmp slt i32 %11, 100
  %13 = icmp eq i32 %10, 0
  br i1 %13, label %42, label %46

14:                                               ; preds = %46, <null operand!>
  %15 = load i32, ptr %2, align 4
  %16 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %15)
  %17 = load i32, ptr %2, align 4
  %18 = icmp eq i32 %17, 10
  store i32 2, ptr %8, align 4
  br i1 %18, label %19, label %25

19:                                               ; preds = %14
  %20 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  %21 = load i32, ptr %2, align 4
  %22 = add nsw i32 %21, 1
  store i32 %22, ptr %2, align 4
  %23 = load i32, ptr %3, align 4
  %24 = add nsw i32 %23, 10
  store i32 %24, ptr %3, align 4
  br label %41

25:                                               ; preds = %14
  %26 = load i32, ptr %2, align 4
  %27 = icmp eq i32 %26, 11
  br i1 %27, label %28, label %34

28:                                               ; preds = %25
  %29 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %30 = load i32, ptr %2, align 4
  %31 = add nsw i32 %30, 2
  store i32 %31, ptr %2, align 4
  %32 = load i32, ptr %3, align 4
  %33 = sub nsw i32 %32, 10
  store i32 %33, ptr %3, align 4
  br label %40

34:                                               ; preds = %25
  %35 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  %36 = load i32, ptr %2, align 4
  %37 = add nsw i32 %36, 3
  store i32 %37, ptr %2, align 4
  %38 = load i32, ptr %3, align 4
  %39 = sub nsw i32 %38, 20
  store i32 %39, ptr %3, align 4
  br label %40

40:                                               ; preds = %34, %28
  br label %41

41:                                               ; preds = %40, %19
  br label %9, !llvm.loop !5

42:                                               ; preds = %46, %9, <null operand!>
  %43 = load i32, ptr %2, align 4
  %44 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %43)
  %45 = load i32, ptr %2, align 4
  ret i32 %45

46:                                               ; preds = %9
  switch i32 %10, label %42 [
    i32 1, label %47
    i32 2, label %48
    i32 3, label %14
  ]

47:                                               ; preds = %46
  store i32 2, ptr %8, align 4
  br label %9

48:                                               ; preds = %46
  %49 = icmp slt i32 %11, 100
  br i1 %49, label %50, label %51

50:                                               ; preds = %48
  store i32 3, ptr %8, align 4
  br label %9

51:                                               ; preds = %48
  store i32 0, ptr %8, align 4
  br label %9
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
