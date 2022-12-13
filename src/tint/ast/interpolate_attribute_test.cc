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
//   src/tint/ast/interpolate_attribute_test.cc.tmpl
//
// Do not modify this file directly
////////////////////////////////////////////////////////////////////////////////

#include "src/tint/ast/interpolate_attribute.h"

#include <string>

#include "src/tint/ast/test_helper.h"
#include "src/tint/utils/string.h"

namespace tint::ast {
namespace {

using InterpolateAttributeTest = TestHelper;

TEST_F(InterpolateAttributeTest, Creation) {
    auto* d =
        create<InterpolateAttribute>(InterpolationType::kLinear, InterpolationSampling::kCenter);
    EXPECT_EQ(InterpolationType::kLinear, d->type);
    EXPECT_EQ(InterpolationSampling::kCenter, d->sampling);
}

namespace interpolation_type_tests {

namespace parse_print_tests {

struct Case {
    const char* string;
    InterpolationType value;
};

inline std::ostream& operator<<(std::ostream& out, Case c) {
    return out << "'" << std::string(c.string) << "'";
}

static constexpr Case kValidCases[] = {
    {"flat", InterpolationType::kFlat},
    {"linear", InterpolationType::kLinear},
    {"perspective", InterpolationType::kPerspective},
};

static constexpr Case kInvalidCases[] = {
    {"ccat", InterpolationType::kUndefined},          {"3", InterpolationType::kUndefined},
    {"fVat", InterpolationType::kUndefined},          {"1inear", InterpolationType::kUndefined},
    {"lnqqar", InterpolationType::kUndefined},        {"linell77", InterpolationType::kUndefined},
    {"perppHqective", InterpolationType::kUndefined}, {"cespctve", InterpolationType::kUndefined},
    {"ebGpective", InterpolationType::kUndefined},
};

using InterpolationTypeParseTest = testing::TestWithParam<Case>;

TEST_P(InterpolationTypeParseTest, Parse) {
    const char* string = GetParam().string;
    InterpolationType expect = GetParam().value;
    EXPECT_EQ(expect, ParseInterpolationType(string));
}

INSTANTIATE_TEST_SUITE_P(ValidCases, InterpolationTypeParseTest, testing::ValuesIn(kValidCases));
INSTANTIATE_TEST_SUITE_P(InvalidCases,
                         InterpolationTypeParseTest,
                         testing::ValuesIn(kInvalidCases));

using InterpolationTypePrintTest = testing::TestWithParam<Case>;

TEST_P(InterpolationTypePrintTest, Print) {
    InterpolationType value = GetParam().value;
    const char* expect = GetParam().string;
    EXPECT_EQ(expect, utils::ToString(value));
}

INSTANTIATE_TEST_SUITE_P(ValidCases, InterpolationTypePrintTest, testing::ValuesIn(kValidCases));

}  // namespace parse_print_tests

}  // namespace interpolation_type_tests

namespace interpolation_sampling_tests {

namespace parse_print_tests {

struct Case {
    const char* string;
    InterpolationSampling value;
};

inline std::ostream& operator<<(std::ostream& out, Case c) {
    return out << "'" << std::string(c.string) << "'";
}

static constexpr Case kValidCases[] = {
    {"center", InterpolationSampling::kCenter},
    {"centroid", InterpolationSampling::kCentroid},
    {"sample", InterpolationSampling::kSample},
};

static constexpr Case kInvalidCases[] = {
    {"cevteii", InterpolationSampling::kUndefined}, {"ceWWt8r", InterpolationSampling::kUndefined},
    {"xxentr", InterpolationSampling::kUndefined},  {"ceXggrid", InterpolationSampling::kUndefined},
    {"ceXriu", InterpolationSampling::kUndefined},  {"centr3id", InterpolationSampling::kUndefined},
    {"sEmple", InterpolationSampling::kUndefined},  {"amTTlPP", InterpolationSampling::kUndefined},
    {"ddamxxl", InterpolationSampling::kUndefined},
};

using InterpolationSamplingParseTest = testing::TestWithParam<Case>;

TEST_P(InterpolationSamplingParseTest, Parse) {
    const char* string = GetParam().string;
    InterpolationSampling expect = GetParam().value;
    EXPECT_EQ(expect, ParseInterpolationSampling(string));
}

INSTANTIATE_TEST_SUITE_P(ValidCases,
                         InterpolationSamplingParseTest,
                         testing::ValuesIn(kValidCases));
INSTANTIATE_TEST_SUITE_P(InvalidCases,
                         InterpolationSamplingParseTest,
                         testing::ValuesIn(kInvalidCases));

using InterpolationSamplingPrintTest = testing::TestWithParam<Case>;

TEST_P(InterpolationSamplingPrintTest, Print) {
    InterpolationSampling value = GetParam().value;
    const char* expect = GetParam().string;
    EXPECT_EQ(expect, utils::ToString(value));
}

INSTANTIATE_TEST_SUITE_P(ValidCases,
                         InterpolationSamplingPrintTest,
                         testing::ValuesIn(kValidCases));

}  // namespace parse_print_tests

}  // namespace interpolation_sampling_tests

}  // namespace
}  // namespace tint::ast
