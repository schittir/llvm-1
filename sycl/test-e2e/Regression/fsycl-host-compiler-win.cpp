// RUN: %{build} -fsycl-host-compiler=cl -DDEFINE_CHECK -fsycl-host-compiler-options="-DDEFINE_CHECK /std:c++17 /Zc:__cplusplus" -o %t.exe
// RUN: %{run} %t.exe
// REQUIRES: windows
// REQUIRES: build-and-run-mode
//
//==------- fsycl-host-compiler-win.cpp - external host compiler test ------==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Uses -fsycl-host-compiler=<compiler> on a simple test, requires 'cl'

#include <sycl/detail/core.hpp>

#include <sycl/properties/all_properties.hpp>

#ifndef DEFINE_CHECK
#error predefined macro not set
#endif // DEFINE_CHECK

using namespace sycl;

int main() {
  int data[] = {0, 0, 0};

  {
    buffer<int, 1> b(data, range<1>(3), {property::buffer::use_host_ptr()});
    queue q;
    q.submit([&](handler &cgh) {
      auto B = b.get_access<access::mode::write>(cgh);
      cgh.parallel_for<class test>(range<1>(3), [=](id<1> idx) { B[idx] = 1; });
    });
  }

  bool isSuccess = true;

  for (int i = 0; i < 3; i++)
    if (data[i] != 1)
      isSuccess = false;

  if (!isSuccess)
    return -1;

  return 0;
}
