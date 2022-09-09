#!/usr/bin/env bash

set -eu -o pipefail

if ! command -v golangci-lint &> /dev/null ; then
    echo "golangci-lint not installed or available in the PATH" >&2
    echo "please check https://github.com/golangci/golangci-lint" >&2
    exit 1
fi

if test -f "go.work"; then
    go work edit -json | jq -r '.Use[].DiskPath'  | xargs -I{} golangci-lint run {}/...
else
    exec golangci-lint run "$@"
fi
