#version 310 es
#extension GL_AMD_gpu_shader_half_float : require

void step_baa320() {
  f16vec4 arg_0 = f16vec4(1.0hf);
  f16vec4 arg_1 = f16vec4(1.0hf);
  f16vec4 res = step(arg_0, arg_1);
}

vec4 vertex_main() {
  step_baa320();
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

void step_baa320() {
  f16vec4 arg_0 = f16vec4(1.0hf);
  f16vec4 arg_1 = f16vec4(1.0hf);
  f16vec4 res = step(arg_0, arg_1);
}

void fragment_main() {
  step_baa320();
}

void main() {
  fragment_main();
  return;
}
#version 310 es
#extension GL_AMD_gpu_shader_half_float : require

void step_baa320() {
  f16vec4 arg_0 = f16vec4(1.0hf);
  f16vec4 arg_1 = f16vec4(1.0hf);
  f16vec4 res = step(arg_0, arg_1);
}

void compute_main() {
  step_baa320();
}

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
  compute_main();
  return;
}
