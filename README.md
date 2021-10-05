# containerd-arm

This repo contains binary releases of [containerd](https://github.com/containerd/containerd) built for arm and arm64.

## Why is this needed?

See https://github.com/alexellis/containerd-arm


## How I do it
On a Raspberry Pi, installed with your favourite OS and docker
```shell
# update the containerd submodule to whatever the repo is pointing at
make update

# create the image that we will use do build everything
make builder

# do the actual building
make build
```