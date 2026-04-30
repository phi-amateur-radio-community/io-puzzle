add_custom_command(
        OUTPUT boot.bin
        COMMAND nasm -f bin ${CMAKE_CURRENT_SOURCE_DIR}/boot.asm -o boot.bin -I ${CMAKE_CURRENT_SOURCE_DIR}/include/
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/boot.asm
)

add_custom_target(boot ALL DEPENDS boot.bin)
