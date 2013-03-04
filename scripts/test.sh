#!/bin/bash

# Copyright 2013 Foxdog Studios Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset

readonly REPO="$(
    readlink --canonicalize --no-newline -- "$(
        dirname -- "$(
            readlink --canonicalize --no-newline -- "${BASH_SOURCE[0]}"
        )"
    )/.."
)"

cd -- "${REPO}"

# Set up
./scripts/install.sh
test_dir="$(mktemp --directory)"
test_script="${test_dir}/test.sh"
tee ${test_script} << EOF
#!/usr/bin/bashir
echo \`pwd\`
EOF
chmod +x "${test_script}"

# Test
if [[ "$(${test_script})" == "${test_dir}" ]]; then
    test_success=true
else
    test_success=false
fi

# Clean up
rm --force --recursive -- "${test_dir}"
./scripts/install.sh -u

# Report
if $test_success; then
    echo 'Test successful'
else
    echo 'Test failed'
fi

