fn main_1() {
  var m : mat3x3<f32> = mat3x3<f32>();
  m = mat3x3<f32>(vec3<f32>(1.0f, 2.0f, 3.0f), vec3<f32>(4.0f, 5.0f, 6.0f), vec3<f32>(7.0f, 8.0f, 9.0f));
  m[1i] = vec3<f32>(5.0f, 5.0f, 5.0f);
  return;
}

@compute @workgroup_size(1i, 1i, 1i)
fn main() {
  main_1();
}
