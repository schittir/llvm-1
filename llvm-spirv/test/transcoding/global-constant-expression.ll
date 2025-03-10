; RUN: llvm-as < %s | llvm-spirv -spirv-text -o - | FileCheck %s --check-prefix=CHECK-SPIRV
; RUN: llvm-as < %s | llvm-spirv -o %t.spv
; RUN: llvm-spirv -r %t.spv -o - | llvm-dis | FileCheck %s --check-prefix=CHECK-LLVM

; RUN: llvm-as < %s | llvm-spirv --spirv-ext=+SPV_KHR_untyped_pointers -spirv-text -o - | FileCheck %s --check-prefix=CHECK-SPIRV
; RUN: llvm-as < %s | llvm-spirv --spirv-ext=+SPV_KHR_untyped_pointers -o %t.spv
; RUN: llvm-spirv -r %t.spv -o - | llvm-dis | FileCheck %s --check-prefix=CHECK-LLVM

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir-unknown-unknown"

; CHECK-SPIRV: SpecConstantOp {{[0-9]*}} {{[0-9]*}} {{70|4424}}
; CHECK-SPIRV: SpecConstantOp {{[0-9]*}} {{[0-9]*}} {{70|4424}}
; CHECK-LLVM: @k_var = addrspace(1) global [2 x ptr addrspace(1)] [ptr addrspace(1) getelementptr inbounds ([2 x i8], ptr addrspace(1) @a_var, i32 0, i64 1), ptr addrspace(1) @a_var], align 4

@a_var = addrspace(1) global [2 x i8] c"\96\96", align 1
@k_var = addrspace(1) global [2 x ptr addrspace(1)] [ptr addrspace(1) getelementptr inbounds ([2 x i8], ptr addrspace(1) @a_var, i32 0, i64 1), ptr addrspace(1) getelementptr inbounds ([2 x i8], ptr addrspace(1) @a_var, i32 0, i32 0)], align 4

!opencl.enable.FP_CONTRACT = !{}
!opencl.spir.version = !{!0}
!opencl.ocl.version = !{!0}
!opencl.used.extensions = !{!1}
!opencl.used.optional.core.features = !{!1}
!opencl.compiler.options = !{!1}

!0 = !{i32 1, i32 2}
!1 = !{}
