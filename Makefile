VERSION?=$(shell git -C containerd/ describe --tags --dirty)
VOLUME_NAME?=containerd-data
IMAGE_NAME=containerd/build

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
	docker build -t ${IMAGE_NAME} ./builder


.PHONY: volume
volume: 
	docker volume create ${VOLUME_NAME}


.PHONY: asset
asset:
	docker run -it --rm \
    -v ${VOLUME_NAME}:/workspace \
    -e GOPATH=/go \
    -w /workspace \
	${IMAGE_NAME} make


.PHONY: shell
shell:
	docker run -it --rm \
    -v ${VOLUME_NAME}:/workspace \
    -e GOPATH=/go \
    -w /workspace \
	${IMAGE_NAME} bash


.PHONY: files
files:
	docker create -ti --name dummy \
	-v ${VOLUME_NAME}:/workspace \
	${IMAGE_NAME} bash
	docker cp dummy:/workspace/assets/. .
	docker rm -f dummy


.PHONY: clean
clean:
	docker rm -f dummy
	docker volume rm ${VOLUME_NAME}
	docker image rm containerd/build:latest
