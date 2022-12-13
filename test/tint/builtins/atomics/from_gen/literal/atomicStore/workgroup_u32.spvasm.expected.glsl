#version 310 es

uint local_invocation_index_1 = 0u;
shared uint arg_0;
void atomicStore_726882() {
  atomicExchange(arg_0, 1u);
  return;
}

void compute_main_inner(uint local_invocation_index) {
  atomicExchange(arg_0, 0u);
  barrier();
  atomicStore_726882();
  return;
}

void compute_main_1() {
  uint x_28 = local_invocation_index_1;
  compute_main_inner(x_28);
  return;
}

void compute_main(uint local_invocation_index_1_param) {
  {
    atomicExchange(arg_0, 0u);
  }
  barrier();
  local_invocation_index_1 = local_invocation_index_1_param;
  compute_main_1();
}

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main() {
  compute_main(gl_LocalInvocationIndex);
  return;
}
