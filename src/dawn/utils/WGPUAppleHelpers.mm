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

#include <cstring>
#include <iomanip>
#include <limits>
#include <mutex>
#include <sstream>

#include "dawn/common/Constants.h"
#include "dawn/common/Log.h"
#include "dawn/common/Numeric.h"


#include <CoreFoundation/CoreFoundation.h>
#include <QuartzCore/CALayer.h>




namespace utils {

static CFBundleRef s_framework;
static void* _apple_getglesproc(const char* procname) {
    CFStringRef symbolName = CFStringCreateWithCString(kCFAllocatorDefault, procname, kCFStringEncodingASCII);
    auto symbol = CFBundleGetFunctionPointerForName(s_framework, symbolName);
    CFRelease(symbolName);
    return symbol;
}
static void* _apple_getglproc(const char* procname) {
    CFStringRef symbolName = CFStringCreateWithCString(kCFAllocatorDefault, procname, kCFStringEncodingASCII);
    auto symbol = CFBundleGetFunctionPointerForName(s_framework, symbolName);
    CFRelease(symbolName);
    return symbol;
}

void SetAppleOpenGLGetProc() {
    // DAWN_ENABLE_BACKEND_DESKTOP_GL || DAWN_ENABLE_BACKEND_OPENGLES => DAWN_ENABLE_BACKEND_OPENGL
#if defined(DAWN_ENABLE_BACKEND_OPENGLES)
    s_framework = CFBundleGetBundleWithIdentifier(CFSTR("com.apple.opengles"));
    dawn::native::opengl::SetGLGetProc((void*)_apple_getglesproc);
#elif defined(DAWN_ENABLE_BACKEND_DESKTOP_GL)
    s_framework = CFBundleGetBundleWithIdentifier(CFSTR("com.apple.opengl"));
    dawn::native::opengl::SetGLGetProc((void*)_apple_getglproc);
#endif
}

}  // namespace utils
