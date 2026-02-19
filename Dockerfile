FROM ubuntu:16.04

RUN apt-get -y update  \
  && apt-get -y install \
    bc \
    build-essential \
    bzip2 \
    cpio \
    curl \
    g++ \
    git \
    libncurses5-dev \
    locales \
    make \
    patch \
    perl \
    python \
    rsync \
    subversion \
    unzip \
    wget \
    zip \
    libsdl1.2-dev \
    libpng12-dev \
    libasound2-dev \
  && rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV BUILDROOT_VERSION 2016.05
ENV BUILDROOT_HOST_DIR /var/lib/trimui-toolchain
ENV BUILDROOT_SYSROOT ${BUILDROOT_HOST_DIR}/usr/arm-buildroot-linux-gnueabi/sysroot/

RUN useradd -d /home/trimui -m -s /bin/bash -U trimui
RUN mkdir -p ${BUILDROOT_HOST_DIR} && \
  chown -R trimui:trimui ${BUILDROOT_HOST_DIR} && \
  ln -s ${BUILDROOT_HOST_DIR}/usr /opt/trimui-toolchain

USER trimui
WORKDIR /home/trimui

COPY trimui_config trimui_config
COPY buildroot-2016.05.tar.bz2 buildroot-2016.05.tar.bz2 
COPY build_toolchain.sh *.patch ./
RUN ./build_toolchain.sh
RUN sed -i "s|/home/trimui/buildroot-${BUILDROOT_VERSION}/output/build/[^/]\\+/lib/|${BUILDROOT_SYSROOT}/usr/lib/|g" ${BUILDROOT_SYSROOT}/usr/lib/*.la

COPY env-setup.sh .

COPY extra_packages.txt .
USER root
RUN apt-get -y update && apt-get -y install $(cat extra_packages.txt) && rm -rf /var/lib/apt/lists/*
USER trimui

COPY extras extras
RUN rsync -av extras/* $BUILDROOT_SYSROOT/usr/

VOLUME /home/trimui/workspace
WORKDIR /home/trimui/workspace

# RUN source /home/trimui/env-setup.sh

CMD ["/bin/bash"]
