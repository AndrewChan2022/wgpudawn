fn acosh_9f213e() {
  const arg_0 = vec3(2.0);
  var res = acosh(arg_0);
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  acosh_9f213e();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  acosh_9f213e();
}

@compute @workgroup_size(1)
fn compute_main() {
  acosh_9f213e();
}
