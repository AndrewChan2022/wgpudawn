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

#include "dawn/utils/WGPUHelpers.h"
#include "dawn/utils/WGPUPrivateHelpers.h"
#include "dawn/utils/WGPUAppleHelpers.h"

#include "../../../third_party/vulkan-deps/glslang/src/glslang/Include/glslang_c_interface.h"
#include "../../../third_party/vulkan-deps/glslang/src/StandAlone/ResourceLimits.h"
//#include "../../../third_party/vulkan-deps/glslang/src/glslang/Public/ShaderLang.h"
#include "dawn/native/dawn_platform.h"
#include "dawn/dawn_proc.h"
#include "dawn/native/DawnNative.h"
#include "dawn/common/Platform.h"

#include <cstring>
#include <iomanip>
#include <limits>
#include <mutex>
#include <sstream>

#include "dawn/common/Constants.h"
#include "dawn/common/Log.h"
#include "dawn/common/Numeric.h"

#include "spirv-tools/optimizer.hpp"

// android
#if defined(DAWN_ENABLE_BACKEND_OPENGLES)
#if DAWN_PLATFORM_IS(ANDROID)
#include <EGL/egl.h>
#include <EGL/eglext.h>
#endif
#endif


static void PrintDeviceError(WGPUErrorType errorType, const char* message, void*) {
    const char* errorTypeName = "";
    switch (errorType) {
        case WGPUErrorType_Validation:
            errorTypeName = "Validation";
            break;
        case WGPUErrorType_OutOfMemory:
            errorTypeName = "Out of memory";
            break;
        case WGPUErrorType_Unknown:
            errorTypeName = "Unknown";
            break;
        case WGPUErrorType_DeviceLost:
            errorTypeName = "Device lost";
            break;
        default:
            errorTypeName = "unkwn errorType";
            //UNREACHABLE();
            return;
    }
    dawn::ErrorLog() << errorTypeName << " error: " << message;
    //std::cout << errorTypeName << " error: " << message << std::endl;
}

namespace utils {

std::vector<uint32_t> compileShaderToSPIRV_Vulkan(glslang_stage_t stage, const char* shaderSource, const char* fileName)
{
    const glslang_input_t input = {
        .language = GLSLANG_SOURCE_GLSL,
        .stage = stage,
        .client = GLSLANG_CLIENT_VULKAN,
        .client_version = GLSLANG_TARGET_VULKAN_1_1,
        .target_language = GLSLANG_TARGET_SPV,
        .target_language_version = GLSLANG_TARGET_SPV_1_3,
        .code = shaderSource,
        .default_version = 100,
        .default_profile = GLSLANG_NO_PROFILE,
        .force_default_version_and_profile = false,
        .forward_compatible = false,
        .messages = GLSLANG_MSG_DEFAULT_BIT,
        .resource = reinterpret_cast<const glslang_resource_t*>(&glslang::DefaultTBuiltInResource),
    };

    glslang_shader_t* shader = glslang_shader_create(&input);

    glslang_initialize_process();
    if (!glslang_shader_preprocess(shader, &input))    {
        printf("GLSL preprocessing failed %s\n", fileName);
        printf("%s\n", glslang_shader_get_info_log(shader));
        printf("%s\n", glslang_shader_get_info_debug_log(shader));
        printf("%s\n", input.code);
        glslang_shader_delete(shader);
        return std::vector<uint32_t>();
    }

    if (!glslang_shader_parse(shader, &input)) {
        printf("GLSL parsing failed %s\n", fileName);
        printf("%s\n", glslang_shader_get_info_log(shader));
        printf("%s\n", glslang_shader_get_info_debug_log(shader));
        printf("%s\n", glslang_shader_get_preprocessed_code(shader));
        glslang_shader_delete(shader);
        return std::vector<uint32_t>();
    }

    glslang_program_t* program = glslang_program_create();
    glslang_program_add_shader(program, shader);

    if (!glslang_program_link(program, GLSLANG_MSG_SPV_RULES_BIT | GLSLANG_MSG_VULKAN_RULES_BIT)) {
        printf("GLSL linking failed %s\n", fileName);
        printf("%s\n", glslang_program_get_info_log(program));
        printf("%s\n", glslang_program_get_info_debug_log(program));
        glslang_program_delete(program);
        glslang_shader_delete(shader);
        return std::vector<uint32_t>();
    }

    glslang_program_SPIRV_generate(program, stage);

    std::vector<uint32_t> outShaderModule(glslang_program_SPIRV_get_size(program));
    glslang_program_SPIRV_get(program, outShaderModule.data());

    const char* spirv_messages = glslang_program_SPIRV_get_messages(program);
    if (spirv_messages)
        printf("(%s) %s\b", fileName, spirv_messages);

    glslang_program_delete(program);
    glslang_shader_delete(shader);

    return outShaderModule;
}

wgpu::ShaderModule CreateShaderModuleFromSPIRV(const wgpu::Device& device, std::vector<uint32_t>& source) {
    wgpu::ShaderModuleSPIRVDescriptor spirvDesc;
    spirvDesc.codeSize = static_cast<uint32_t>(source.size());
    spirvDesc.code = source.data();
    wgpu::ShaderModuleDescriptor descriptor;
    descriptor.nextInChain = &spirvDesc;
    
    return device.CreateShaderModule(&descriptor);
}

wgpu::ShaderModule CreateShaderModuleFromGLSL(const wgpu::Device& device, GLSLStage stage, const char* source) {
    glslang_stage_t estage = (glslang_stage_t)stage;
    auto spv = compileShaderToSPIRV_Vulkan(estage, source, "nofilename");
    return CreateShaderModuleFromSPIRV(device, spv);
}


wgpu::Texture createGLTextureFromID(void* device,
                                    void* descriptor,
                                    uint32_t textureID) {

#if defined(DAWN_ENABLE_BACKEND_OPENGLES) || defined(DAWN_ENABLE_BACKEND_DESKTOP_GL)
    WGPUTexture t = (WGPUTexture)dawn::native::opengl::createGLTextureFromID(device, descriptor, textureID);
    return wgpu::Texture::Acquire(t);
#else
    return wgpu::Texture::Acquire(nullptr);
#endif
}

uint32_t getGLTextureId(wgpu::Texture& texture) {
#if defined(DAWN_ENABLE_BACKEND_OPENGLES) || defined(DAWN_ENABLE_BACKEND_DESKTOP_GL)
    return dawn::native::opengl::getGLTextureId(texture.Get());
#else
    //dawn::native::TextureBase* textureBase = dawn::native::FromAPI(texture.Get());
    //dawn::native::opengl::Texture* texture = static_cast<dawn::native::opengl::Texture*>(textureBase);
    //return texture->GetHandle();
    return 0;
#endif
}


void SetOpenGLGetProcFromInside() {
#if defined(DAWN_ENABLE_BACKEND_OPENGLES) || defined(DAWN_ENABLE_BACKEND_DESKTOP_GL)
#if DAWN_PLATFORM_IS(APPLE)
    SetAppleOpenGLGetProc();
#elif DAWN_PLATFORM_IS(ANDROID)
    dawn::native::opengl::SetGLGetProc((void*)eglGetProcAddress);
#else
    ASSERT(false);
#endif // DAWN_PLATFORM_IS(IOS)
#endif // defined(DAWN_ENABLE_BACKEND_OPENGLES)...
}

void SetOpenGLGetProcFromGLFW(void* getproc) {
    dawn::native::opengl::SetGLGetProc(getproc);
}

bool WGPUInitWithGetProc(void* getproc) {
    
    // set opengl getproc
#if defined(DAWN_ENABLE_BACKEND_OPENGLES) || defined(DAWN_ENABLE_BACKEND_DESKTOP_GL)
    if (getproc != nullptr) {
        SetOpenGLGetProcFromGLFW(getproc);
    } else {
        SetOpenGLGetProcFromInside();
    }
#endif
    
    // use dawn::native
    DawnProcTable backendProcs = dawn::native::GetProcs();
    dawnProcSetProcs(&backendProcs);
}

bool WGPUSetLogCallback(WGPUDevice cDevice, WGPUErrorCallback defaultCallback) {
    DawnProcTable backendProcs = dawn::native::GetProcs();
    if (defaultCallback != nullptr) {
        backendProcs.deviceSetUncapturedErrorCallback(cDevice, defaultCallback, nullptr);
    } else {
        backendProcs.deviceSetUncapturedErrorCallback(cDevice, PrintDeviceError, nullptr);
    }
}

}  // namespace utils