add_custom_command(
        OUTPUT
            boot.bin
            disk.img
        COMMAND
            ${CMAKE_COMMAND} -E env
            IMG_SIZE=${IMG_SIZE}
            CURRENT_DIR=${CMAKE_CURRENT_SOURCE_DIR}
            bash ${CMAKE_CURRENT_SOURCE_DIR}/tools/build.sh
        DEPENDS
            ${CMAKE_CURRENT_SOURCE_DIR}/src/boot.asm
            ${CMAKE_CURRENT_SOURCE_DIR}/include/boot.inc
)

add_custom_target(Boot ALL DEPENDS disk.img)

configure_file(tools/bochsrc.in ${CMAKE_BINARY_DIR}/bochsrc @ONLY)
