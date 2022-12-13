

#if [ -z "${BUILD_DIR}" ]
#    echo "please export BUILD_DIR=xxxx"
#fi


if [ "$#" == "2" ]; then
    buildpath="$1";
    platform="$2"
else
    a=1
    echo "./collection.sh buildpath platform"
    echo "platform: macos, iOS, Android, Linux, Windows"
    exit 1
fi

# check buildpath
if [ -d "${buildpath}" ]; then
    a=1
else
    echo "./collection.sh buildpath platform"
    echo "platform: macos, iOS, Android, Linux, Windows"
    echo "error: buildpath ${buildpath} not exist"
    exit -1
fi

# check platform
if [ "${platform}" == "Android" || "${platform}" == "iOS" || "${platform}" == "macos" || "${platform}" == "Linux" || "${platform}" == "Windows" ]; then
    a=1
else 
    echo "./collection.sh buildpath platform"
    echo "error: platform: macos, iOS, Android, Linux, Windows"
fi


############# collection headers
echo "colletion headers ..."

cp ../include ./include

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

mkdir raw/${platform}
mkdir merged/${platform}

if [ "${platform}" == "iOS" ]; then

    echo "colletion iOS libs ..."

    #dawn
    cp  ${buildpath}/src/dawn/samples/Release-iphoneos/libdawn_sample_utils.a raw/${platform}/
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

if [ "${platform}" == "Android" ]; then

    echo "colletion Android Armv7 libs ..."

    echo "colletion Android Arm64 libs ..."

fi


if [ "${platform}" == "macos" ]; then

    echo "colletion macos libs ..."
fi


if [ "${platform}" == "Linux" ]; then
    echo "colletion Linux libs ..."
fi

if [ "${platform}" == "Windows" ]; then
    echo "colletion Windows libs ..."
fi

############# merge libs

rm -rf merged/${platform}/dawn
mkdir merged/${platform}/dawn

if [ "${platform}" == "iOS" ]; then
    echo "merge iOS libs ..."

    libtool -no_warning_for_no_symbols -static -o  merged/${platform}/dawn/libtint.a \
    raw/${platform}/libtint.a raw/${platform}/libtint_diagnostic_utils.a

    libtool -no_warning_for_no_symbols -static -o  merged/${platform}/dawn/libdawn.a \
    raw/${platform}/libdawn_sample_utils.a raw/${platform}/libdawn_utils.a \
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

if [ "${platform}" == "Android" ]; then
    echo "merge Android libs ..."
fi

if [ "${platform}" == "macos" ]; then
    echo "merge macos libs ..."
fi

if [ "${platform}" == "Linux" ]; then
    echo "merge Linux libs ..."
fi

if [ "${platform}" == "Windows" ]; then
    echo "merge Windows libs ..."
fi