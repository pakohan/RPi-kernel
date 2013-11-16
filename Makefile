.PHONY: all clean

TARGET=linux/arch/arm/boot/Image
ROOTFS_CONFIG=linux/initramfsconfig
ROOTFS_DIR=linux/usr/initramfs
KERNEL_CONFIG=linux/.config
CCPREFIX=arm-linux-gnueabi-

all: ${TARGET}

${TARGET}: ${ROOTFS_CONFIG} ${ROOTFS_DIR} ${KERNEL_CONFIG}
	make -C linux -j 3 ARCH=arm CROSS_COMPILE=${CCPREFIX}

${ROOTFS_CONFIG}: initramfsconfig
	cp $< $@

${ROOTFS_DIR}: initramfs
	cp -R $< $@

${KERNEL_CONFIG}: config
	cp $< $@

clean:
	make -C linux mrproper
	rm -rf ${ROOTFS_CONFIG} ${ROOTFS_DIR} ${KERNEL_CONFIG}




#make mrproper
#export CCPREFIX=arm-linux-gnueabi-
#make -j 3 ARCH=arm CROSS_COMPILE=${CCPREFIX} oldconfig
#make -j 3 ARCH=arm CROSS_COMPILE=${CCPREFIX}
#make -j 3 ARCH=arm CROSS_COMPILE=${CCPREFIX} modules
#export MODULES_TEMP=~/modules
#make -j 3 ARCH=arm CROSS_COMPILE=${CCPREFIX} INSTALL_MOD_PATH=${MODULES_TEMP} modules_install

