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


.PHONY: build
build:
	docker run -it -rm \
    -v ${PWD}:/workspace \
    -e GOPATH=/go \
    -w /workspace/containerd containerd/build make


