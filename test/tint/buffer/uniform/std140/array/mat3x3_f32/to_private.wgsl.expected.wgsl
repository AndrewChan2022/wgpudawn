@group(0) @binding(0) var<uniform> u : array<mat3x3<f32>, 4>;

var<private> p : array<mat3x3<f32>, 4>;

@compute @workgroup_size(1)
fn f() {
  p = u;
  p[1] = u[2];
  p[1][0] = u[0][1].zxy;
  p[1][0].x = u[0][1].x;
}
