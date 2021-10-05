#!/bin/bash
set -e 


if [ "$1" = 'make' ]; then
    go env
    echo "about to make"
    exec "$@"

    VERSION=$(git describe --tags --dirty)
    ARCH=$(go env GOARCH)
    
fi

exec "$@"

