#!/usr/bin/env bash
# set -x
set -euo pipefail
IFS=$'\n\t'

RELEASE=${RELEASE:-test}
docker network ls --format '{{.Name}}' | grep 'test' || docker network create --subnet 10.0.0.0/24 test

docker run --rm -it \
    -v "$PWD":/work \
    --network test \
    -v /var/run/docker.sock:/var/run/docker.sock \
    kitchen-terraform:"${RELEASE}" "$1"

docker network rm test
