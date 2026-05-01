; ==========================================================
; Copyright (c) 2026 Phiarc Team and St Rangeset
; Licensed under the GNU General Public License v3.0
; https://github.com/phi-amateur-radio-community/io-puzzle
; ==========================================================


; ==========================================================
; Boot
; ==========================================================

BOOT_ORG            EQU 0x7C00
BOOT_SIGNATURE      EQU 0xAA55
BOOT_A20            EQU 0x92


; ==========================================================
; Gobal Descriptor Table ( GDT )
; ==========================================================

GDT_KERNEL_CODE     EQU 0x00CF9A000000FFFF
GDT_KERNEL_DATA     EQU 0x00CF92000000FFFF


; ==========================================================
; Partition Table
; ==========================================================

PT_BOOT             EQU 0x00
PT_TYPE_FAT32_LBA   EQU 0x0C
PT_TYPE_CUST        EQU 0xDA


; ==========================================================
; Macro Definition
; ==========================================================

%define EMPTY_SIZE  512 - ($ - $$) - (end - tail)
