fn sign_926015() {
  var arg_0 = vec2<i32>(1i);
  var res : vec2<i32> = sign(arg_0);
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  sign_926015();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  sign_926015();
}

@compute @workgroup_size(1)
fn compute_main() {
  sign_926015();
}
