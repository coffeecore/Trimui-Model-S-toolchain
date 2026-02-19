#!/bin/bash

export SDK_ROOT="=/opt/trimui-toolchain"
export TOOLCHAIN_PREFIX="arm-buildroot-linux-gnueabi"
export TOOLBIN="${SDK_ROOT}/bin/${TOOLCHAIN_PREFIX}-"
export SYSROOT="${SDK_ROOT}/${TOOLCHAIN_PREFIX}/sysroot"
export CROSS_COMPILE="${TOOLBIN}"
export CC="${TOOLBIN}gcc"
export CXX="${TOOLBIN}g++"
export LD="${TOOLBIN}ld"
export AS="${TOOLBIN}as"
export AR="${TOOLBIN}ar"
export RANLIB="${TOOLBIN}ranlib"
export STRIP="${TOOLBIN}strip"
# Set pkg-config to look in the SDK's sysroot
export PKG_CONFIG_PATH="${SYSROOT}/usr/lib/pkgconfig"
export PKG_CONFIG_LIBDIR="${SYSROOT}/usr/lib/pkgconfig"
export PKG_CONFIG_SYSROOT_DIR="${SYSROOT}"
# Add the toolchain's bin directory to the main PATH
export PATH="${SDK_ROOT}/bin:${PATH}"

export CHAINPREFIX=/opt/trimui-toolchain
export PATH=$PATH:$CHAINPREFIX/bin
export CROSS_COMPILE=$CHAINPREFIX/bin/arm-buildroot-linux-gnueabi-
