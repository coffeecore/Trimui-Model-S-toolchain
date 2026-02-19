#!/bin/bash

ENV SDK_ROOT="=/opt/trimui-toolchain"
ENV TOOLCHAIN_PREFIX="arm-buildroot-linux-gnueabi"
ENV TOOLBIN="${SDK_ROOT}/bin/${TOOLCHAIN_PREFIX}-"
ENV SYSROOT="${SDK_ROOT}/${TOOLCHAIN_PREFIX}/sysroot"
ENV CROSS_COMPILE="${TOOLBIN}"
ENV CC="${TOOLBIN}gcc"
ENV CXX="${TOOLBIN}g++"
ENV LD="${TOOLBIN}ld"
ENV AS="${TOOLBIN}as"
ENV AR="${TOOLBIN}ar"
ENV RANLIB="${TOOLBIN}ranlib"
ENV STRIP="${TOOLBIN}strip"
# Set pkg-config to look in the SDK's sysroot
ENV PKG_CONFIG_PATH="${SYSROOT}/usr/lib/pkgconfig"
ENV PKG_CONFIG_LIBDIR="${SYSROOT}/usr/lib/pkgconfig"
ENV PKG_CONFIG_SYSROOT_DIR="${SYSROOT}"
# Add the toolchain's bin directory to the main PATH
ENV PATH="${SDK_ROOT}/bin:${PATH}"

export CHAINPREFIX=/opt/trimui-toolchain
export PATH=$PATH:$CHAINPREFIX/bin
export CROSS_COMPILE=$CHAINPREFIX/bin/arm-buildroot-linux-gnueabi-
