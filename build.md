
- [origin reference](#origin-reference)
- [get code](#get-code)
- [build for each platform](#build-for-each-platform)
  - [needed lib versions](#needed-lib-versions)
  - [collection lib list](#collection-lib-list)
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


## needed lib versions

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

## collection lib list

    libtint.a
        libtint.a 
        libtint_diagnostic_utils.a

    libdawn.a
        libdawn_sample_utils.a
        libdawn_utils.a
        libdawn_native.a
        libdawn_common.a
        libdawn_proc.a
        libdawn_platform.a
        libdawncpp_headers.a
        libdawn_headers.a
        libdawncpp.a
        libdawn_wire.a

    libabsl.a
        libabsl_str_format_internal.a
        libabsl_strings.a
        libabsl_strings_internal.a
        libabsl_base.a
        libabsl_spinlock_wait.a
        libabsl_int128.a
        libabsl_throw_delegate.a
        libabsl_raw_logging_internal.a
        libabsl_log_severity.a

    libSPIRV-Tools.a
        libSPIRV-Tools.a
        libSPIRV-Tools-opt.a

    libglslang.a
        libSPIRV.a 
        libglslang-default-resource-limits.a
        libglslang.a
        libMachineIndependent.a
        libOSDependent.a
        libGenericCodeGen.a
        libOGLCompiler.a

## build for ios from Xcode

    mkdir xcodegl && cd xcodegl
    cmake .. -GXcode -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_BUILD_TYPE=Release -DONLY_GL=1

    choose ios_demo wgputriangle
    choose scheme release and build

    # collection header and libs then merge libs
    cd ../buildresult
    ./collection.sh xcodegl iOS

## build for ios from make

    mkdir xcodegl && cd xcodegl
    cmake .. -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_BUILD_TYPE=Release -DONLY_GL=1

    make -j16

    # collection header and libs then merge libs
    cd ../buildresult
    ./collection.sh xcodegl iOS

## build for ios from ninja

    mkdir xcodegl && cd xcodegl
    cmake .. -GNinja -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_BUILD_TYPE=Release -DONLY_GL=1

    ninja -j16

    # collection header and libs then merge libs
    cd ../buildresult
    ./collection.sh xcodegl iOS

## build for android

    export ANDROID_NDK=/Users/xxxx/Library/Android/sdk/ndk/21.3.6528147

    mkdir xcodeandroid && cd xcodeandroid

    cmake .. \
    -DCMAKE_SYSTEM_NAME=Android \
    -DANDROID_PLATFORM=android-22 \
    -DANDROID_ABI="armeabi-v7a" \
    -DANDROID_NDK="$ANDROID_NDK" \
    -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
    -DCMAKE_ANDROID_STL_TYPE=gnustl_static \
    -DCMAKE_BUILD_TYPE=Release \
    -DONLY_GL=1

    make -j16

    # collection header and libs then merge libs
    cd ../buildresult
    ./collection.sh xcodeandroid Android32

    mkdir xcodeandroid && cd xcodeandroid

    cmake .. \
    -DCMAKE_SYSTEM_NAME=Android \
    -DANDROID_PLATFORM=android-22 \
    -DANDROID_ABI="arm64-v8a" \
    -DANDROID_NDK="$ANDROID_NDK" \
    -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
    -DCMAKE_ANDROID_STL_TYPE=gnustl_static \
    -DCMAKE_BUILD_TYPE=Release \
    -DONLY_GL=1

    make -j16

    # collection header and libs then merge libs
    cd ../buildresult
    ./collection.sh xcodeandroid Android64

## build for macos/linux/windows

    mkdir -p out/Release
    cd out/Release
    cmake ../.. -DCMAKE_BUILD_TYPE=Release -DONLY_GL=1
    make -j16

    # collection header and libs then merge libs
    cd ../buildresult
    ./collection.sh out/Release Windows
    or
    ./collection.sh out/Release macos
    or
    ./collection.sh out/Release Linux

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

