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

usage='
    Installs (default) or uninstalls bashir.

        $ install.sh [-u]

    -u  uninstall
'

install=true

while getopts :u opt; do
    case "${opt}" in
        u) install=false ;;
        \?|*)
            echo "${usage}"
            exit 1
            ;;
    esac
done
unset opt usage

source_path="${REPO}/src/bashir"
install_path='/usr/bin/bashir'

if $install; then
    echo 'Installing bashir'
    sudo cp --force --verbose -- "${source_path}" "${install_path}"
else
    echo 'Uninstalling bashir'
    sudo rm --force --verbose -- "${install_path}"
fi

