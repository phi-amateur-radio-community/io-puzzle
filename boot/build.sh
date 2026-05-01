#!/usr/bin/env bash
set -euo pipefail

if [ ! -f "disk.img" ]; then
  echo "disk not found, creating..."
  bximage -q -hd="${IMG_SIZE}" -func=create -sectsize=512 -imgmode=flat disk.img
fi

nasm -f bin "${CURRENT_DIR}/boot.asm" -o boot.bin -I "${CURRENT_DIR}/include/"

dd if=boot.bin of=disk.img bs=512 conv=notrunc
