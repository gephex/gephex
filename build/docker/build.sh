#!/bin/sh
# Builds GePhex in a Debian 13 container and installs it to ./_install.
# Only docker is needed on the host. The result runs natively on Debian 13
# (and distributions with the same library versions).
#
# Usage: build/docker/build.sh [extra configure options]
set -e
top=$(cd "$(dirname "$0")/../.." && pwd)
run="$top/build/docker/run.sh"

docker build -t gephex-build "$top/build/docker"

"$run" sh bootstrap.sh
mkdir -p "$top/_build"
"$run" sh -c "cd _build && ../configure --prefix='$top/_install' $* \
              && make -j\$(nproc) && make install"

echo
echo "Done. Start GePhex with: $top/_install/bin/gephex"
