/* Path /boot/linker.ld         */
/* Link scription of kernel.    */

ENTRY(_start)

SECTIONS
{
    . = 0x100000;

    .text : {
        *(.entry)
        *(.text)
    }

    .rodata : { *(.rodata) }
    .data : { *(.data) }

    .bss : {
        *(COMMON)
        *(.bss)

        . = ALIGN(16);
        _stack_bottom = .;
        . += 0x4000;
        _stack_top = .;
    }
}
