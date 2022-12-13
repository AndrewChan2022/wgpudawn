#version 310 es

struct str {
  int i;
};

shared str S;
void func_S_i() {
  S.i = 42;
}

void tint_symbol(uint local_invocation_index) {
  {
    str tint_symbol_1 = str(0);
    S = tint_symbol_1;
  }
  barrier();
  func_S_i();
}

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
  tint_symbol(gl_LocalInvocationIndex);
  return;
}
