cmake_minimum_required(VERSION 3.16)
project(PaIoPuzzle C CXX ASM)

set(CMAKE_CXX_STANDARD 20)

if (NOT NASM_EXECUTABLE)
    find_program(NASM_EXECUTABLE nasm)
endif ()

if (NOT NASM_EXECUTABLE)
    message(FATAL_ERROR "NASM is required but not found.")
endif ()

add_subdirectory(core)
add_subdirectory(boot)