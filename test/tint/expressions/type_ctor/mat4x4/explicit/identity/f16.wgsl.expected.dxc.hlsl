[numthreads(1, 1, 1)]
void unused_entry_point() {
  return;
}

static matrix<float16_t, 4, 4> m = matrix<float16_t, 4, 4>(vector<float16_t, 4>(float16_t(0.0h), float16_t(1.0h), float16_t(2.0h), float16_t(3.0h)), vector<float16_t, 4>(float16_t(4.0h), float16_t(5.0h), float16_t(6.0h), float16_t(7.0h)), vector<float16_t, 4>(float16_t(8.0h), float16_t(9.0h), float16_t(10.0h), float16_t(11.0h)), vector<float16_t, 4>(float16_t(12.0h), float16_t(13.0h), float16_t(14.0h), float16_t(15.0h)));

matrix<float16_t, 4, 4> f() {
  const matrix<float16_t, 4, 4> m_1 = matrix<float16_t, 4, 4>(m);
  return m_1;
}
