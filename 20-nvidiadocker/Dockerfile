FROM ubuntu:16.04
# FROM arm64=arm64v8/ubuntu:16.04 arm=arm32v7/ubuntu:16.04

ENV ENA_VERSION 390.48

RUN curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
    apt-key add -
RUN distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
RUN curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
    tee /etc/apt/sources.list.d/nvidia-docker.list

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y nvidia-docker2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pkill -SIGHUP dockerd