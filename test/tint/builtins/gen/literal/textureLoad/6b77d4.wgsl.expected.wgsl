@group(1) @binding(0) var arg_0 : texture_1d<u32>;

fn textureLoad_6b77d4() {
  var res : vec4<u32> = textureLoad(arg_0, 1i, 1u);
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  textureLoad_6b77d4();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  textureLoad_6b77d4();
}

@compute @workgroup_size(1)
fn compute_main() {
  textureLoad_6b77d4();
}
