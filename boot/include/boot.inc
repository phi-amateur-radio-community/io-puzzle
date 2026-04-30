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


; ==========================================================
; Partition Table
; ==========================================================

PT_BOOT             EQU 0x00
PT_TYPE_FAT32_LBA   EQU 0x0C
PT_TYPE_CUST        EQU 0xDA
