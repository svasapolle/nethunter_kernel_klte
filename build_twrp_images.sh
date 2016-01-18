#!/bin/bash
# TWRP kernel for Samsung Galaxy S5 build script by jcadduono
# This build script builds all variants in ./VARIANTS
#
###################### CONFIG ######################

# root directory of TWRP klte git repo (default is this script's location)
RDIR=$(pwd)

# output directory of zImage and dtb.img
OUT_DIR=/home/jc/build/twrp/device/samsung

############## SCARY NO-TOUCHY STUFF ###############

ARCH=arm
KDIR=$RDIR/build/arch/$ARCH/boot

MOVE_IMAGES()
{
	echo "Moving kernel zImage and dtb.img to $VARIANT_DIR/..."
	mkdir -p $VARIANT_DIR
	rm -f $VARIANT_DIR/zImage $VARIANT_DIR/dtb.img
	mv $KDIR/zImage $KDIR/dtb.img $VARIANT_DIR/
}

mkdir -p $OUT_DIR

[ "$@" ] && {
	VARIANTS=$@
} || {
	VARIANTS=$(cat $RDIR/VARIANTS)
}

for V in $VARIANTS
do
	[ "$V" == "unified" ] && {
		VARIANT_DIR=$OUT_DIR/klte
	} || {
		VARIANT_DIR=$OUT_DIR/klte$V
	}
	$RDIR/build.sh $V && MOVE_IMAGES
done

echo "Finished building TWRP kernels!"
