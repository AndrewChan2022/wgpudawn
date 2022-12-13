// Copyright 2021 The Tint Authors.
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


// fn smoothstep(vec<3, f32>, vec<3, f32>, vec<3, f32>) -> vec<3, f32>
fn smoothstep_aad1db() {
  var res: vec3<f32> = smoothstep(vec3<f32>(2.f), vec3<f32>(4.f), vec3<f32>(3.f));
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  smoothstep_aad1db();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  smoothstep_aad1db();
}

@compute @workgroup_size(1)
fn compute_main() {
  smoothstep_aad1db();
}