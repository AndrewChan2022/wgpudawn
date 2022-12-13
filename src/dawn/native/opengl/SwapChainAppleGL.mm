//
//  SwapChainAppleGL.cpp
//  dawn_native
//
//  Created by kai chen on 12/12/22.
//

#include "SwapChainAppleGL.h"
#include "dawn/common/Platform.h"

#if DAWN_PLATFORM_IS(MACOS)
#include <AppKit/AppKit.h>
#endif

namespace dawn::native::opengl {

void macos_present() {
#if DAWN_PLATFORM_IS(MACOS)
    NSOpenGLContext* context = NSOpenGLContext.currentContext;
    if (context != nullptr) {
        [context flushBuffer];
    }
#endif
}
}
