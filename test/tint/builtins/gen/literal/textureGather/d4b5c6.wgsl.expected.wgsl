@group(1) @binding(1) var arg_1 : texture_cube_array<u32>;

@group(1) @binding(2) var arg_2 : sampler;

fn textureGather_d4b5c6() {
  var res : vec4<u32> = textureGather(1u, arg_1, arg_2, vec3<f32>(1.0f), 1i);
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  textureGather_d4b5c6();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  textureGather_d4b5c6();
}

@compute @workgroup_size(1)
fn compute_main() {
  textureGather_d4b5c6();
}
