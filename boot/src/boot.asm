; ======================================================================
; Copyright (c) 2026 Phiarc Team and St Rangeset
; Licensed under the GNU General Public License v3.0
; https://github.com/phi-amateur-radio-community/io-puzzle
; ======================================================================
; Path /boot/src/boot.asm
; Boot loader.

%INCLUDE "boot.inc"             ; Magic number header file

BITS 16
ORG BOOT_ORG

start:
    cli                         ; Close the BIOS interrupts

fast_a20:                       ; Open A20 line
    in  al, BOOT_A20
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


; ======================================================================
; Protection Mode Enable
; ======================================================================

BITS 32

protection:

flush:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x7c00

load_kernel:
    mov  al, PIO_DEVICE_LOC | (PIO_LBA >> 24)
    mov  dx, PIO_DEVICE
    out  dx, al                 ; Set device number

.test_status:                   ; Check whenever the device is busy
    mov  dx, PIO_STATUS_COM
    in   al, dx                 ; Read status from IO port
    test al, PIO_DRDY           ; Check DRDY ( drive ready )
    jz   .drive_err             ; Jump to drive error
    test al, PIO_BSY            ; Check BSY ( busy )
    jnz  .test_status           ; Repeat the program if BSY not equal 0

.read_set:
    mov  al, KERNEL_SIZE        ; Set sectors number of kernel
    mov  dx, PIO_SECTOR_NUM
    out  dx, al

    mov  al, 0x01               ; Set the low of LBA
    mov  dx, PIO_LBA_LOW
    out  dx, al

    mov  al, 0x00
    mov  dx, PIO_LBA_MID        ; Set the middle of LBA
    out  dx, al

    mov  dx, PIO_LBA_HIG        ; Set the high of LBA
    out  dx, al

.read_disk:
    mov  al, PIO_READ_COM       ; Send read command
    mov  dx, PIO_STATUS_COM
    out  dx, al

    mov  ebx, KERNEL_SIZE       ; Set the sector counter

    mov  eax, 0x10              ; Set the ES to the kernel data segment
    mov  es, eax

    mov  edi, BOOT_KERNEL_POS   ; Set the kernel loading position

    mov  dx, PIO_AS             ; Delay 400ns
    in   al, dx                 ; Read alternate status
    in   al, dx
    in   al, dx
    in   al, dx

.wait_drq:                      ; Check whenever the data is ready
    mov  dx, PIO_STATUS_COM
    in   al, dx
    test al, PIO_BSY            ; Check BSY
    jnz  .wait_drq

    test al, PIO_DRQ            ; Check DRQ
    jz   .wait_drq

.read_sector:
    mov  ecx, 0x00000100        ; Set simply sector length
    mov  edx, PIO_DATA          ; Connect the output port

    rep  insw                   ; Read to the memory from disk

    dec  ebx                    ; Reduce the sector counter
    jnz  .wait_drq              ; Repeat to wait and read


; ======================================================================
; MBR Ends And Enters The Kernel !!!
; ======================================================================

    jmp  0x08:BOOT_KERNEL_POS   ; Jump to the kernel


.drive_err:
    jmp  $                      ; Sleep


; ======================================================================
; Gobal Descriptor Table ( GDT )
; ======================================================================

gdt_start:
    dq 0                        ; Entry 0 ( NULL )
    dq GDT_KERNEL_CODE          ; Entry 1 ( Kernel code segment )
    dq GDT_KERNEL_DATA          ; Entry 2 ( Kernel data segment )
gdt_end:

gdt_ptr:
    dw gdt_end - gdt_start - 1
    dd gdt_start

fill_empty:
    times EMPTY_SIZE db 0       ; Fill in the empty space


tail:

; ======================================================================
; Custom Parameters
; ======================================================================

; Stand idle

; ======================================================================
; Partition Table
; ======================================================================

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

end:
