#!/bin/bash
set -xe

TRIMUI_RESTORE_IMAGE=http://www.trimui.com/download/Trimui_Factory_Recovery_model_S_dark_V0.105_en.zip
TRIMUI_IMG_FILE=trimui_model_S_dark_V0.105_en.img
AWUTILS_REVISION=3f1cbb2c67752b392a88b252c51158d13d8809b5
EXTFSTOOLS_REVISION=dac938546cc769eca6e57e35d7bb49d0ef458cd3
WORKDIR="${TMPDIR:-/tmp}"/extract_rootfs

mkdir -p $WORKDIR && pushd $WORKDIR

curl -L https://github.com/Ithamar/awutils/archive/$AWUTILS_REVISION.zip -o awutils.zip && unzip awutils.zip
cd awutils-$AWUTILS_REVISION && make awimage && cd ..

curl -L https://github.com/petib/extfstools/archive/$EXTFSTOOLS_REVISION.zip -o extfstools.zip && unzip extfstools.zip
cd extfstools-$EXTFSTOOLS_REVISION && make && cd ..

curl -L $TRIMUI_RESTORE_IMAGE -o trimui_restore_image.zip && unzip trimui_restore_image.zip

awutils-$AWUTILS_REVISION/awimage $TRIMUI_IMG_FILE

popd

mkdir -p trimui_rootfs

$WORKDIR/extfstools-$EXTFSTOOLS_REVISION/ext2rd $WORKDIR/$TRIMUI_IMG_FILE.dump/RFSFAT16_ROOTFS_FEX000000 ./:./trimui_rootfs

rm -r $WORKDIR
