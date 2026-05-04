#!/usr/bin/env bash
# Path /boot/tools/build.sh
# Build tool.

set -euo pipefail

# Check disk
if [ ! -f "disk.img" ]; then
  echo "disk not found, creating..."
  bximage -q -hd="${IMG_SIZE}" -func=create -sectsize=512 -imgmode=flat disk.img
fi

# Build kernel
nasm -f bin "${CURRENT_DIR}/src/kernel/kernel.asm" -o kernel.bin -I "${CURRENT_DIR}/include/"

# Calculate kernel size
kernel_size=$(stat -c%s kernel.bin)
kernel_sectors=$(( (kernel_size + 511) / 512))

# Build MBR
nasm -f bin "${CURRENT_DIR}/src/boot.asm" -DKERNEL_SIZE=${kernel_sectors} -o boot.bin -I "${CURRENT_DIR}/include/"

# Copy MBR to disk
dd if=boot.bin of=disk.img bs=512 conv=notrunc

# Copy kernel to disk
dd if=kernel.bin of=disk.img bs=512 conv=notrunc seek=1
