# ==========================================================
# Dependency Check
# ==========================================================

# NASM
if (NOT NASM_EXECUTABLE)
    find_program(NASM_EXECUTABLE nasm)
endif ()

if (NOT NASM_EXECUTABLE)
    message(FATAL_ERROR "NASM is required but not found.")
endif ()

# DD
if (NOT DD_EXECUTABLE)
    find_program(DD_EXECUTABLE dd)
endif ()

if (NOT DD_EXECUTABLE)
    message(FATAL_ERROR
            "dd is recommended for image building.\n"
            "If it is not available, you may:\n"
            "1) Create CMakeUserPresets.json and set DD_EXECUTABLE to empty or override it\n"
            "2) Comment out dd checks in cmake/CheckDeps.cmake\n"
            "3) Check boot/CMakeLists.txt for dd usage and replace it manually or via automation\n"
            "   (you may submit a PR to properly support a fallback implementation)")
endif ()
