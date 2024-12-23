# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "E:\\fpga\\VHDL-Snake\\fw\\Snake_platform\\microblaze_0\\standalone_microblaze_0\\bsp\\include\\sleep.h"
  "E:\\fpga\\VHDL-Snake\\fw\\Snake_platform\\microblaze_0\\standalone_microblaze_0\\bsp\\include\\xiltimer.h"
  "E:\\fpga\\VHDL-Snake\\fw\\Snake_platform\\microblaze_0\\standalone_microblaze_0\\bsp\\include\\xtimer_config.h"
  "E:\\fpga\\VHDL-Snake\\fw\\Snake_platform\\microblaze_0\\standalone_microblaze_0\\bsp\\lib\\libxiltimer.a"
  )
endif()
