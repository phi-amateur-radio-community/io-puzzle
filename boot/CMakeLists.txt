add_custom_command(
        OUTPUT
            boot.bin
            disk.img
        COMMAND env
            IMG_SIZE=$ENV{IMG_SIZE}
            CURRENT_DIR=${CMAKE_CURRENT_SOURCE_DIR}
            bash ${CMAKE_CURRENT_SOURCE_DIR}/build.sh
        DEPENDS
            ${CMAKE_CURRENT_SOURCE_DIR}/boot.asm
            ${CMAKE_CURRENT_SOURCE_DIR}/include/boot.inc
)

add_custom_target(boot ALL DEPENDS disk.img)
