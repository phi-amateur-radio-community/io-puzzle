; ======================================================================
; Copyright (c) 2026 Phiarc Team and St Rangeset
; Licensed under the GNU General Public License v3.0
; https://github.com/phi-amateur-radio-community/io-puzzle
; ======================================================================
; Path /boot/src/kernel/kernel.asm
; The entry of kernel.

BITS 32

GLOBAL _start

EXTERN kernel_main
EXTERN _stack_top

SECTION .entry

_start:
    mov esp, _stack_top
    mov ebp, esp
    call kernel_main
    hlt
