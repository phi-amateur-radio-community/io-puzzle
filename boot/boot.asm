; Copyright (c) 2026 Phiarc Team and St Rangeset
; Licensed under the GNU General Public License v3.0
; https://github.com/phi-amateur-radio-community/io-puzzle

BITS 16
ORG 0x7C00

GLOBAL _start

SECTION .text
start:

; TODO: Boot Loader.

time 446 - ($ - $$) db 0 ; Fill in the empty space


; =========================================
; Partition table
; =========================================

SECTION .mbr
partition_table:

; Entry 0 (1 ~ 2047):
db 0x00             ; Boot flag
db 0x00, 0x02, 0x00 ; Start CHS
db 0xDA             ; Type: 0xDA (Customize)
db 0xFE, 0xFF, 0xFF ; End CHS
dd 0x00000001       ; Start sector (1)
dd 0x000008FF       ; Sector count (2047)

; Entry 1 (2048 ~ Unknown):
db 0x00             ; Boot flag
db 0x00, 0x02, 0x00 ; Start CHS
db 0x0C             ; Type: 0x0C (FAT32 LBA)
db 0xFE, 0xFF, 0xFF ; End CHS
dd 0x00000800       ; Start sector (2048)
dd 0x00000000       ; Sector count (Patch by core)

; Entry 2 ~ 3 (Null):
time 32 db 0 ; Fill in the empty space


SECTION .boot_sig
dw 0xAA55 ; MBR Boot Signature