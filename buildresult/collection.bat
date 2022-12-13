

echo off

@echo "***** please run on gitbash"
@echo "***** please edit this file on line:85 for correct vc path such as: MSVC\14.34.31933\bin\Hostx64\x64"

if "%~1"=="" (
    @echo "collection.bat build_path"
    @echo "error:L no build_path"
    goto :eof
)

@echo "collection.bat build_path"

set buildpath=%1


@echo "###############################################"
@echo "######################## mkdir raw\windows merged\windows"

    mkdir raw
    mkdir raw\windows
    mkdir merged
    mkdir merged\windows
    mkdir merged\windows\dawn

@echo "###############################################"
@echo "######################## collection libs"

    

    Rem dawn
    Rem cp  %buildpath%/src/dawn/samples/Release/dawn_sample_utils.lib raw\Windows\
    cp  %buildpath%/src/dawn/Release/dawncpp.lib raw\Windows\
    cp  %buildpath%/src/dawn/utils/Release/dawn_utils.lib raw\Windows\
    cp  %buildpath%/src/dawn/Release/dawn_proc.lib raw\Windows\
    cp  %buildpath%/src/dawn/native/Release/dawn_native.lib raw\Windows\
    cp  %buildpath%/src/dawn/platform/Release/dawn_platform.lib raw\Windows\
    cp  %buildpath%/src/dawn/wire/Release/dawn_wire.lib raw\Windows\
    cp  %buildpath%/src/dawn/common/Release/dawn_common.lib raw\Windows\
    cp  %buildpath%/src/dawn/Release/dawncpp_headers.lib raw\Windows\
    cp  %buildpath%/src/dawn/Release/dawn_headers.lib raw\Windows\


    Rem tint
    cp  %buildpath%/src/tint/Release/tint.lib raw\Windows\
    cp  %buildpath%/src/tint/Release/tint_diagnostic_utils.lib raw\Windows\

    Rem absl
    cp  %buildpath%/third_party/abseil/absl/strings/Release/absl_str_format_internal.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/strings/Release/absl_strings.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/strings/Release/absl_strings_internal.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/base/Release/absl_base.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/base/Release/absl_spinlock_wait.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/numeric/Release/absl_int128.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/base/Release/absl_throw_delegate.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/base/Release/absl_raw_logging_internal.lib raw\Windows\
    cp  %buildpath%/third_party/abseil/absl/base/Release/absl_log_severity.lib raw\Windows\

    Rem spirv
    cp  %buildpath%/third_party/spirv-tools/source/opt/Release/SPIRV-Tools-opt.lib raw\Windows\
    cp  %buildpath%/third_party/spirv-tools/source/Release/SPIRV-Tools.lib raw\Windows\

    Rem glslang
    cp  %buildpath%/third_party/glslang/SPIRV/Release/SPIRV.lib raw\Windows\
    cp  %buildpath%/third_party/glslang/StandAlone/Release/glslang-default-resource-limits.lib raw\Windows\
    cp  %buildpath%/third_party/glslang/glslang/Release/glslang.lib raw\Windows\
    cp  %buildpath%/third_party/glslang/glslang/Release/MachineIndependent.lib raw\Windows\
    cp  %buildpath%/third_party/glslang/glslang/OSDependent/Windows/Release/OSDependent.lib raw\Windows\
    cp  %buildpath%/third_party/glslang/glslang/Release/GenericCodeGen.lib raw\Windows\
    cp  %buildpath%/third_party/glslang/OGLCompilersDLL/Release/OGLCompiler.lib raw\Windows\





@echo "###############################################"
@echo "######################## merge lib"

set mypath=%cd%
@echo %mypath%

@echo "cd C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.34.31933\bin\Hostx64\x64"
cd "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.34.31933\bin\Hostx64\x64"

Rem cp  %mypath%\png16_static.lib  %mypath%\merged\png16_static.lib 

.\lib.exe /out:%mypath%\merged\Windows\dawn\tint.lib %mypath%\raw\Windows\tint.lib %mypath%\raw\Windows\tint_diagnostic_utils.lib


.\lib.exe /out:%mypath%\merged\Windows/dawn\dawn.lib ^
%mypath%\raw\Windows\dawn_utils.lib ^
%mypath%\raw\Windows\dawn_native.lib %mypath%\raw\Windows\dawn_common.lib %mypath%\raw\Windows\dawn_proc.lib ^
%mypath%\raw\Windows\dawn_platform.lib ^
%mypath%\raw\Windows\dawncpp_headers.lib  %mypath%\raw\Windows\dawn_headers.lib  %mypath%\raw\Windows\dawncpp.lib ^
%mypath%\raw\Windows\dawn_wire.lib

.\lib.exe /out:%mypath%\merged\Windows/dawn\absl.lib ^
%mypath%\raw\Windows\absl_str_format_internal.lib %mypath%\raw\Windows\absl_strings.lib ^
%mypath%\raw\Windows\absl_strings_internal.lib %mypath%\raw\Windows\absl_base.lib ^
%mypath%\raw\Windows\absl_spinlock_wait.lib %mypath%\raw\Windows\absl_int128.lib ^
%mypath%\raw\Windows\absl_throw_delegate.lib %mypath%\raw\Windows\absl_raw_logging_internal.lib ^
%mypath%\raw\Windows\absl_log_severity.lib 

.\lib.exe /out:%mypath%\merged\Windows/dawn\SPIRV-Tools.lib ^
%mypath%\raw\Windows\SPIRV-Tools.lib %mypath%\raw\Windows\SPIRV-Tools-opt.lib


.\lib.exe /out:%mypath%\merged\Windows/dawn\glslang.lib ^
%mypath%\raw\Windows\SPIRV.lib %mypath%\raw\Windows\glslang-default-resource-limits.lib ^
%mypath%\raw\Windows\glslang.lib %mypath%\raw\Windows\MachineIndependent.lib ^
%mypath%\raw\Windows\OSDependent.lib %mypath%\raw\Windows\GenericCodeGen.lib ^
%mypath%\raw\Windows\OGLCompiler.lib
