FROM openjdk:15-jdk-alpine3.11

ENV DEBIAN_FRONTEND=noninteractive

ENV GHIDRA_REPOS_PATH /srv/repositories
ENV GHIDRA_INSTALL_PATH /opt
ENV GHIDRA_RELEASE_URL https://ghidra-sre.org/ghidra_9.1.2_PUBLIC_20200212.zip
ENV GHIDRA_VERSION 9.1.2_PUBLIC
ENV GHIDRA_SHA_256 ebe3fa4e1afd7d97650990b27777bb78bd0427e8e70c1d0ee042aeb52decac61

RUN apk add --update --no-cache \
    wget \
    unzip \
    bash

# Get Ghidra.
WORKDIR ${GHIDRA_INSTALL_PATH}
RUN wget --progress=bar:force -O ghidra_${GHIDRA_VERSION}.zip ${GHIDRA_RELEASE_URL} && \
    echo "${GHIDRA_SHA_256}  ghidra_${GHIDRA_VERSION}.zip" | sha256sum -c && \
    unzip ghidra_${GHIDRA_VERSION}.zip && \
    mv ghidra_${GHIDRA_VERSION} ghidra && \
    rm ghidra_${GHIDRA_VERSION}.zip

# Install Ghidra server.
RUN cd ${GHIDRA_INSTALL_PATH}/ghidra/server && \
    cp server.conf server.conf.bak && \
    mkdir -p ${GHIDRA_REPOS_PATH} && \
    sed 's|ghidra.repositories.dir=.*|ghidra.repositories.dir='"${GHIDRA_REPOS_PATH}"'|' server.conf.bak > server.conf && \
    ${GHIDRA_INSTALL_PATH}/ghidra/server/svrInstall

VOLUME ${GHIDRA_REPOS_PATH}

# Ghidra's default ports.
EXPOSE 13100
EXPOSE 13101
EXPOSE 13102

ENTRYPOINT ${GHIDRA_INSTALL_PATH}/ghidra/server/ghidraSvr console
