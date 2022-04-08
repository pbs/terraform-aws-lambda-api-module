#!/usr/bin/env bash

# Unofficial bash strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

GIT_ROOT=$(git rev-parse --show-toplevel)

"$GIT_ROOT"/scripts/package.sh

pushd "$GIT_ROOT"/examples/sam > /dev/null
sam local start-api -v ../artifacts 
