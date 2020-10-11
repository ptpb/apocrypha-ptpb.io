#!/bin/sh

set -ex

IMAGES=$PWD/build/images

if [ ! -f $PWD/test-data.img ]; then
    truncate -s100M test-data.img
    mkfs.ext4 test-data.img
fi

#    -net nic,model=virtio \
#    -net tap,ifname=tap0,script=no,downscript=no \

qemu-system-x86_64 \
    -machine q35 \
    -accel kvm \
    -display none \
    -m 512 \
    -kernel $IMAGES/bzImage \
    -append "root=/dev/vda console=ttyS0" \
    -drive file=$IMAGES/rootfs.squashfs,if=virtio,format=raw \
    -drive file=$PWD/test-data.img,if=virtio,format=raw \
    -net nic,model=virtio \
    -net user \
    -device virtio-serial-pci \
    -serial mon:stdio \
    -device virtio-rng-pci
