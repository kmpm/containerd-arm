VERSION?=$(shell git -C containerd/ describe --tags --dirty)

.PHONY: usage
usage:
	@echo "containerd version: ${VERSION}"
	@echo
	@echo "make update      - update submodule"
	@echo "make builder     - create the build container using docker"
	@echo "make containerd  - compile containerd"


.PHONY: update
update:
	git submodule update --init


.PHONY: builder
builder:
	docker build -t containerd/build ./builder


.PHONY: containerd
containerd:
	docker run -it \
    -v ${PWD}/containerd:/go/src/github.com/containerd/containerd \
    -e GOPATH=/go \
    -w /go/src/github.com/containerd/containerd containerd/build


