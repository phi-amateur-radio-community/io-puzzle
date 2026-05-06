configure_file(linker.ld.in ${CMAKE_BINARY_DIR}/linker.ld @ONLY)
configure_file(include/boot.inc.in ${CMAKE_BINARY_DIR}/include/boot.inc @ONLY)
configure_file(tools/bochsrc.in ${CMAKE_BINARY_DIR}/bochsrc @ONLY)
configure_file(tools/run.sh ${CMAKE_BINARY_DIR}/run.sh COPYONLY)

# Build the kernel
enable_language(ASM_NASM)

add_library(KernelAsm OBJECT
        src/kernel/kernel.asm
)

add_executable(Kernel
        src/kernel/kernel.cpp
)

set_target_properties(Kernel PROPERTIES OUTPUT_NAME "kernel.elf")

target_link_libraries(Kernel PRIVATE KernelAsm)

target_link_options(Kernel PRIVATE
        -T ${CMAKE_BINARY_DIR}/linker.ld
        -nostdlib
        -ffreestanding
        -no-pie
        -fno-pie
)

add_custom_command(
    TARGET Kernel POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E env
        IMG_SIZE=${IMG_SIZE}
        CURRENT_DIR=${CMAKE_CURRENT_SOURCE_DIR}
        BINARY_DIR=${CMAKE_BINARY_DIR}
        bash ${CMAKE_CURRENT_SOURCE_DIR}/tools/build.sh
)
