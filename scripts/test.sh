#!/usr/bin/env bash

# Unofficial bash strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# We have to log into ECR now that we're doing Lambdas with containers
aws ecr get-login-password --region 'us-east-1' | docker login --username AWS --password-stdin "$(aws sts get-caller-identity | jq -r '.Account').dkr.ecr.us-east-1.amazonaws.com"

GIT_ROOT=$(git rev-parse --show-toplevel)
pushd "$GIT_ROOT"/tests >/dev/null || exit 1
go test -timeout 30m -count=1 -parallel 10 ./...
