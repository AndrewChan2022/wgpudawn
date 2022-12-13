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


// fn faceForward(vec<3, fa>, vec<3, fa>, vec<3, fa>) -> vec<3, fa>
fn faceForward_fe522b() {
  const arg_0 = vec3(1.);
  const arg_1 = vec3(1.);
  const arg_2 = vec3(1.);
  var res = faceForward(arg_0, arg_1, arg_2);
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  faceForward_fe522b();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  faceForward_fe522b();
}

@compute @workgroup_size(1)
fn compute_main() {
  faceForward_fe522b();
}
