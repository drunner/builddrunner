# Dockerfile for build environment

FROM debian
MAINTAINER j842

RUN apt-get update && \
      apt-get -y install \
      build-essential g++-multilib \
      libboost-all-dev libyaml-cpp-dev \
      libssl-dev \
      apt-transport-https ca-certificates \
      cmake \
      wget bc && \
      rm -rf /var/lib/apt/lists/*

RUN mkdir /poco && cd /poco && export POCOVER="poco-1.7.7" && \
    wget http://pocoproject.org/releases/${POCOVER}/${POCOVER}-all.tar.gz && \
    gunzip ${POCOVER}-all.tar.gz && \
    tar xf ${POCOVER}-all.tar && \
    cd ${POCOVER}-all && \
    ./configure --static && \
    make -j4 && \
    make install && \
    cd ; rm -rf /poco

VOLUME ["/source"]

WORKDIR /source
