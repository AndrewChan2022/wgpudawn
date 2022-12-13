#version 310 es

uvec3 tint_div(uint lhs, uvec3 rhs) {
  uvec3 l = uvec3(lhs);
  return (l / mix(rhs, uvec3(1u), equal(rhs, uvec3(0u))));
}

void f() {
  uint a = 4u;
  uvec3 b = uvec3(0u, 2u, 0u);
  uvec3 r = tint_div(a, b);
}

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
  f();
  return;
}
