cbuffer cbuffer_m : register(b0, space0) {
  uint4 m[2];
};
static int counter = 0;

int i() {
  counter = (counter + 1);
  return counter;
}

float2x3 tint_symbol(uint4 buffer[2], uint offset) {
  const uint scalar_offset = ((offset + 0u)) / 4;
  const uint scalar_offset_1 = ((offset + 16u)) / 4;
  return float2x3(asfloat(buffer[scalar_offset / 4].xyz), asfloat(buffer[scalar_offset_1 / 4].xyz));
}

[numthreads(1, 1, 1)]
void f() {
  const int p_m_i_save = i();
  const float2x3 l_m = tint_symbol(m, 0u);
  const uint scalar_offset_2 = ((16u * uint(p_m_i_save))) / 4;
  const float3 l_m_i = asfloat(m[scalar_offset_2 / 4].xyz);
  return;
}
