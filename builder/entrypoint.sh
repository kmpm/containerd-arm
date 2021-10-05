#!/bin/bash
set -e 


if [ "$1" = 'make' ]; then
    BUILD_VERSION=$(git describe --match 'v[0-9]*' --dirty='.m' --always)
    BUILD_ARCH=$(go env GOARCH)

    echo "about to make ${BUILD_VERSION} for ${BUILD_ARCH}"
    exec "$@"
    echo "made ${BUILD_VERSION} for ${BUILD_ARCH}"
    
fi

exec "$@"

