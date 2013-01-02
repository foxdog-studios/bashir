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

