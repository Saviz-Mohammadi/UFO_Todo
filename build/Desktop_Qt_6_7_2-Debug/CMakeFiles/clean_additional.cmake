# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/UFO_Todo_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/UFO_Todo_autogen.dir/ParseCache.txt"
  "UFO_Todo_autogen"
  "internal_libraries/lib_app_theme/CMakeFiles/Lib_AppTheme_autogen.dir/AutogenUsed.txt"
  "internal_libraries/lib_app_theme/CMakeFiles/Lib_AppTheme_autogen.dir/ParseCache.txt"
  "internal_libraries/lib_app_theme/Lib_AppTheme_autogen"
  "internal_libraries/lib_database/CMakeFiles/Lib_Database_autogen.dir/AutogenUsed.txt"
  "internal_libraries/lib_database/CMakeFiles/Lib_Database_autogen.dir/ParseCache.txt"
  "internal_libraries/lib_database/Lib_Database_autogen"
  "internal_libraries/lib_stop_timer/CMakeFiles/Lib_StopTimer_autogen.dir/AutogenUsed.txt"
  "internal_libraries/lib_stop_timer/CMakeFiles/Lib_StopTimer_autogen.dir/ParseCache.txt"
  "internal_libraries/lib_stop_timer/Lib_StopTimer_autogen"
  )
endif()
