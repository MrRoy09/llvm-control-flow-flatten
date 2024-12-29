; ModuleID = 'main.cpp'
source_filename = "main.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

module asm ".globl _ZSt21ios_base_library_initv"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1

; Function Attrs: mustprogress noinline norecurse optnone uwtable
define noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  %4 = call i32 (ptr, ...) @__isoc23_scanf(ptr noundef @.str, ptr noundef %2)
  store i32 50, ptr %3, align 4
  br label %5

5:                                                ; preds = %0
  br label %6

6:                                                ; preds = %39, %34, %5
  %7 = load i32, ptr %2, align 4
  %8 = icmp slt i32 %7, 100
  %9 = alloca i32, align 4
  store i32 1, ptr %9, align 4
  %10 = load i32, ptr %9, align 4
  %11 = icmp eq i32 %10, 1
  br i1 %11, label %40, label %35

12:                                               ; preds = %40, <null operand!>
  %13 = load i32, ptr %2, align 4
  %14 = icmp eq i32 %13, 10
  br i1 %14, label %15, label %20

15:                                               ; preds = %12
  %16 = load i32, ptr %2, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, ptr %2, align 4
  %18 = load i32, ptr %3, align 4
  %19 = add nsw i32 %18, 10
  store i32 %19, ptr %3, align 4
  br label %34

20:                                               ; preds = %12
  %21 = load i32, ptr %2, align 4
  %22 = icmp eq i32 %21, 11
  br i1 %22, label %23, label %28

23:                                               ; preds = %20
  %24 = load i32, ptr %2, align 4
  %25 = add nsw i32 %24, 2
  store i32 %25, ptr %2, align 4
  %26 = load i32, ptr %3, align 4
  %27 = sub nsw i32 %26, 10
  store i32 %27, ptr %3, align 4
  br label %33

28:                                               ; preds = %20
  %29 = load i32, ptr %2, align 4
  %30 = add nsw i32 %29, 3
  store i32 %30, ptr %2, align 4
  %31 = load i32, ptr %3, align 4
  %32 = sub nsw i32 %31, 20
  store i32 %32, ptr %3, align 4
  br label %33

33:                                               ; preds = %28, %23
  br label %34

34:                                               ; preds = %33, %15
  br label %6, !llvm.loop !5

35:                                               ; preds = %40, %6, <null operand!>
  %36 = load i32, ptr %2, align 4
  %37 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %36)
  %38 = load i32, ptr %2, align 4
  ret i32 %38

39:                                               ; preds = %40
  store i32 2, ptr %9, align 4
  br label %6

40:                                               ; preds = %6
  switch i32 %10, label %35 [
    i32 1, label %39
    i32 3, label %12
  ]
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
