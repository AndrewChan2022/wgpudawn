@group(1) @binding(0) var arg_0 : texture_1d<f32>;

fn textureLoad_3da3ed() {
  var arg_1 = 1i;
  var arg_2 = 1u;
  var res : vec4<f32> = textureLoad(arg_0, arg_1, arg_2);
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  textureLoad_3da3ed();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  textureLoad_3da3ed();
}

@compute @workgroup_size(1)
fn compute_main() {
  textureLoad_3da3ed();
}
