FROM ubuntu:16.04
# FROM arm64=arm64v8/ubuntu:16.04 arm=arm32v7/ubuntu:16.04

ENV ENA_VERSION 390.48

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y curl \
    gcc \
    make \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /dist
COPY build.sh /dist/

CMD ["/dist/build.sh"]

ENTRYPOINT ["/usr/bin/ros", "entrypoint"]