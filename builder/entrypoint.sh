#!/bin/bash
set -e 

WANT_VERSION=${CONTAINERD_VERSION:-v1.5.4}

if [ "$1" = 'make' ]; then
    
    if [ ! -d assets ]; then
        mkdir assets
    fi

    if [ ! -d containerd ]; then
        git clone https://github.com/containerd/containerd
    fi

    cd containerd
    echo "Builder refreshing source"
    git checkout main
    git pull


    GOT_VERSION=$(git describe --match 'v[0-9]*' --dirty='.m' --always)
    
    if [ "${GOT_VERSION}" != "${WANT_VERSION}" ]; then
        git checkout ${WANT_VERSION}
        GOT_VERSION=$(git describe --match 'v[0-9]*' --dirty='.m' --always)
        if [ "${GOT_VERSION}" != "${WANT_VERSION}" ]; then 
            echo "ERROR! Could not get ${WANT_VERSION}. Source remains at ${GOT_VERSION}"
            exit 1
        fi
    fi
    go env
    BUILD_ARCH=$(go env GOARCH)
    BUILD_OS=$(go env GOOS)
    echo ""
    echo "Builder is about to make ${GOT_VERSION} for ${BUILD_ARCH}"
    echo ""
    
    $@

    
    ASSET_FILENAME="containerd-${GOT_VERSION}-${BUILD_OS}-${BUILD_ARCH}.tar.gz"
    echo ""
    echo "Builder made ${GOT_VERSION} for ${BUILD_ARCH}"
    tar -C bin -czvf ../assets/${ASSET_FILENAME} ./
    echo ""
    echo "Builder created asset ${ASSET_FILENAME}"
    exit 0
fi

exec "$@"

