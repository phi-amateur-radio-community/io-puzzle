add_custom_command(
        OUTPUT
            boot.bin
            kernel.bin
            disk.img
        COMMAND
            ${CMAKE_COMMAND} -E env
            IMG_SIZE=${IMG_SIZE}
            CURRENT_DIR=${CMAKE_CURRENT_SOURCE_DIR}
            bash ${CMAKE_CURRENT_SOURCE_DIR}/tools/build.sh
        DEPENDS
            ${CMAKE_CURRENT_SOURCE_DIR}/src/boot.asm
            ${CMAKE_CURRENT_SOURCE_DIR}/src/kernel/kernel.asm
            ${CMAKE_CURRENT_SOURCE_DIR}/include/boot.inc
)

add_custom_target(Boot ALL DEPENDS disk.img)

if(NOT DEFINED BOCHS_SHARE_PATH)
    set(BOCH_SHARE_PATH "/usr/share/bochs")
    message("Warning: You didn't set the share path of bochs, used default path.
            And you can used CMakeUserPresets.json to set it.")
endif ()

configure_file(tools/bochsrc.in ${CMAKE_BINARY_DIR}/bochsrc @ONLY)
configure_file(tools/run.in ${CMAKE_BINARY_DIR}/run.sh @ONLY)
