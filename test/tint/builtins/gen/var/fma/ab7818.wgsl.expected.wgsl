enable f16;

fn fma_ab7818() {
  var arg_0 = vec4<f16>(1.0h);
  var arg_1 = vec4<f16>(1.0h);
  var arg_2 = vec4<f16>(1.0h);
  var res : vec4<f16> = fma(arg_0, arg_1, arg_2);
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  fma_ab7818();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  fma_ab7818();
}

@compute @workgroup_size(1)
fn compute_main() {
  fma_ab7818();
}
