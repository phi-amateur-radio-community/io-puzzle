; ==========================================================
; Copyright (c) 2026 Phiarc Team and St Rangeset
; Licensed under the GNU General Public License v3.0
; https://github.com/phi-amateur-radio-community/io-puzzle
; ==========================================================

%INCLUDE "boot.inc"             ; Magic number header file

BITS 16
ORG BOOT_ORG

GLOBAL _start

start:
    cli                         ; Close the BIOS interrupts

fast_a20:                       ; Open A20 line
    mov al, BOOT_A20
    or  al, 0x02
    out BOOT_A20, al

load_gdt:
    lgdt [gdt_ptr]              ; Load GDT

protection_enable:
    mov eax, cr0
    or  eax, 1
    mov cr0, eax                ; Open protection mode

far_jump:
    jmp 0x08:protection         ; Change to 32-bits mode


; ==========================================================
; Protection Mode Enable
; ==========================================================

BITS 32

protection:


; ==========================================================
; Gobal Descriptor Table ( GDT )
; ==========================================================

gdt_start:
    dq 0                        ; Entry 0 ( NULL )
    dq GDT_KERNEL_CODE          ; Entry 1 ( Kernel code segment )
    dq GDT_KERNEL_DATA          ; Entry 2 ( Kernel data segment )
gdt_end:

gdt_ptr:
    dw gdt_end - gdt_start - 1
    dd gdt_start


    times 446 - ($ - $$) db 0   ; Fill in the empty space


; ==========================================================
; Partition Table
; ==========================================================

partition_table:

    ; Entry 0 (1 ~ 2047):
    db PT_BOOT                  ; Boot flag
    db 0x00, 0x02, 0x00         ; Start CHS
    db PT_TYPE_CUST             ; Type: 0xDA (Customize)
    db 0xFE, 0xFF, 0xFF         ; End CHS
    dd 0x00000001               ; Start sector (1)
    dd 0x000008FF               ; Sector count (2047)

    ; Entry 1 (2048 ~ Unknown):
    db PT_BOOT                  ; Boot flag
    db 0x00, 0x02, 0x00         ; Start CHS
    db PT_TYPE_FAT32_LBA        ; Type: 0x0C (FAT32 LBA)
    db 0xFE, 0xFF, 0xFF         ; End CHS
    dd 0x00000800               ; Start sector (2048)
    dd 0x00000000               ; Sector count (Patch by core)

    ; Entry 2 ~ 3 (Null):
    times 32 db 0               ; Fill in the empty space


    dw BOOT_SIGNATURE           ; MBR Boot Signature
