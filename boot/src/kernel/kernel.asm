; ======================================================================
; Copyright (c) 2026 Phiarc Team and St Rangeset
; Licensed under the GNU General Public License v3.0
; https://github.com/phi-amateur-radio-community/io-puzzle
; ======================================================================
; Path /boot/src/kernel/kernel.asm
; The entry of kernel.

BITS 32
ORG 0x00100000

GLOBAL _start

SECTION .entry

_start:
    hlt
    jmp $   ; Sleep
