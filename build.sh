#!/bin/bash
# NetHunter kernel for Samsung Galaxy S5 build script by jcadduono
<<<<<<< HEAD
# This build script is for AOSP/CyanogenMod with Kali Nethunter support only
=======
# This build script is for CyanogenMod only
>>>>>>> refs/remotes/jcadduono/cm-13.0

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
<<<<<<< HEAD
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
=======
# eur     = kltexx, kltecan, kltetmo, klteub, klteatt
#           G900F,  G900W8,  G900T,   G900M,  G900A
#
# spr     = kltespr, kltedv
#           G900P,   G900I
#
# usc     = klteusc
#           G900R4
#
# vzw     = kltevzw
#           G900V
#
# duos    = klteduos
#           G900FD
#
# chn     = kltezn, kltezm
#           G9006V, SM-G9008V
#
# chnduo  = klteduoszn, klteduoszm, klteduosctc
#           SM-G9006W, SM-G9008W, SM-G9009W
#
# kdi     = kltekdi, kltedcm
#           SCL23,   SC-04F
#
# skt     = kltektt, klteskt, kltelgt
#           G900K,   G900S,   G900L
>>>>>>> refs/remotes/jcadduono/cm-13.0
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

<<<<<<< HEAD
=======
export ARCH=arm
export CROSS_COMPILE=$TOOLCHAIN/bin/arm-eabi-

[ "$DEVICE" ] || DEVICE=klte
[ "$TARGET" ] || TARGET=nethunter
>>>>>>> refs/remotes/jcadduono/cm-13.0
[ "$1" ] && {
	VARIANT=$1
} || {
	VARIANT=eur
}
<<<<<<< HEAD

[ -f "$RDIR/arch/arm/configs/variant_klte_$VARIANT" ] || {
	echo "Device variant/carrier $VARIANT not found in arm configs!"
	exit -1
}

export ARCH=arm
export CROSS_COMPILE=$TOOLCHAIN/bin/arm-eabi-
export LOCALVERSION="$VARIANT-cm13.0-$VER"
=======
DEFCONFIG=${TARGET}_${DEVICE}_defconfig
VARIANT_DEFCONFIG=variant_${DEVICE}_${VARIANT}

[ -f "$RDIR/arch/$ARCH/configs/$DEFCONFIG" ] || {
	echo "Config $DEFCONFIG not found in $ARCH configs!"
	exit 1
}

[ -f "$RDIR/arch/$ARCH/configs/$VARIANT_DEFCONFIG" ] || {
	echo "Variant $VARIANT not found for $DEVICE in $ARCH configs!"
	exit 1
}

export LOCALVERSION="$TARGET-$DEVICE-$VARIANT-$VER"
>>>>>>> refs/remotes/jcadduono/cm-13.0

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
<<<<<<< HEAD
	make -C $RDIR O=build nethunter_defconfig \
		VARIANT_DEFCONFIG=variant_klte_$VARIANT
=======
	make -C $RDIR O=build $DEFCONFIG \
		VARIANT_DEFCONFIG=$VARIANT_DEFCONFIG
>>>>>>> refs/remotes/jcadduono/cm-13.0
	echo "Starting build for $VARIANT..."
	make -C $RDIR O=build -j"$THREADS"
}

<<<<<<< HEAD
BUILD_DTB_IMG()
=======
BUILD_DTB()
>>>>>>> refs/remotes/jcadduono/cm-13.0
{
	echo "Generating dtb.img..."
	$RDIR/scripts/dtbTool/dtbTool -o $KDIR/dtb.img $KDIR/ -s 2048
}

<<<<<<< HEAD
CLEAN_BUILD && BUILD_KERNEL && BUILD_DTB_IMG

echo "Finished building $VARIANT!"
=======
CLEAN_BUILD && BUILD_KERNEL && BUILD_DTB && echo "Finished building $LOCALVERSION!"
>>>>>>> refs/remotes/jcadduono/cm-13.0
