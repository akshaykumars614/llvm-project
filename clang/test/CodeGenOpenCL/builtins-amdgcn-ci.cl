// REQUIRES: amdgpu-registered-target
// RUN: %clang_cc1 -cl-std=CL2.0 -O0 -triple amdgcn-unknown-unknown -target-cpu hawaii -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -cl-std=CL2.0 -O0 -triple amdgcn-unknown-unknown -target-cpu fiji -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -cl-std=CL2.0 -O0 -triple amdgcn-unknown-unknown -target-cpu gfx906 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -cl-std=CL2.0 -O0 -triple amdgcn-unknown-unknown -target-cpu gfx1010 -emit-llvm -o - %s | FileCheck %s

typedef unsigned int uint;
typedef unsigned long ulong;

// CHECK-LABEL: @test_s_dcache_inv_vol
// CHECK: call void @llvm.amdgcn.s.dcache.inv.vol(
void test_s_dcache_inv_vol()
{
  __builtin_amdgcn_s_dcache_inv_vol();
}

// CHECK-LABEL: @test_buffer_wbinvl1_vol
// CHECK: call void @llvm.amdgcn.buffer.wbinvl1.vol()
void test_buffer_wbinvl1_vol()
{
  __builtin_amdgcn_buffer_wbinvl1_vol();
}

// CHECK-LABEL: @test_gws_sema_release_all(
// CHECK: call void @llvm.amdgcn.ds.gws.sema.release.all(i32 %{{[0-9]+}})
void test_gws_sema_release_all(uint id)
{
  __builtin_amdgcn_ds_gws_sema_release_all(id);
}

// CHECK-LABEL: @test_s_memtime
// CHECK: call i64 @llvm.amdgcn.s.memtime()
void test_s_memtime(global ulong* out)
{
  *out = __builtin_amdgcn_s_memtime();
}

// CHECK-LABEL: @test_is_shared(
// CHECK: call i1 @llvm.amdgcn.is.shared(ptr %{{[0-9]+}}
int test_is_shared(const int* ptr) {
  return __builtin_amdgcn_is_shared(ptr);
}

// CHECK-LABEL: @test_is_private(
// CHECK: call i1 @llvm.amdgcn.is.private(ptr %{{[0-9]+}}
int test_is_private(const int* ptr) {
  return __builtin_amdgcn_is_private(ptr);
}

// CHECK-LABEL: @test_is_shared_global(
// CHECK: [[CAST:%[0-9]+]] = addrspacecast ptr addrspace(1) %{{[0-9]+}} to ptr
// CHECK: call i1 @llvm.amdgcn.is.shared(ptr [[CAST]]
int test_is_shared_global(const global int* ptr) {
  return __builtin_amdgcn_is_shared(ptr);
}

// CHECK-LABEL: @test_is_private_global(
// CHECK: [[CAST:%[0-9]+]] = addrspacecast ptr addrspace(1) %{{[0-9]+}} to ptr
// CHECK: call i1 @llvm.amdgcn.is.private(ptr [[CAST]]
int test_is_private_global(const global int* ptr) {
  return __builtin_amdgcn_is_private(ptr);
}

// CHECK-LABEL: @test_groupstaticsize
// CHECK: call i32 @llvm.amdgcn.groupstaticsize()
void test_groupstaticsize(global uint* out) {
  *out = __builtin_amdgcn_groupstaticsize();
}
