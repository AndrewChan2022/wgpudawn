[numthreads(1, 1, 1)]
void unused_entry_point() {
  return;
}

struct S {
  float3 v;
};

static S P = (S)0;

void f() {
  float3 v = P.v;
  float x = P.v.x;
  float y = P.v.y;
  float z = P.v.z;
  float2 xx = P.v.xx;
  float2 xy = P.v.xy;
  float2 xz = P.v.xz;
  float2 yx = P.v.yx;
  float2 yy = P.v.yy;
  float2 yz = P.v.yz;
  float2 zx = P.v.zx;
  float2 zy = P.v.zy;
  float2 zz = P.v.zz;
  float3 xxx = P.v.xxx;
  float3 xxy = P.v.xxy;
  float3 xxz = P.v.xxz;
  float3 xyx = P.v.xyx;
  float3 xyy = P.v.xyy;
  float3 xyz = P.v.xyz;
  float3 xzx = P.v.xzx;
  float3 xzy = P.v.xzy;
  float3 xzz = P.v.xzz;
  float3 yxx = P.v.yxx;
  float3 yxy = P.v.yxy;
  float3 yxz = P.v.yxz;
  float3 yyx = P.v.yyx;
  float3 yyy = P.v.yyy;
  float3 yyz = P.v.yyz;
  float3 yzx = P.v.yzx;
  float3 yzy = P.v.yzy;
  float3 yzz = P.v.yzz;
  float3 zxx = P.v.zxx;
  float3 zxy = P.v.zxy;
  float3 zxz = P.v.zxz;
  float3 zyx = P.v.zyx;
  float3 zyy = P.v.zyy;
  float3 zyz = P.v.zyz;
  float3 zzx = P.v.zzx;
  float3 zzy = P.v.zzy;
  float3 zzz = P.v.zzz;
  float4 xxxx = P.v.xxxx;
  float4 xxxy = P.v.xxxy;
  float4 xxxz = P.v.xxxz;
  float4 xxyx = P.v.xxyx;
  float4 xxyy = P.v.xxyy;
  float4 xxyz = P.v.xxyz;
  float4 xxzx = P.v.xxzx;
  float4 xxzy = P.v.xxzy;
  float4 xxzz = P.v.xxzz;
  float4 xyxx = P.v.xyxx;
  float4 xyxy = P.v.xyxy;
  float4 xyxz = P.v.xyxz;
  float4 xyyx = P.v.xyyx;
  float4 xyyy = P.v.xyyy;
  float4 xyyz = P.v.xyyz;
  float4 xyzx = P.v.xyzx;
  float4 xyzy = P.v.xyzy;
  float4 xyzz = P.v.xyzz;
  float4 xzxx = P.v.xzxx;
  float4 xzxy = P.v.xzxy;
  float4 xzxz = P.v.xzxz;
  float4 xzyx = P.v.xzyx;
  float4 xzyy = P.v.xzyy;
  float4 xzyz = P.v.xzyz;
  float4 xzzx = P.v.xzzx;
  float4 xzzy = P.v.xzzy;
  float4 xzzz = P.v.xzzz;
  float4 yxxx = P.v.yxxx;
  float4 yxxy = P.v.yxxy;
  float4 yxxz = P.v.yxxz;
  float4 yxyx = P.v.yxyx;
  float4 yxyy = P.v.yxyy;
  float4 yxyz = P.v.yxyz;
  float4 yxzx = P.v.yxzx;
  float4 yxzy = P.v.yxzy;
  float4 yxzz = P.v.yxzz;
  float4 yyxx = P.v.yyxx;
  float4 yyxy = P.v.yyxy;
  float4 yyxz = P.v.yyxz;
  float4 yyyx = P.v.yyyx;
  float4 yyyy = P.v.yyyy;
  float4 yyyz = P.v.yyyz;
  float4 yyzx = P.v.yyzx;
  float4 yyzy = P.v.yyzy;
  float4 yyzz = P.v.yyzz;
  float4 yzxx = P.v.yzxx;
  float4 yzxy = P.v.yzxy;
  float4 yzxz = P.v.yzxz;
  float4 yzyx = P.v.yzyx;
  float4 yzyy = P.v.yzyy;
  float4 yzyz = P.v.yzyz;
  float4 yzzx = P.v.yzzx;
  float4 yzzy = P.v.yzzy;
  float4 yzzz = P.v.yzzz;
  float4 zxxx = P.v.zxxx;
  float4 zxxy = P.v.zxxy;
  float4 zxxz = P.v.zxxz;
  float4 zxyx = P.v.zxyx;
  float4 zxyy = P.v.zxyy;
  float4 zxyz = P.v.zxyz;
  float4 zxzx = P.v.zxzx;
  float4 zxzy = P.v.zxzy;
  float4 zxzz = P.v.zxzz;
  float4 zyxx = P.v.zyxx;
  float4 zyxy = P.v.zyxy;
  float4 zyxz = P.v.zyxz;
  float4 zyyx = P.v.zyyx;
  float4 zyyy = P.v.zyyy;
  float4 zyyz = P.v.zyyz;
  float4 zyzx = P.v.zyzx;
  float4 zyzy = P.v.zyzy;
  float4 zyzz = P.v.zyzz;
  float4 zzxx = P.v.zzxx;
  float4 zzxy = P.v.zzxy;
  float4 zzxz = P.v.zzxz;
  float4 zzyx = P.v.zzyx;
  float4 zzyy = P.v.zzyy;
  float4 zzyz = P.v.zzyz;
  float4 zzzx = P.v.zzzx;
  float4 zzzy = P.v.zzzy;
  float4 zzzz = P.v.zzzz;
}
