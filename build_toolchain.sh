#! /bin/bash

set -xe

BR_DIR=buildroot-${BUILDROOT_VERSION:-"2016.05"}
BR_TAR=${BR_DIR}.tar.bz2
BR_URL=https://buildroot.org/downloads/${BR_TAR}

# echo ${BR_DIR} && wget ${BR_URL} && ls -l && tar xf ${BR_TAR} && rm -f ${BR_TAR}
echo ${BR_DIR} && pwd && ls -l && tar xf ${BR_TAR} && ls -l

pushd ${BR_DIR}
make trimui_defconfig BR2_EXTERNAL=../trimui_config
make toolchain

for patch in ../*.patch; do patch -p0 < $patch; done
make

popd
rm -r ${BR_DIR}
