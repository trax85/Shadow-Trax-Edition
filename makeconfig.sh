#directories
KERNEL_DIR=$PWD

export CROSS_COMPILE="/home/$USER/toolchain/aarch64-linux-android-6.x/bin/aarch64-linux-android-"
export ARCH=arm64
export SUBARCH=arm64
export USE_CCACHE=1
make clean > /dev/null
make shadow_defconfig
export KBUILD_BUILD_HOST="xda"
export KBUILD_BUILD_USER="energyspear17"
make menuconfig
cp shadow_defconfig arch/arm64/configs/shadow_defconfig
echo -e "$cyan Config Copied $nc"
