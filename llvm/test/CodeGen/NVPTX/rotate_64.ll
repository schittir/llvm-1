; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=nvptx64 | FileCheck %s
; RUN: %if ptxas %{ llc < %s -mtriple=nvptx64 | %ptxas-verify %}

declare i64 @llvm.nvvm.rotate.b64(i64, i32)
declare i64 @llvm.nvvm.rotate.right.b64(i64, i32)

define i64 @rotate64(i64 %a, i32 %b) {
; CHECK-LABEL: rotate64(
; CHECK:       {
; CHECK-NEXT:    .reg .b64 %rd<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u64 %rd1, [rotate64_param_0];
; CHECK-NEXT:    shr.u64 %rd2, %rd1, 61;
; CHECK-NEXT:    shl.b64 %rd3, %rd1, 3;
; CHECK-NEXT:    or.b64 %rd4, %rd3, %rd2;
; CHECK-NEXT:    st.param.b64 [func_retval0], %rd4;
; CHECK-NEXT:    ret;
  %val = tail call i64 @llvm.nvvm.rotate.b64(i64 %a, i32 3)
  ret i64 %val
}

define i64 @rotateright64(i64 %a, i32 %b) {
; CHECK-LABEL: rotateright64(
; CHECK:       {
; CHECK-NEXT:    .reg .b64 %rd<5>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.u64 %rd1, [rotateright64_param_0];
; CHECK-NEXT:    shl.b64 %rd2, %rd1, 61;
; CHECK-NEXT:    shr.u64 %rd3, %rd1, 3;
; CHECK-NEXT:    or.b64 %rd4, %rd3, %rd2;
; CHECK-NEXT:    st.param.b64 [func_retval0], %rd4;
; CHECK-NEXT:    ret;
  %val = tail call i64 @llvm.nvvm.rotate.right.b64(i64 %a, i32 3)
  ret i64 %val
}
