@group(1) @binding(1) var arg_1 : texture_cube_array<i32>;

@group(1) @binding(2) var arg_2 : sampler;

fn textureGather_788010() {
  const arg_0 = 1i;
  var arg_3 = vec3<f32>(1.0f);
  var arg_4 = 1u;
  var res : vec4<i32> = textureGather(arg_0, arg_1, arg_2, arg_3, arg_4);
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  textureGather_788010();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  textureGather_788010();
}

@compute @workgroup_size(1)
fn compute_main() {
  textureGather_788010();
}
