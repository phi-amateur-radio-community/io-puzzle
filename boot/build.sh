#!/usr/bin/env bash
set -euo pipefail

if [ ! -f "disk.img" ]; then
  echo "disk not found, creating..."
  dd if=/dev/zero of=disk.img bs=512 count="${IMG_SIZE}" status=none
fi

nasm -f bin "${CURRENT_DIR}/boot.asm" -o boot.bin -I "${CURRENT_DIR}/include/"

dd if=boot.bin of=disk.img bs=512 conv=notrunc
