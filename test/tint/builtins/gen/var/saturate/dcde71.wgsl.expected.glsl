#version 310 es
#extension GL_AMD_gpu_shader_half_float : require

f16vec4 tint_saturate(f16vec4 v) {
  return clamp(v, f16vec4(0.0hf), f16vec4(1.0hf));
}

void saturate_dcde71() {
  f16vec4 arg_0 = f16vec4(2.0hf);
  f16vec4 res = tint_saturate(arg_0);
}

vec4 vertex_main() {
  saturate_dcde71();
  return vec4(0.0f);
}

void main() {
  gl_PointSize = 1.0;
  vec4 inner_result = vertex_main();
  gl_Position = inner_result;
  gl_Position.y = -(gl_Position.y);
  gl_Position.z = ((2.0f * gl_Position.z) - gl_Position.w);
  return;
}
#version 310 es
#extension GL_AMD_gpu_shader_half_float : require
precision mediump float;

f16vec4 tint_saturate(f16vec4 v) {
  return clamp(v, f16vec4(0.0hf), f16vec4(1.0hf));
}

void saturate_dcde71() {
  f16vec4 arg_0 = f16vec4(2.0hf);
  f16vec4 res = tint_saturate(arg_0);
}

void fragment_main() {
  saturate_dcde71();
}

void main() {
  fragment_main();
  return;
}
#version 310 es
#extension GL_AMD_gpu_shader_half_float : require

f16vec4 tint_saturate(f16vec4 v) {
  return clamp(v, f16vec4(0.0hf), f16vec4(1.0hf));
}

void saturate_dcde71() {
  f16vec4 arg_0 = f16vec4(2.0hf);
  f16vec4 res = tint_saturate(arg_0);
}

void compute_main() {
  saturate_dcde71();
}

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
  compute_main();
  return;
}
