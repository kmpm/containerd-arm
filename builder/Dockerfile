FROM golang
ARG CONTAINERD_VERSION=v1.5.4

RUN apt-get update && \
    apt-get install -y libbtrfs-dev

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENV CONTAINERD_VERSION=$CONTAINERD_VERSION
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]