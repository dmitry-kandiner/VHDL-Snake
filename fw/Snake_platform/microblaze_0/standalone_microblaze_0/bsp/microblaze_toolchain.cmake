# Copyright (C) 2023 Advanced Micro Devices, Inc.  All rights reserved.
# SPDX-License-Identifier: MIT
set( CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY" )
set( CMAKE_EXPORT_COMPILE_COMMANDS ON)
set( CMAKE_TRY_COMPILE_PLATFORM_VARIABLES CMAKE_LIBRARY_PATH)
set( CMAKE_INSTALL_MESSAGE LAZY)
set( CMAKE_C_COMPILER mb-gcc )
set( CMAKE_CXX_COMPILER mb-g++ )
set( CMAKE_C_COMPILER_LAUNCHER  )
set( CMAKE_CXX_COMPILER_LAUNCHER  )
set( CMAKE_ASM_COMPILER mb-gcc )
set( CMAKE_AR mb-ar CACHE FILEPATH "Archiver" )
set( CMAKE_SIZE mb-size CACHE FILEPATH "Size" )
set( CMAKE_SYSTEM_PROCESSOR "microblaze" )
set( CMAKE_SYSTEM_NAME "Generic" )
set( CMAKE_HW_FLAGS "-mxl-barrel-shift -mlittle-endian -mxl-pattern-compare -mno-xl-reorder -mno-xl-soft-mul -mno-xl-soft-div -mcpu=v11.0" )

set( CMAKE_COMPILER_LIB_PATH "C:/Xilinx/Vitis/2024.1/gnu/microblaze/nt/microblazeeb-xilinx-elf/usr/lib/le/bs/p/m/" )

set( CMAKE_SPECS_FILE "$ENV{ESW_REPO}/scripts/specs/microblaze/Xilinx.spec" CACHE STRING "Specs file path for using CMAKE toolchain files" )
set( TOOLCHAIN_C_FLAGS " -O2 ${CMAKE_HW_FLAGS} -DSDT" CACHE STRING "CFLAGS" )
set( TOOLCHAIN_CXX_FLAGS " -O2 ${CMAKE_HW_FLAGS} -DSDT" CACHE STRING "CXXFLAGS" )
set( TOOLCHAIN_ASM_FLAGS " -O2 ${CMAKE_HW_FLAGS} -DSDT" CACHE STRING "ASM FLAGS" )
set( TOOLCHAIN_DEP_FLAGS " -MMD -MP" CACHE STRING "Flags used by compiler to generate dependency files")
set( TOOLCHAIN_EXTRA_C_FLAGS " -g -ffunction-sections -fdata-sections -Wall -Wextra -fno-tree-loop-distribute-patterns" CACHE STRING "Extra CFLAGS")
set( CMAKE_C_LINK_FLAGS " -Wl,--no-relax -Wl,--gc-sections" CACHE STRING "LDFLAGS")
set( CMAKE_CXX_LINK_FLAGS " -Wl,--no-relax -Wl,--gc-sections" CACHE STRING "LDFLAGS")
set( CMAKE_C_FLAGS_RELEASE "-DNDEBUG" CACHE STRING "Additional CFLAGS for release" )
set( CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG" CACHE STRING "Additional CXXFLAGS for release" )
set( CMAKE_ASM_FLAGS_RELEASE "-DNDEBUG" CACHE STRING "Additional ASM FLAGS for release" )
set( CMAKE_C_FLAGS "${TOOLCHAIN_C_FLAGS} ${TOOLCHAIN_DEP_FLAGS} -specs=${CMAKE_SPECS_FILE} -I${CMAKE_INCLUDE_PATH}" CACHE STRING "CFLAGS")
set( CMAKE_CXX_FLAGS "${TOOLCHAIN_CXX_FLAGS} ${TOOLCHAIN_DEP_FLAGS} -specs=${CMAKE_SPECS_FILE} -I${CMAKE_INCLUDE_PATH}" CACHE STRING "CXXFLAGS")
set( CMAKE_ASM_FLAGS "${TOOLCHAIN_ASM_FLAGS} ${TOOLCHAIN_DEP_FLAGS} -specs=${CMAKE_SPECS_FILE} -I${CMAKE_INCLUDE_PATH}" CACHE STRING "ASMFLAGS")
