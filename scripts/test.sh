#!/bin/bash

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
pylint src/bashir

if $test_success; then
    echo 'Test successful'
else
    echo 'Test failed'
fi

