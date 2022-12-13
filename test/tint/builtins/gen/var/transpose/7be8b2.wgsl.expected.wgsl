enable f16;

fn transpose_7be8b2() {
  var arg_0 = mat2x2<f16>(1.0h, 1.0h, 1.0h, 1.0h);
  var res : mat2x2<f16> = transpose(arg_0);
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  transpose_7be8b2();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  transpose_7be8b2();
}

@compute @workgroup_size(1)
fn compute_main() {
  transpose_7be8b2();
}
