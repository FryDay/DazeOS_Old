#!/bin/sh
set -e
. ./build.sh

mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub

cp sysroot/boot/dazeos.kernel isodir/boot/dazeos.kernel
cat > isodir/boot/grub/grub.cfg << EOF
menuentry "DazeOS" {
	multiboot /boot/dazeos.kernel
}
EOF
grub-mkrescue -o dazeos.iso isodir
