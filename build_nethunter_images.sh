#!/bin/bash
# NetHunter kernel for Samsung Galaxy S5 build script by jcadduono
# This build script is for AOSP/CyanogenMod with Kali Nethunter support only
# This build script builds all variants in ./VARIANTS

################### BEFORE STARTING ################
#
# download a working toolchain and extract it somewhere and configure
# ./build.sh to point to the toolchain's root directory.
# I highly recommend Christopher83's Linaro GCC 4.9.x Cortex-A15 toolchain.
# Download it here: http://forum.xda-developers.com/showthread.php?t=2098133
#
###################### CONFIG ######################

# root directory of NetHunter klte git repo (default is this script's location)
RDIR=$(pwd)

# output directory of zImage and dtb.img
OUT_DIR=/home/jc/build/kali-nethunter/nethunter-installer/kernels/lollipop

############## SCARY NO-TOUCHY STUFF ###############

KDIR=$RDIR/build/arch/arm/boot

MOVE_IMAGES()
{
	echo "Moving zImage and dtb.img to $VARIANT_DIR/..."
	rm -rf $VARIANT_DIR
	mkdir $VARIANT_DIR
	mv $KDIR/zImage $KDIR/dtb.img $VARIANT_DIR/
}

mkdir -p $OUT_DIR

for V in $(cat $RDIR/VARIANTS)
do
	[ "$V" == "eur" ] && {
		VARIANT_DIR=$OUT_DIR/klte
	} || {
		VARIANT_DIR=$OUT_DIR/klte$V
	}
	$RDIR/build.sh $V
	MOVE_IMAGES
done

echo "Finished building NetHunter kernels!"
