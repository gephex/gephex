#!/bin/sh
# Runs a command inside the gephex-build image with the source tree mounted.
# Usage: build/docker/run.sh <command...>
top=$(cd "$(dirname "$0")/../.." && pwd)
exec docker run --rm --user "$(id -u):$(id -g)" -e HOME=/tmp \
    -v "$top:$top" -w "$top" gephex-build "$@"
