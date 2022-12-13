

echo off

if "%~1"=="" (
    @echo "collection.bat build_path"
    @echo "error:L no build_path"
    goto :eof
)

@echo "collection.bat build_path"

set buildpath=%1

@echo "###############################################"
@echo "######################## collection libs"

    Rem dawn
    Rem cp  %buildpath%/src/dawn/samples/Release/libdawn_sample_utils.lib raw\Windows\
    cp  %buildpath%/src/dawn/Release/libdawncpp.lib raw\Windows\
    cp  %buildpath%/src/dawn/utils/Release/libdawn_utils.lib raw\Windows\
    cp  %buildpath%/src/dawn/Release/libdawn_proc.lib raw\Windows\
    cp  %buildpath%/src/dawn/native/Release/libdawn_native.lib raw\Windows\
    cp  %buildpath%/src/dawn/platform/Release/libdawn_platform.lib raw\Windows\
    cp  %buildpath%/src/dawn/wire/Release/libdawn_wire.lib raw\Windows\
    cp  %buildpath%/src/dawn/common/Release/libdawn_common.lib raw\Windows\
    cp  %buildpath%/src/dawn/Release/libdawncpp_headers.lib raw\Windows\
    cp  %buildpath%/src/dawn/Release/libdawn_headers.lib raw\Windows\


    # tint
    cp  %buildpath%/src/tint/Release/libtint.lib raw\Windows\
    cp  %buildpath%/src/tint/Release/libtint_diagnostic_utils.lib raw\Windows\

    # absl
    cp  %buildpath%/third_party/abseil/absl/strings/Release/libabsl_str_format_internal.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/strings/Release/libabsl_strings.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/strings/Release/libabsl_strings_internal.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/base/Release/libabsl_base.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/base/Release/libabsl_spinlock_wait.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/numeric/Release/libabsl_int128.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/base/Release/libabsl_throw_delegate.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/base/Release/libabsl_raw_logging_internal.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/base/Release/libabsl_log_severity.lib raw\Windows\

    # spirv
    cp  %buildpath%/third_party/spirv-tools/source/opt/Release/libSPIRV-Tools-opt.lib raw\Windows\
    cp  %buildpath%/third_party/spirv-tools/source/Release/libSPIRV-Tools.lib raw\Windows\

    # glslang
    cp  %buildpath%/third_party/glslang/SPIRV/Release/libSPIRV.lib raw\Windows\
    cp  %buildpath%/third_party/glslang/StandAlone/Release/libglslang-default-resource-limits.lib raw\Windows\
    cp  %buildpath%/third_party/glslang/glslang/Release/libglslang.lib raw\Windows\
    cp  %buildpath%/third_party/glslang/glslang/Release/libMachineIndependent.lib raw\Windows\
    cp  %buildpath%/third_party/glslang/glslang/OSDependent/Unix/Release/libOSDependent.lib raw\Windows\
    cp  %buildpath%/third_party/glslang/glslang/Release/libGenericCodeGen.lib raw\Windows\
    cp  %buildpath%/third_party/glslang/OGLCompilersDLL/Release/libOGLCompiler.lib raw\Windows\





@echo "###############################################"
@echo "######################## merge lib"

set mypath=%cd%
@echo %mypath%

cd "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.32.31326\bin\Hostx64\x64"

Rem cp  %mypath%\libpng16_static.lib  %mypath%\merged\libpng16_static.lib 

.\lib.exe /out:%mypath%\merged\Windows\dawn\libtint.lib ^
%mypath%\raw\Windows\libtint.lib %mypath%\raw\Windows\libtint_diagnostic_utils.lib


.\lib.exe /out:%mypath%\merged\Windows/dawn\libdawn.lib ^
%mypath%\raw\Windows\libdawn_utils.lib ^
%mypath%\raw\Windows\libdawn_native.lib %mypath%\raw\Windows\libdawn_common.lib %mypath%\raw\Windows\libdawn_proc.lib ^
%mypath%\raw\Windows\libdawn_platform.lib ^
%mypath%\raw\Windows\libdawncpp_headers.lib  %mypath%\raw\Windows\libdawn_headers.lib  %mypath%\raw\Windows\libdawncpp.lib ^
%mypath%\raw\Windows\libdawn_wire.lib

.\lib.exe /out:%mypath%\merged\Windows/dawn\libabsl.lib ^
%mypath%\raw\Windows\libabsl_str_format_internal.lib %mypath%\raw\Windows\libabsl_strings.lib ^
%mypath%\raw\Windows\libabsl_strings_internal.lib %mypath%\raw\Windows\libabsl_base.lib ^
%mypath%\raw\Windows\libabsl_spinlock_wait.lib %mypath%\raw\Windows\libabsl_int128.lib ^
%mypath%\raw\Windows\libabsl_throw_delegate.lib %mypath%\raw\Windows\libabsl_raw_logging_internal.lib ^
%mypath%\raw\Windows\libabsl_log_severity.lib 

.\lib.exe /out:%mypath%\merged\Windows/dawn\libSPIRV-Tools.lib ^
%mypath%\raw\Windows\libSPIRV-Tools.lib %mypath%\raw\Windows\libSPIRV-Tools-opt.lib


.\lib.exe /out:%mypath%\merged\Windows/dawn\libglslang.lib ^
%mypath%\raw\Windows\libSPIRV.lib %mypath%\raw\Windows\libglslang-default-resource-limits.lib ^
%mypath%\raw\Windows\libglslang.lib %mypath%\raw\Windows\libMachineIndependent.lib ^
%mypath%\raw\Windows\libOSDependent.lib %mypath%\raw\Windows\libGenericCodeGen.lib ^
%mypath%\raw\Windows\libOGLCompiler.lib
