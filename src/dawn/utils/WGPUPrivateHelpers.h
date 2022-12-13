// Copyright 2017 The Dawn Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef SRC_DAWN_UTILS_WGPUPRIVATEHELPERS_H_
#define SRC_DAWN_UTILS_WGPUPRIVATEHELPERS_H_

#include <array>
#include <initializer_list>
#include <vector>

#include "dawn/common/Constants.h"
#include "dawn/utils/TextureUtils.h"
#include "dawn/webgpu_cpp.h"


namespace dawn::native::opengl {
#if defined(DAWN_ENABLE_BACKEND_OPENGLES) || defined(DAWN_ENABLE_BACKEND_DESKTOP_GL)
void SetGLGetProc(void* getproc);
uint32_t getGLTextureId(void* texture);
void* createGLTextureFromID(void* device,
                            void* descriptor,
                            uint32_t handle);
#endif
}

namespace utils {

#define LAST_ELEMENT_MARKER(x) x
enum class GLSLStage : uint32_t {  // should sync with glslang_stage_t
    VERTEX,
    TESSCONTROL,
    TESSEVALUATION,
    GEOMETRY,
    FRAGMENT,
    COMPUTE,
    RAYGEN,
    RAYGEN_NV = RAYGEN,
    INTERSECT,
    INTERSECT_NV =INTERSECT,
    ANYHIT,
    ANYHIT_NV = ANYHIT,
    CLOSESTHIT,
    CLOSESTHIT_NV = CLOSESTHIT,
    MISS,
    MISS_NV = MISS,
    CALLABLE,
    CALLABLE_NV = CALLABLE,
    TASK,
    TASK_NV = TASK,
    MESH,
    MESH_NV = MESH,
    LAST_ELEMENT_MARKER(COUNT),
};



wgpu::ShaderModule CreateShaderModuleFromGLSL(const wgpu::Device& device, GLSLStage stage, const char* source);
wgpu::ShaderModule CreateShaderModuleFromSPIRV(const wgpu::Device& device, std::vector<uint32_t>& source);

// init
bool WGPUInitWithGetProc(void* getproc = nullptr);

// set log
bool WGPUSetLogCallback(WGPUDevice cDevice, WGPUErrorCallback defaultCallback = nullptr);

void SetOpenGLGetProcFromInside();
void SetOpenGLGetProcFromGLFW(void* getproc);

wgpu::Texture createGLTextureFromID(uint32_t textureID);
uint32_t getGLTextureId(wgpu::Texture& texture);

}  // namespace utils

#endif  // SRC_DAWN_UTILS_WGPUHELPERSPRIVATE_H_
