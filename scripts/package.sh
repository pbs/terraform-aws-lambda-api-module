#!/usr/bin/env bash

# Unofficial bash strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

GIT_ROOT=$(git rev-parse --show-toplevel)

pushd "$GIT_ROOT"/examples/src > /dev/null
GOOS=linux go build -o "$GIT_ROOT"/examples/artifacts/main .
zip -j "$GIT_ROOT"/examples/artifacts/handler.zip "$GIT_ROOT"/examples/artifacts/main
