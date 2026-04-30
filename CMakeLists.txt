cmake_minimum_required(VERSION 3.16)
project(PaIoPuzzle C CXX ASM)

set(CMAKE_CXX_STANDARD 20)

include(cmake/CheckDeps.cmake)

add_subdirectory(core)
add_subdirectory(boot)
