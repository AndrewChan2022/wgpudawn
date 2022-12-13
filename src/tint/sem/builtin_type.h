// Copyright 2021 The Tint Authors.
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

////////////////////////////////////////////////////////////////////////////////
// File generated by tools/src/cmd/gen
// using the template:
//   src/tint/sem/builtin_type.h.tmpl
//
// Do not modify this file directly
////////////////////////////////////////////////////////////////////////////////

#ifndef SRC_TINT_SEM_BUILTIN_TYPE_H_
#define SRC_TINT_SEM_BUILTIN_TYPE_H_

#include <sstream>
#include <string>

namespace tint::sem {

/// Enumerator of all builtin functions
enum class BuiltinType {
    kNone = -1,
    kAbs,
    kAcos,
    kAcosh,
    kAll,
    kAny,
    kArrayLength,
    kAsin,
    kAsinh,
    kAtan,
    kAtan2,
    kAtanh,
    kCeil,
    kClamp,
    kCos,
    kCosh,
    kCountLeadingZeros,
    kCountOneBits,
    kCountTrailingZeros,
    kCross,
    kDegrees,
    kDeterminant,
    kDistance,
    kDot,
    kDot4I8Packed,
    kDot4U8Packed,
    kDpdx,
    kDpdxCoarse,
    kDpdxFine,
    kDpdy,
    kDpdyCoarse,
    kDpdyFine,
    kExp,
    kExp2,
    kExtractBits,
    kFaceForward,
    kFirstLeadingBit,
    kFirstTrailingBit,
    kFloor,
    kFma,
    kFract,
    kFrexp,
    kFwidth,
    kFwidthCoarse,
    kFwidthFine,
    kInsertBits,
    kInverseSqrt,
    kLdexp,
    kLength,
    kLog,
    kLog2,
    kMax,
    kMin,
    kMix,
    kModf,
    kNormalize,
    kPack2X16Float,
    kPack2X16Snorm,
    kPack2X16Unorm,
    kPack4X8Snorm,
    kPack4X8Unorm,
    kPow,
    kQuantizeToF16,
    kRadians,
    kReflect,
    kRefract,
    kReverseBits,
    kRound,
    kSaturate,
    kSelect,
    kSign,
    kSin,
    kSinh,
    kSmoothstep,
    kSqrt,
    kStep,
    kStorageBarrier,
    kTan,
    kTanh,
    kTranspose,
    kTrunc,
    kUnpack2X16Float,
    kUnpack2X16Snorm,
    kUnpack2X16Unorm,
    kUnpack4X8Snorm,
    kUnpack4X8Unorm,
    kWorkgroupBarrier,
    kTextureDimensions,
    kTextureGather,
    kTextureGatherCompare,
    kTextureNumLayers,
    kTextureNumLevels,
    kTextureNumSamples,
    kTextureSample,
    kTextureSampleBias,
    kTextureSampleCompare,
    kTextureSampleCompareLevel,
    kTextureSampleGrad,
    kTextureSampleLevel,
    kTextureSampleBaseClampToEdge,
    kTextureStore,
    kTextureLoad,
    kAtomicLoad,
    kAtomicStore,
    kAtomicAdd,
    kAtomicSub,
    kAtomicMax,
    kAtomicMin,
    kAtomicAnd,
    kAtomicOr,
    kAtomicXor,
    kAtomicExchange,
    kAtomicCompareExchangeWeak,
    kTintMaterialize,
};

/// Matches the BuiltinType by name
/// @param name the builtin name to parse
/// @returns the parsed BuiltinType, or BuiltinType::kNone if `name` did not
/// match any builtin.
BuiltinType ParseBuiltinType(const std::string& name);

/// @returns the name of the builtin function type. The spelling, including
/// case, matches the name in the WGSL spec.
const char* str(BuiltinType i);

/// Emits the name of the builtin function type. The spelling, including case,
/// matches the name in the WGSL spec.
std::ostream& operator<<(std::ostream& out, BuiltinType i);

}  // namespace tint::sem

#endif  // SRC_TINT_SEM_BUILTIN_TYPE_H_
