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

#include "dawn/native/opengl/SwapChainGL.h"

#include "dawn/native/opengl/DeviceGL.h"
#include "dawn/native/opengl/Forward.h"
#include "dawn/native/opengl/TextureGL.h"
#include "dawn/native/opengl/SwapChainAppleGL.h"
#include "dawn/native/Surface.h"

#include "dawn/dawn_wsi.h"

#if DAWN_PLATFORM_IS(WINDOWS)
#include <windowsx.h>
#endif

namespace dawn::native::opengl {

SwapChain::SwapChain(Device* device, const SwapChainDescriptor* descriptor)
    : OldSwapChainBase(device, descriptor) {
    const auto& im = GetImplementation();
    im.Init(im.userData, nullptr);
}

SwapChain::~SwapChain() {}

TextureBase* SwapChain::GetNextTextureImpl(const TextureDescriptor* descriptor) {
    const auto& im = GetImplementation();
    DawnSwapChainNextTexture next = {};
    DawnSwapChainError error = im.GetNextTexture(im.userData, &next);
    if (error) {
        GetDevice()->HandleError(InternalErrorType::Internal, error);
        return nullptr;
    }
    GLuint nativeTexture = next.texture.u32;
    return new Texture(ToBackend(GetDevice()), descriptor, nativeTexture,
                       TextureBase::TextureState::OwnedExternal);
}

MaybeError SwapChain::OnBeforePresent(TextureViewBase*) {
    return {};
}

NewSwapChain::NewSwapChain(Device* device, Surface* surface, const SwapChainDescriptor* descriptor)
    : NewSwapChainBase(device, surface, descriptor) {
}
NewSwapChain::~NewSwapChain() {}

ResultOrError<Ref<TextureViewBase>> NewSwapChain::GetCurrentTextureViewImpl() {
    printf("GetCurrentTextureViewImpl\n");
    
    if (mTexture == nullptr) {
        TextureDescriptor textureDesc = GetSwapChainBaseTextureDescriptor(this);
        const TextureDescriptor* descriptor = &textureDesc;
        GLuint handle = 0xffffffff;
        Device* device = (dawn::native::opengl::Device *)GetDevice();
        mTexture = AcquireRef(new Texture(device, descriptor, handle, TextureBase::TextureState::OwnedExternal));
        //mTexture = Texture::CreateWrapping(ToBackend(GetDevice()), &textureDesc, [*mCurrentDrawable texture]);
        //texture->InitializeAsWrapping(descriptor, std::move(wrapped));
    }
    
    return mTexture->CreateView();
}
MaybeError NewSwapChain::PresentImpl() {
    //printf("PresentImpl\n");

#if DAWN_PLATFORM_IS(MACOS)
    macos_present();
#elif DAWN_PLATFORM_IS(WINDOWS)
    HWND hwnd = (HWND)GetSurface()->GetHWND();
    HDC hdc = GetDC(hwnd);
    SwapBuffers(hdc);
    ReleaseDC(hwnd, hdc);
#else
    printf("only support swapchain for macos/windows\n");
    ASSERT(false);
#endif
    return {};
}
void NewSwapChain::DetachFromSurfaceImpl() {
    printf("DetachFromSurfaceImpl\n");
    
    if (mTexture != nullptr) {
        mTexture->APIDestroy();
        mTexture = nullptr;
    }
}

}  // namespace dawn::native::opengl
