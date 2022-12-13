// Copyright 2022 The Tint Authors.
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
//   src/tint/type/short_name.h.tmpl
//
// Do not modify this file directly
////////////////////////////////////////////////////////////////////////////////

#ifndef SRC_TINT_TYPE_SHORT_NAME_H_
#define SRC_TINT_TYPE_SHORT_NAME_H_

#include <ostream>

namespace tint::type {

/// An enumerator of builtin type aliases.
enum class ShortName {
    kUndefined,
    kVec2F,
    kVec2H,
    kVec2I,
    kVec2U,
    kVec3F,
    kVec3H,
    kVec3I,
    kVec3U,
    kVec4F,
    kVec4H,
    kVec4I,
    kVec4U,
};

/// @param out the std::ostream to write to
/// @param value the ShortName
/// @returns `out` so calls can be chained
std::ostream& operator<<(std::ostream& out, ShortName value);

/// ParseShortName parses a ShortName from a string.
/// @param str the string to parse
/// @returns the parsed enum, or ShortName::kUndefined if the string could not be parsed.
ShortName ParseShortName(std::string_view str);

constexpr const char* kShortNameStrings[] = {
    "vec2f", "vec2h", "vec2i", "vec2u", "vec3f", "vec3h",
    "vec3i", "vec3u", "vec4f", "vec4h", "vec4i", "vec4u",
};

}  // namespace tint::type

#endif  // SRC_TINT_TYPE_SHORT_NAME_H_
