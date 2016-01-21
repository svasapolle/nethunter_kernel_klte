#!/bin/bash
# NetHunter kernel for Samsung Galaxy S5 build script by jcadduono
# This build script is for AOSP/CyanogenMod with Kali Nethunter support only

################### BEFORE STARTING ################
#
# download a working toolchain and extract it somewhere and configure this
# file to point to the toolchain's root directory.
# I highly recommend Christopher83's Linaro GCC 4.9.x Cortex-A15 toolchain.
# Download it here: http://forum.xda-developers.com/showthread.php?t=2098133
#
# once you've set up the config section how you like it, you can simply run
# ./build.sh
#
##################### VARIANTS #####################
#
# eur = kltexx, kltecan, kltetmo, klteub, klteatt, klteskt, kltektt
#       G900F,  G900W8,  G900T,   G900M,  G900A,   G900S,   G900K
#
# dv  = kltedv (Vodafone)
#       G900I
#
# kdi = kltekdi (Au by KDDI)
#       SCL23
#
# spr = kltespr (Sprint)
#       G900P
#
###################### CONFIG ######################

# root directory of NetHunter klte git repo (default is this script's location)
RDIR=$(pwd)

[ $VER ] || \
# version number
VER=$(cat $RDIR/VERSION)

# directory containing cross-compile arm-cortex_a15 toolchain
TOOLCHAIN=/home/jc/build/toolchain/arm-cortex_a15-linux-gnueabihf-linaro_4.9.4-2015.06

# amount of cpu threads to use in kernel make process
THREADS=5

############## SCARY NO-TOUCHY STUFF ###############

[ "$1" ] && {
	VARIANT=$1
} || {
	VARIANT=eur
}

[ -f "$RDIR/arch/arm/configs/variant_klte_$VARIANT" ] || {
	echo "Device variant/carrier $VARIANT not found in arm configs!"
	exit -1
}

export ARCH=arm
export CROSS_COMPILE=$TOOLCHAIN/bin/arm-eabi-
export LOCALVERSION="$VARIANT-cm12.1-$VER"

KDIR=$RDIR/build/arch/arm/boot

CLEAN_BUILD()
{
	echo "Cleaning build..."
	cd $RDIR
	rm -rf build
}

BUILD_KERNEL()
{
	echo "Creating kernel config..."
	cd $RDIR
	mkdir -p build
	make -C $RDIR O=build nethunter_defconfig \
		VARIANT_DEFCONFIG=variant_klte_$VARIANT
	echo "Starting build for $VARIANT..."
	make -C $RDIR O=build -j"$THREADS"
}

BUILD_DTB_IMG()
{
	echo "Generating dtb.img..."
	$RDIR/scripts/dtbTool/dtbTool -o $KDIR/dtb.img $KDIR/ -s 2048
}

CLEAN_BUILD && BUILD_KERNEL && BUILD_DTB_IMG

echo "Finished building $VARIANT!"
