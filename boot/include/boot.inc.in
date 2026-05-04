; ==========================================================
; Copyright (c) 2026 Phiarc Team and St Rangeset
; Licensed under the GNU General Public License v3.0
; https://github.com/phi-amateur-radio-community/io-puzzle
; ==========================================================
; Path /boot/include/boot.inc
; The constant definition of boot.


; ==========================================================
; Boot
; ==========================================================

BOOT_ORG            EQU 0x7C00
BOOT_SIGNATURE      EQU 0xAA55
BOOT_A20            EQU 0x92
BOOT_KERNEL_POS     EQU @KERNEL_POS@


; ==========================================================
; Gobal Descriptor Table ( GDT )
; ==========================================================

GDT_KERNEL_CODE     EQU 0x00CF9A000000FFFF
GDT_KERNEL_DATA     EQU 0x00CF92000000FFFF


; ==========================================================
; Programming Input/Output ( PIO )
; ==========================================================

PIO_DATA            EQU 0x1F0
PIO_SECTOR_NUM      EQU 0x1F2
PIO_LBA_LOW         EQU 0x1F3
PIO_LBA_MID         EQU 0x1F4
PIO_LBA_HIG         EQU 0x1F5
PIO_DEVICE          EQU 0x1F6
PIO_STATUS_COM      EQU 0x1F7
PIO_AS              EQU 0x3F6
PIO_DEVICE_LOC      EQU 0xE0
PIO_LBA             EQU 0x01
PIO_READ_COM        EQU 0x20
PIO_BSY             EQU 0x80
PIO_DRDY            EQU 0x10
PIO_DRQ             EQU 0x08

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
