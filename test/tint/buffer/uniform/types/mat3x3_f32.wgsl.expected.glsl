#version 310 es

layout(binding = 0, std140) uniform u_block_ubo {
  mat3 inner;
} u;

void tint_symbol() {
  mat3 x = u.inner;
}

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
  tint_symbol();
  return;
}