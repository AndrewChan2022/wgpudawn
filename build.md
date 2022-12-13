
- [origin reference](#origin-reference)
- [get code](#get-code)
- [build for each platform](#build-for-each-platform)
  - [needed libs](#needed-libs)
  - [build for ios from Xcode](#build-for-ios-from-xcode)
  - [build for ios from make](#build-for-ios-from-make)
  - [build for ios from ninja](#build-for-ios-from-ninja)
  - [build for android](#build-for-android)
  - [build for macos/linux/windows](#build-for-macoslinuxwindows)
- [build options](#build-options)
  - [backend options](#backend-options)
- [demo](#demo)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

# origin reference

https://dawn.googlesource.com/dawn

https://dawn.googlesource.com/dawn/+/HEAD/docs/building.md

# get code

    # Clone the repo as "wgpudawn"
    git clone git@code.soulapp-inc.cn:rendering/wgpudawn.git
    cd wgpudawn

    # switch to soul branch
    git checkout soul

    # Bootstrap the gclient configuration
    cp scripts/standalone.gclient .gclient

    # Fetch external dependencies and toolchains with gclient
    gclient sync

# build for each platform


## needed libs

        macos_gl
        win_gl
        linux_gl
        ios_gl
        android_gl

        macos_metal
        win_vulkan
        linux_vulkan
        ios_metal
        android_vulkan

        android_gl_vulkan


## build for ios from Xcode

    cmake .. -GXcode -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_BUILD_TYPE=Release -DONLY_GL=1

    choose ios_demo wgputriangle
    choose scheme release and build

    run bash shell to collection header and lib

## build for ios from make

    cmake .. -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_BUILD_TYPE=Release -DONLY_GL=1

    make -j16

    run bash shell to collection header and lib

## build for ios from ninja

    cmake .. -GNinja -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_BUILD_TYPE=Release -DONLY_GL=1

    ninja -j16

    run bash shell to collection header and lib

## build for android

    export ANDROID_NDK=/Users/xxxx/Library/Android/sdk/ndk/21.3.6528147

    cmake .. \
    -DCMAKE_SYSTEM_NAME=Android \
    -DANDROID_PLATFORM=android-22 \
    -DANDROID_ABI="arm64-v8a" \
    -DANDROID_NDK="$ANDROID_NDK" \
    -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
    -DCMAKE_ANDROID_STL_TYPE=gnustl_static \
    -DONLY_GL=1

    make -j16

    run bash shell to collection header and lib

## build for macos/linux/windows

    mkdir -p out/Release
    cd out/Release
    cmake ../.. -DCMAKE_BUILD_TYPE=Release -DONLY_GL=1
    make -j16

    run bash shell to collection header and lib

# build options

## backend options

    // only OpenGL
    -DONLY_GL=1

    // only Metal
    -DONLY_METAL=1

    // only Vulkan
    -DONLY_VULKAN=1

    // both OpenGL and Vulkan
    -DBOTH_GL_VULKAN=1

# demo

    ios demo:  wgputriangle
    macos/linux/windows: cpptriangle
    android demo: no now

