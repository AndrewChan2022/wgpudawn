@group(1) @binding(0) var arg_0 : texture_2d_array<f32>;

@group(1) @binding(1) var arg_1 : sampler;

fn textureSampleGrad_7cd6de() {
  var arg_2 = vec2<f32>(1.0f);
  var arg_3 = 1u;
  var arg_4 = vec2<f32>(1.0f);
  var arg_5 = vec2<f32>(1.0f);
  const arg_6 = vec2<i32>(1i);
  var res : vec4<f32> = textureSampleGrad(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5, arg_6);
}

@vertex
fn vertex_main() -> @builtin(position) vec4<f32> {
  textureSampleGrad_7cd6de();
  return vec4<f32>();
}

@fragment
fn fragment_main() {
  textureSampleGrad_7cd6de();
}

@compute @workgroup_size(1)
fn compute_main() {
  textureSampleGrad_7cd6de();
}
