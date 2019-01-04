#!/usr/bin/env bash

set -euo pipefail

function is_abs() {
    if [[ ! "$1" = /* ]]; then
        echo "Path \"$1\" should be absolute path"
        exit 1
    fi
}

if [ "$#" -ne 3 ]; then
    echo "Usage: [path-notebooks] [path-key] [path-cert]"
    exit 1
fi

path_notebooks=$1
path_key=$2
path_cert=$3
path=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/docker

is_abs "$path_notebooks"
is_abs "$path_key"
is_abs "$path_cert"

docker \
    build \
    -t 'jupyterhub' \
    "$path"

docker \
    run \
    -p '9000:8000'  \
    --rm \
    -v "$path/jupyterhub_config.py:/srv/jupyterhub/jupyterhub_config.py" \
    -v "$path_key:/srv/jupyterhub/key.cert" \
    -v "$path_cert:/srv/jupyterhub/cert.cert" \
    -v "$path/dependencies.txt:/dependencies.txt" \
    -v "$path_notebooks:/notebooks" \
    -d \
    jupyterhub
