#!/bin/bash
# simple script for executing menuconfig

# root directory of NetHunter klte git repo (default is this script's location)
RDIR=$(pwd)
<<<<<<< HEAD
DEFCONFIG=nethunter_defconfig
=======

# directory containing cross-compile arm toolchain
TOOLCHAIN=$HOME/build/toolchain/arm-cortex_a15-linux-gnueabihf-linaro_4.9.4-2015.06

export ARCH=arm
export CROSS_COMPILE=$TOOLCHAIN/bin/arm-eabi-

[ "$TARGET" ] || TARGET=nethunter
[ "$DEVICE" ] || DEVICE=klte
DEFCONFIG="${TARGET}_${DEVICE}_defconfig"
DEFCONFIG_FILE=$RDIR/arch/$ARCH/configs/$DEFCONFIG

[ -f "$RDIR/arch/$ARCH/configs/$DEFCONFIG" ] || {
	echo "Config $DEFCONFIG not found in $ARCH configs!"
	exit 1
}
>>>>>>> refs/remotes/jcadduono/cm-13.0

cd $RDIR
echo "Cleaning build..."
rm -rf build
mkdir build
<<<<<<< HEAD
ARCH=arm make -s -i -C $RDIR O=build $DEFCONFIG VARIANT_DEFCONFIG=$DEFCONFIG menuconfig
echo "Showing differences between old config and new config"
echo "-----------------------------------------------------"
command -v colordiff >/dev/null 2>&1 && {
	diff -Bwu --label "old config" arch/arm/configs/$DEFCONFIG --label "new config" build/.config | colordiff
} || {
	diff -Bwu --label "old config" arch/arm/configs/$DEFCONFIG --label "new config" build/.config
=======
make -s -i -C $RDIR O=build $DEFCONFIG menuconfig
echo "Showing differences between old config and new config"
echo "-----------------------------------------------------"
command -v colordiff >/dev/null 2>&1 && {
	diff -Bwu --label "old config" "$DEFCONFIG_FILE" --label "new config" build/.config | colordiff
} || {
	diff -Bwu --label "old config" "$DEFCONFIG_FILE" --label "new config" build/.config
>>>>>>> refs/remotes/jcadduono/cm-13.0
	echo "-----------------------------------------------------"
	echo "Consider installing the colordiff package to make diffs easier to read"
}
echo "-----------------------------------------------------"
echo -n "Are you satisfied with these changes? Y/N: "
read option
case $option in
y|Y)
<<<<<<< HEAD
	cp build/.config arch/arm/configs/$DEFCONFIG
	echo "Copied new config to arch/arm/configs/$DEFCONFIG"
=======
	cp build/.config "$DEFCONFIG_FILE"
	echo "Copied new config to $DEFCONFIG_FILE"
>>>>>>> refs/remotes/jcadduono/cm-13.0
	;;
*)
	echo "That's unfortunate"
	;;
esac
echo "Cleaning build..."
rm -rf build
echo "Done."
