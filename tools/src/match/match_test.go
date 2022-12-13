// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package match_test

import (
	"strings"
	"testing"

	"dawn.googlesource.com/dawn/tools/src/match"
)

func TestMatch(t *testing.T) {
	for _, test := range []struct {
		pattern string
		path    string
		expect  bool
	}{
		{"a", "a", true},
		{"b", "a", false},

		{"?", "a", true},
		{"a/?/c", "a/x/c", true},
		{"a/??/c", "a/x/c", false},
		{"a/??/c", "a/xx/c", true},
		{"a/???/c", "a/x z/c", true},
		{"a/?/c", "a/xx/c", false},
		{"a/?/?/c", "a/x/y/c", true},
		{"a/?/?/?/c", "a/x/y/z/c", true},
		{"a/???/c", "a/x/y/c", false},
		{"a/?????", "a/x/y/c", false},

		{"*", "a", true},
		{"*", "abc", true},
		{"*", "abc 123", true},
		{"*", "xxx/yyy", false},
		{"*/*", "xxx/yyy", true},
		{"*/*", "xxx/yyy/zzz", false},
		{"*/*/c", "xxx/yyy/c", true},
		{"a/*/*", "a/xxx/yyy", true},
		{"a/*/c", "a/xxx/c", true},
		{"a/*/c", "a/xxx/c", true},
		{"a/*/*/c", "a/b/c", false},

		{"**", "a", true},
		{"**", "abc", true},
		{"**", "abc 123", true},
		{"**", "xxx/yyy", true},
		{"**", "xxx/yyy/zzz", true},
		{"**/**", "xxx", false},
		{"**/**", "xxx/yyy", true},
		{"**/**", "xxx/yyy/zzz", true},
		{"**/**/**", "xxx/yyy/zzz", true},
		{"**/**/c", "xxx/yyy/c", true},
		{"**/**/c", "xxx/yyy/c/d", false},
		{"a/**/**", "a/xxx/yyy", true},
		{"a/**/c", "a/xxx/c", true},
		{"a/**/c", "a/xxx/yyy/c", true},
		{"a/**/c", "a/xxx/y y/zzz/c", true},

		{"a/**/c", "a/c", false},
		{"a/**c", "a/c", true},

		{"xxx/**.foo", "xxx/aaa.foo", true},
		{"xxx/**.foo", "xxx/yyy/zzz/.foo", true},
		{"xxx/**.foo", "xxx/yyy/zzz/bar.foo", true},
	} {
		f, err := match.New(test.pattern)
		if err != nil {
			t.Errorf(`match.New("%v")`, test.pattern)
			continue
		}
		matched := f(test.path)
		switch {
		case matched && !test.expect:
			t.Errorf(`Path "%v" matched against pattern "%v"`, test.path, test.pattern)
		case !matched && test.expect:
			t.Errorf(`Path "%v" did not match against pattern "%v"`, test.path, test.pattern)
		}
	}
}

func TestErrOnPlaceholder(t *testing.T) {
	for _, pattern := range []string{"a/b••c", "a/b•c", "a/b/¿c"} {
		_, err := match.New(pattern)
		if err == nil {
			t.Errorf(`match.New("%v") did not return an expected error`, pattern)
			continue
		}
		if !strings.Contains(err.Error(), "Pattern must not contain") {
			t.Errorf(`match.New("%v") returned unrecognised error: %v`, pattern, err)
			continue
		}
	}
}
