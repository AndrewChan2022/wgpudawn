SKIP: FAILED

[numthreads(1, 1, 1)]
void unused_entry_point() {
  return;
}

static float16_t t = float16_t(0.0h);

vector<float16_t, 2> m() {
  t = float16_t(1.0h);
  return vector<float16_t, 2>((t).xx);
}

void f() {
  const vector<float16_t, 2> tint_symbol = m();
  float2 v = float2(tint_symbol);
}
FXC validation failure:
D:\Projects\RampUp\dawn\test\tint\expressions\type_conv\Shader@0x0000028C31298CE0(6,8-16): error X3000: unrecognized identifier 'float16_t'

