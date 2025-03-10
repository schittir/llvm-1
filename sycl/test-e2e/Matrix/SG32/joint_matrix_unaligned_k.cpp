//==-------- joint_matrix_unaligned_k.cpp  - DPC++ joint_matrix-------------==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
// REQUIRES: aspect-ext_intel_matrix
// REQUIRES-INTEL-DRIVER: lin: 27501, win: 101.4943

// UNSUPPORTED: gpu-intel-dg2, cpu

// RUN: %{build} -o %t.out
// RUN: %{run} %t.out

// XFAIL:gpu
// XFAIL-TRACKER: GSD-4181

#include "../common.hpp"

#define SG_SZ 32
constexpr size_t TN = 16;
static constexpr size_t MATRIX_K = 1024 + 14;

#include "../joint_matrix_out_bounds_impl.hpp"
