

#if [ -z "${BUILD_DIR}" ]
#    echo "please export BUILD_DIR=xxxx"
#fi


if [ "$#" == "2" ]; then
    buildpath="$1";
    platform="$2"
    echo "buildpath:${buildpath}"
    echo "platform:${platform}"
else
    a=1
    echo "./collection.sh buildpath platform"
    echo "platform: Android32, Android64, iOS, macos, Linux, Windows"
    exit 1
fi

# check buildpath
if [ -d "${buildpath}" ]; then
    a=1
else
    echo "./collection.sh buildpath platform"
    echo "platform: Android32, Android64, iOS, macos, Linux, Windows"
    echo "error: buildpath ${buildpath} not exist"
    exit -1
fi

# check platform
if  [ "${platform}" == "Android32" ] || \
    [ "${platform}" == "Android64" ] || \
    [ "${platform}" == "iOS" ] || \
    [ "${platform}" == "macos" ] || \
    [ "${platform}" == "Linux" ] || \
    [ "${platform}" == "Windows" ]; then
    a=1
else 
    echo "./collection.sh buildpath platform"
    echo "platform: Android32, Android64, iOS, macos, Linux, Windows"
    echo "error: unkown platform"
    exit -1
fi

if [ "${platform}" == "Windows" ]; then
    echo "please run collection.bat for windows platform"
    exit -1
fi

if [ "${platform}" == "Android32" ] || ["${platform}" == "Android64" ]; then
    if [[ -n "${NDK/[ ]*\n/}" ]]; then
        echo "NDK: $NDK"
    else
        if [ -d "${HOME}/Library/Android/sdk/ndk/21.3.6528147" ]
        then
            NDK="${HOME}/Library/Android/sdk/ndk/21.3.6528147"
            echo "NDK: $NDK"
        else
            echo "no NDK, please run export NDK=~/Library/Android/sdk/ndk/21.xxxx"
            exit -1
        fi
    fi
fi

############# collection headers
echo "colletion headers ..."

rm -rf ./include
cp -r ../include ./

cp ${buildpath}/gen/include/dawn/webgpu.h  ./include/

cp ${buildpath}/gen/include/dawn/webgpu_cpp.h ./include/dawn/
cp ${buildpath}/gen/include/dawn/dawn_proc_table.h ./include/dawn/
cp ${buildpath}/gen/include/dawn/webgpu_cpp_print.h ./include/dawn/

mkdir ./include/dawn/utils
cp ../src/dawn/utils/WGPUHelpers.h ./include/dawn/utils/
cp ../src/dawn/utils/WGPUPrivateHelpers.h ./include/dawn/utils/
cp ../src/dawn/utils/TextureUtils.h ./include/dawn/utils/
cp ../src/dawn/utils/ComboRenderPipelineDescriptor.h ./include/dawn/utils/

mkdir ./include/dawn/common
cp ../src/dawn/common/Assert.h ./include/dawn/common/
cp ../src/dawn/common/Compiler.h ./include/dawn/common/
cp ../src/dawn/common/Constants.h ./include/dawn/common/

############# collection libs

if [ ! -d "raw" ]; then
    mkdir raw
fi

if [ ! -d "merged" ]; then
    mkdir merged
fi

rm -rf raw/${platform}
rm -rf merged/${platform}
mkdir raw/${platform}
mkdir merged/${platform}

if [ "${platform}" == "iOS" ]; then

    echo "colletion iOS libs ..."

    #dawn
    #cp  ${buildpath}/src/dawn/samples/Release-iphoneos/libdawn_sample_utils.a raw/${platform}/
    cp  ${buildpath}/src/dawn/Release-iphoneos/libdawncpp.a raw/${platform}/
    cp  ${buildpath}/src/dawn/utils/Release-iphoneos/libdawn_utils.a raw/${platform}/
    cp  ${buildpath}/src/dawn/Release-iphoneos/libdawn_proc.a raw/${platform}/
    cp  ${buildpath}/src/dawn/native/Release-iphoneos/libdawn_native.a raw/${platform}/
    cp  ${buildpath}/src/dawn/platform/Release-iphoneos/libdawn_platform.a raw/${platform}/
    cp  ${buildpath}/src/dawn/wire/Release-iphoneos/libdawn_wire.a raw/${platform}/
    cp  ${buildpath}/src/dawn/common/Release-iphoneos/libdawn_common.a raw/${platform}/
    cp  ${buildpath}/src/dawn/Release-iphoneos/libdawncpp_headers.a raw/${platform}/
    cp  ${buildpath}/src/dawn/Release-iphoneos/libdawn_headers.a raw/${platform}/


    # tint
    cp  ${buildpath}/src/tint/Release-iphoneos/libtint.a raw/${platform}/
    cp  ${buildpath}/src/tint/Release-iphoneos/libtint_diagnostic_utils.a raw/${platform}/

    # absl
    cp  ${buildpath}/third_party/abseil/absl/strings/Release-iphoneos/libabsl_str_format_internal.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/strings/Release-iphoneos/libabsl_strings.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/strings/Release-iphoneos/libabsl_strings_internal.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/Release-iphoneos/libabsl_base.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/Release-iphoneos/libabsl_spinlock_wait.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/numeric/Release-iphoneos/libabsl_int128.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/Release-iphoneos/libabsl_throw_delegate.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/Release-iphoneos/libabsl_raw_logging_internal.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/Release-iphoneos/libabsl_log_severity.a raw/${platform}/

    # spirv
    cp  ${buildpath}/third_party/spirv-tools/source/opt/Release-iphoneos/libSPIRV-Tools-opt.a raw/${platform}/
    cp  ${buildpath}/third_party/spirv-tools/source/Release-iphoneos/libSPIRV-Tools.a raw/${platform}/

    # glslang
    cp  ${buildpath}/third_party/glslang/SPIRV/Release-iphoneos/libSPIRV.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/StandAlone/Release-iphoneos/libglslang-default-resource-limits.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/glslang/Release-iphoneos/libglslang.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/glslang/Release-iphoneos/libMachineIndependent.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/glslang/OSDependent/Unix/Release-iphoneos/libOSDependent.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/glslang/Release-iphoneos/libGenericCodeGen.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/OGLCompilersDLL/Release-iphoneos/libOGLCompiler.a raw/${platform}/

fi

if [ "${platform}" == "Android32" ] || [ "${platform}" == "Android64" ]; then

    echo "colletion ${platform} libs ..."

    #dawn
    #cp  ${buildpath}/src/dawn/samples/libdawn_sample_utils.a raw/${platform}/
    cp  ${buildpath}/src/dawn/libdawncpp.a raw/${platform}/
    cp  ${buildpath}/src/dawn/utils/libdawn_utils.a raw/${platform}/
    cp  ${buildpath}/src/dawn/libdawn_proc.a raw/${platform}/
    cp  ${buildpath}/src/dawn/native/libdawn_native.a raw/${platform}/
    cp  ${buildpath}/src/dawn/platform/libdawn_platform.a raw/${platform}/
    cp  ${buildpath}/src/dawn/wire/libdawn_wire.a raw/${platform}/
    cp  ${buildpath}/src/dawn/common/libdawn_common.a raw/${platform}/
    cp  ${buildpath}/src/dawn/libdawncpp_headers.a raw/${platform}/
    cp  ${buildpath}/src/dawn/libdawn_headers.a raw/${platform}/


    # tint
    cp  ${buildpath}/src/tint/libtint.a raw/${platform}/
    cp  ${buildpath}/src/tint/libtint_diagnostic_utils.a raw/${platform}/

    # absl
    cp  ${buildpath}/third_party/abseil/absl/strings/libabsl_str_format_internal.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/strings/libabsl_strings.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/strings/libabsl_strings_internal.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/libabsl_base.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/libabsl_spinlock_wait.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/numeric/libabsl_int128.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/libabsl_throw_delegate.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/libabsl_raw_logging_internal.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/libabsl_log_severity.a raw/${platform}/

    # spirv
    cp  ${buildpath}/third_party/spirv-tools/source/opt/libSPIRV-Tools-opt.a raw/${platform}/
    cp  ${buildpath}/third_party/spirv-tools/source/libSPIRV-Tools.a raw/${platform}/

    # glslang
    cp  ${buildpath}/third_party/glslang/SPIRV/libSPIRV.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/StandAlone/libglslang-default-resource-limits.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/glslang/libglslang.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/glslang/libMachineIndependent.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/glslang/OSDependent/Unix/libOSDependent.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/glslang/libGenericCodeGen.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/OGLCompilersDLL/libOGLCompiler.a raw/${platform}/


fi


if [ "${platform}" == "macos" ]; then

    echo "colletion macos libs ..."
    #dawn
    #cp  ${buildpath}/src/dawn/samples/Release/libdawn_sample_utils.a raw/${platform}/
    cp  ${buildpath}/src/dawn/Release/libdawncpp.a raw/${platform}/
    cp  ${buildpath}/src/dawn/utils/Release/libdawn_utils.a raw/${platform}/
    cp  ${buildpath}/src/dawn/Release/libdawn_proc.a raw/${platform}/
    cp  ${buildpath}/src/dawn/native/Release/libdawn_native.a raw/${platform}/
    cp  ${buildpath}/src/dawn/platform/Release/libdawn_platform.a raw/${platform}/
    cp  ${buildpath}/src/dawn/wire/Release/libdawn_wire.a raw/${platform}/
    cp  ${buildpath}/src/dawn/common/Release/libdawn_common.a raw/${platform}/
    cp  ${buildpath}/src/dawn/Release/libdawncpp_headers.a raw/${platform}/
    cp  ${buildpath}/src/dawn/Release/libdawn_headers.a raw/${platform}/


    # tint
    cp  ${buildpath}/src/tint/Release/libtint.a raw/${platform}/
    cp  ${buildpath}/src/tint/Release/libtint_diagnostic_utils.a raw/${platform}/

    # absl
    cp  ${buildpath}/third_party/abseil/absl/strings/Release/libabsl_str_format_internal.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/strings/Release/libabsl_strings.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/strings/Release/libabsl_strings_internal.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/Release/libabsl_base.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/Release/libabsl_spinlock_wait.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/numeric/Release/libabsl_int128.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/Release/libabsl_throw_delegate.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/Release/libabsl_raw_logging_internal.a raw/${platform}/
    cp  ${buildpath}/third_party/abseil/absl/base/Release/libabsl_log_severity.a raw/${platform}/

    # spirv
    cp  ${buildpath}/third_party/spirv-tools/source/opt/Release/libSPIRV-Tools-opt.a raw/${platform}/
    cp  ${buildpath}/third_party/spirv-tools/source/Release/libSPIRV-Tools.a raw/${platform}/

    # glslang
    cp  ${buildpath}/third_party/glslang/SPIRV/Release/libSPIRV.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/StandAlone/Release/libglslang-default-resource-limits.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/glslang/Release/libglslang.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/glslang/Release/libMachineIndependent.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/glslang/OSDependent/Unix/Release/libOSDependent.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/glslang/Release/libGenericCodeGen.a raw/${platform}/
    cp  ${buildpath}/third_party/glslang/OGLCompilersDLL/Release/libOGLCompiler.a raw/${platform}/

fi


if [ "${platform}" == "Linux" ]; then
    echo "colletion Linux libs ..."

    echo "Linux not implement"
    exit 1
fi

if [ "${platform}" == "Windows" ]; then
    echo "colletion Windows libs ..."

    echo "please run collection.bat for windows platform"
    exit -1
fi

############# merge libs

rm -rf merged/${platform}/dawn
mkdir merged/${platform}/dawn

if [ "${platform}" == "iOS" ]; then
    echo "merge iOS libs ..."

    libtool -no_warning_for_no_symbols -static -o  merged/${platform}/dawn/libtint.a \
    raw/${platform}/libtint.a raw/${platform}/libtint_diagnostic_utils.a

    libtool -no_warning_for_no_symbols -static -o  merged/${platform}/dawn/libdawn.a \
    raw/${platform}/libdawn_utils.a \
    raw/${platform}/libdawn_native.a raw/${platform}/libdawn_common.a raw/${platform}/libdawn_proc.a \
    raw/${platform}/libdawn_platform.a \
    raw/${platform}/libdawncpp_headers.a  raw/${platform}/libdawn_headers.a  raw/${platform}/libdawncpp.a \
    raw/${platform}/libdawn_wire.a

    libtool -no_warning_for_no_symbols -static -o  merged/${platform}/dawn/libabsl.a \
    raw/${platform}/libabsl_str_format_internal.a raw/${platform}/libabsl_strings.a \
    raw/${platform}/libabsl_strings_internal.a raw/${platform}/libabsl_base.a \
    raw/${platform}/libabsl_spinlock_wait.a raw/${platform}/libabsl_int128.a \
    raw/${platform}/libabsl_throw_delegate.a raw/${platform}/libabsl_raw_logging_internal.a \
    raw/${platform}/libabsl_log_severity.a 

    libtool -no_warning_for_no_symbols -static -o  merged/${platform}/dawn/libSPIRV-Tools.a \
    raw/${platform}/libSPIRV-Tools.a raw/${platform}/libSPIRV-Tools-opt.a


    libtool -no_warning_for_no_symbols -static -o  merged/${platform}/dawn/libglslang.a \
    raw/${platform}/libSPIRV.a raw/${platform}/libglslang-default-resource-limits.a \
    raw/${platform}/libglslang.a raw/${platform}/libMachineIndependent.a \
    raw/${platform}/libOSDependent.a raw/${platform}/libGenericCodeGen.a \
    raw/${platform}/libOGLCompiler.a
fi

if [ "${platform}" == "Android32" ] || [ "${platform}" == "Android64" ]; then
    echo "merge ${platform} libs ..."

    NDK_PATH=$NDK
    #echo "NDK_PATH:${NDK_PATH}"
    alias armv7strip='${NDK_PATH}/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-strip'
    alias arm64strip='${NDK_PATH}/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/aarch64-linux-android/bin/strip'
    alias armv7ar='${NDK_PATH}/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-ar'
    alias arm64ar='${NDK_PATH}/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/aarch64-linux-android/bin/ar'

    if [ "${platform}" == "Android32" ]; then
        alias armstrip="${NDK_PATH}/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-strip"
        alias armar="${NDK_PATH}/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-ar"
        armstrippath="${NDK_PATH}/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-strip"
        armarpath="${NDK_PATH}/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-ar"
    elif [ "${platform}" == "Android64" ]; then
        alias armstrip="${NDK_PATH}/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/aarch64-linux-android/bin/strip"
        alias armar="${NDK_PATH}/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/aarch64-linux-android/bin/ar"
        armstrippath="${NDK_PATH}/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/aarch64-linux-android/bin/strip"
        armarpath="${NDK_PATH}/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/aarch64-linux-android/bin/ar"
    fi

    ${armarpath} -rcT merged/${platform}/dawn/libtint.a \
    raw/${platform}/libtint.a raw/${platform}/libtint_diagnostic_utils.a

    ${armarpath} -rcT merged/${platform}/dawn/libdawn.a \
    raw/${platform}/libdawn_utils.a \
    raw/${platform}/libdawn_native.a raw/${platform}/libdawn_common.a raw/${platform}/libdawn_proc.a \
    raw/${platform}/libdawn_platform.a \
    raw/${platform}/libdawncpp_headers.a  raw/${platform}/libdawn_headers.a  raw/${platform}/libdawncpp.a \
    raw/${platform}/libdawn_wire.a

    ${armarpath} -rcT merged/${platform}/dawn/libabsl.a \
    raw/${platform}/libabsl_str_format_internal.a raw/${platform}/libabsl_strings.a \
    raw/${platform}/libabsl_strings_internal.a raw/${platform}/libabsl_base.a \
    raw/${platform}/libabsl_spinlock_wait.a raw/${platform}/libabsl_int128.a \
    raw/${platform}/libabsl_throw_delegate.a raw/${platform}/libabsl_raw_logging_internal.a \
    raw/${platform}/libabsl_log_severity.a 

    ${armarpath} -rcT merged/${platform}/dawn/libSPIRV-Tools.a \
    raw/${platform}/libSPIRV-Tools.a raw/${platform}/libSPIRV-Tools-opt.a

    ${armarpath} -rcT merged/${platform}/dawn/libglslang.a \
    raw/${platform}/libSPIRV.a raw/${platform}/libglslang-default-resource-limits.a \
    raw/${platform}/libglslang.a raw/${platform}/libMachineIndependent.a \
    raw/${platform}/libOSDependent.a raw/${platform}/libGenericCodeGen.a \
    raw/${platform}/libOGLCompiler.a

    #${armstrippath} merged/${platform}/dawn/libtint.a
    #${armstrippath} merged/${platform}/dawn/libdawn.a
    #${armstrippath} merged/${platform}/dawn/libabsl.a
    #${armstrippath} merged/${platform}/dawn/libSPIRV-Tools.a
    #${armstrippath} merged/${platform}/dawn/libglslang.a

fi

if [ "${platform}" == "macos" ]; then
    echo "merge macos libs ..."

    libtool -no_warning_for_no_symbols -static -o  merged/${platform}/dawn/libtint.a \
    raw/${platform}/libtint.a raw/${platform}/libtint_diagnostic_utils.a

    libtool -no_warning_for_no_symbols -static -o  merged/${platform}/dawn/libdawn.a \
    raw/${platform}/libdawn_utils.a \
    raw/${platform}/libdawn_native.a raw/${platform}/libdawn_common.a raw/${platform}/libdawn_proc.a \
    raw/${platform}/libdawn_platform.a \
    raw/${platform}/libdawncpp_headers.a  raw/${platform}/libdawn_headers.a  raw/${platform}/libdawncpp.a \
    raw/${platform}/libdawn_wire.a

    libtool -no_warning_for_no_symbols -static -o  merged/${platform}/dawn/libabsl.a \
    raw/${platform}/libabsl_str_format_internal.a raw/${platform}/libabsl_strings.a \
    raw/${platform}/libabsl_strings_internal.a raw/${platform}/libabsl_base.a \
    raw/${platform}/libabsl_spinlock_wait.a raw/${platform}/libabsl_int128.a \
    raw/${platform}/libabsl_throw_delegate.a raw/${platform}/libabsl_raw_logging_internal.a \
    raw/${platform}/libabsl_log_severity.a 

    libtool -no_warning_for_no_symbols -static -o  merged/${platform}/dawn/libSPIRV-Tools.a \
    raw/${platform}/libSPIRV-Tools.a raw/${platform}/libSPIRV-Tools-opt.a


    libtool -no_warning_for_no_symbols -static -o  merged/${platform}/dawn/libglslang.a \
    raw/${platform}/libSPIRV.a raw/${platform}/libglslang-default-resource-limits.a \
    raw/${platform}/libglslang.a raw/${platform}/libMachineIndependent.a \
    raw/${platform}/libOSDependent.a raw/${platform}/libGenericCodeGen.a \
    raw/${platform}/libOGLCompiler.a

fi

if [ "${platform}" == "Linux" ]; then
    echo "merge Linux libs ..."

    echo "Linux not implement"
    exit 1
fi

if [ "${platform}" == "Windows" ]; then
    echo "merge Windows libs ..."
fi