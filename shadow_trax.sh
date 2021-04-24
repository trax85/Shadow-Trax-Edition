#
# Custom build script for Shadow kernel
#
# Copyright 2016 Umang Leekha (Umang96@xda)
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# Please maintain this if you use this script or any part of it.
#
DEVICE="Kenzo"
yellow='\033[0;33m'
white='\033[0m'
red='\033[0;31m'
gre='\e[0;32m'
echo -e ""
echo -e "$gre ====================================\n\n Welcome to Shadow building program !\n\n ===================================="
echo -e "$gre \n 1.Build Shadow Clean\n\n 2.Build Shadow Dirty\n"
echo -n " Enter your choice:"
read qc
echo -e "$white"
KERNEL_DIR=$PWD
cd $KERNEL_DIR/arch/arm/boot/dts/
rm *.dtb > /dev/null 2>&1
cd $KERNEL_DIR
Start=$(date +"%s")
DTBTOOL=$KERNEL_DIR/dtbTool
cd $KERNEL_DIR
if [ $qc == 1 ]; then
echo -e "$yellow Running make clean before compiling \n$white"
make clean > /dev/null
fi
#
# Do Kenzo Configs
#
export ARCH=arm64
make shadow_trax_defconfig
#
# Export Clang path
#
export CROSS_COMPILE="/home/nesara/aarch64-elf-gcc/bin/aarch64-elf-" CROSS_COMPILE_ARM32="/home/nesara/aarch32-gcc/bin/arm-eabi-"
export KBUILD_BUILD_USER="trax85"
#
# Build Shadow Kernel
#
make	-j4
#
# Append date,time and Export Image and device tree
#
time=$(date +"%d-%m-%y-%T")
date=$(date +"%d-%m-%y")
$DTBTOOL -2 -o $KERNEL_DIR/arch/arm64/boot/dt.img -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/arch/arm/boot/dts/
mv $KERNEL_DIR/arch/arm64/boot/dt.img $KERNEL_DIR/build/tools/dt.img
cp $KERNEL_DIR/arch/arm64/boot/Image $KERNEL_DIR/build/tools/Image
zimage=$KERNEL_DIR/arch/arm64/boot/Image
if ! [ -a $zimage ];
then
echo -e "$red << Failed to compile zImage, fix the errors first >>$white"
else
cd $KERNEL_DIR/build
rm *.zip > /dev/null 2>&1
#
# Zip Flash Tools and make shadow zip
#
echo -e "$yellow\n Build succesful, generating flashable zip now \n $white"
zip -r Shadow-Trax-Kernel-$date.zip * > /dev/null
End=$(date +"%s")
Diff=$(($End - $Start))
echo -e "$yellow $KERNEL_DIR/export/$VERSION/Shadow-Trax-Kernel-$date.zip \n$white"
echo -e "$gre << Build completed in $(($Diff / 60)) minutes and $(($Diff % 60)) seconds >> \n $white"
fi
cd $KERNEL_DIR
