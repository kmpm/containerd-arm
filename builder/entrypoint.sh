#!/bin/bash
set -e 


if [ "$1" = 'make' ]; then
    BUILD_VERSION=$(git describe --match 'v[0-9]*' --dirty='.m' --always)
    BUILD_ARCH=$(go env GOARCH)
    BUILD_OS=$(go env GOOS)


    echo "about to make ${BUILD_VERSION} for ${BUILD_ARCH}"
    $@
    ASSET_FILENAME="containerd-${BUILD_VERSION}-${BUILD_OS}-${BUILD_ARCH}.tar.gz"
    echo "made ${BUILD_VERSION} for ${BUILD_ARCH}"
    tar -C bin -czvf ../${ASSET_FILENAME} ./
    echo "created ${ASSET_FILENAME}"
    
fi

exec "$@"

