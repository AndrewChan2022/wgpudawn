#version 310 es
#extension GL_AMD_gpu_shader_half_float : require

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void unused_entry_point() {
  return;
}
f16mat2 m = f16mat2(f16vec2(0.0hf, 1.0hf), f16vec2(2.0hf, 3.0hf));
f16mat2 f() {
  f16mat2 m_1 = f16mat2(m);
  return m_1;
}
