fn frexp_6fb3ad() {
  const arg_0 = vec2(1.0);
  var res = frexp(arg_0);
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  frexp_6fb3ad();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  frexp_6fb3ad();
}

@compute @workgroup_size(1)
fn compute_main() {
  frexp_6fb3ad();
}
