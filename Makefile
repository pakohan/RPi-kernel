.PHONY: all clean linux-config

TARGET=Image
ROOTFS_CONFIG=linux/initramfsconfig
ROOTFS_DIR=linux/usr/initramfs
KERNEL_CONFIG=linux/.config
CCPREFIX=arm-linux-gnueabi-

all: ${TARGET}

${TARGET}: ${ROOTFS_CONFIG} ${ROOTFS_DIR} ${KERNEL_CONFIG}
	make -C linux -j 3 ARCH=arm CROSS_COMPILE=${CCPREFIX}
	cp linux/arch/arm/boot/Image $@

${ROOTFS_CONFIG}: initramfsconfig
	cp $< $@

${ROOTFS_DIR}: initramfs
	cp -R $< $@

${KERNEL_CONFIG}: config
	cp $< $@

linux-config: config
	mv config linux/.config
	make -C linux nconfig ARCH=arm
	mv linux/.config config

clean:
	make -C linux mrproper
	rm -rf ${TARGET} ${ROOTFS_CONFIG} ${ROOTFS_DIR} ${KERNEL_CONFIG}

