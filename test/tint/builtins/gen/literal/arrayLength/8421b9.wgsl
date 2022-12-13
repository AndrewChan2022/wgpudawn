// Copyright 2022 The Tint Authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

////////////////////////////////////////////////////////////////////////////////
// File generated by tools/src/cmd/gen
// using the template:
//   test/tint/builtins/gen/gen.wgsl.tmpl
//
// Do not modify this file directly
////////////////////////////////////////////////////////////////////////////////


enable f16;
struct SB_RO {
  arg_0: array<f16>,
};
@group(0) @binding(1) var<storage, read> sb_ro : SB_RO;

// fn arrayLength(ptr<storage, array<f16>, read>) -> u32
fn arrayLength_8421b9() {
  var res: u32 = arrayLength(&sb_ro.arg_0);
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  arrayLength_8421b9();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  arrayLength_8421b9();
}

@compute @workgroup_size(1)
fn compute_main() {
  arrayLength_8421b9();
}
