# [[ Custom Targets - TXT ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

set(RESOURCE_TXT_DESTINATION

    "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/resources/txt")




add_custom_target(CopyResources_TXT)




# Custom target for copying txt files...
foreach(RESOURCE_FILE ${RESOURCE_TXT_FILES})

    # Get the relative path of the file from where it differs to ${BASE_TXT_LOCATION}
    file(RELATIVE_PATH REL_PATH ${BASE_TXT_LOCATION} ${RESOURCE_FILE})

    # Construct the destination path including relative subdirectory
    set(DESTINATION_PATH "${RESOURCE_TXT_DESTINATION}/${REL_PATH}")

    message(STATUS "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")

    # Add your custom command to copy the file
    add_custom_command(TARGET CopyResources_TXT POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${RESOURCE_FILE}"
        "${DESTINATION_PATH}"
        COMMENT "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")
endforeach()




add_dependencies(${EXECUTABLE_NAME} CopyResources_TXT)

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Custom Targets - TXT ]]





# [[ Custom Targets - JSON ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

set(RESOURCE_JSON_DESTINATION

    "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/resources/json")




add_custom_target(CopyResources_JSON)




# Custom target for copying txt files...
foreach(RESOURCE_FILE ${RESOURCE_JSON_FILES})

    # Get the relative path of the file from where it differs to ${BASE_JSON_LOCATION}
    file(RELATIVE_PATH REL_PATH ${BASE_JSON_LOCATION} ${RESOURCE_FILE})

    # Construct the destination path including relative subdirectory
    set(DESTINATION_PATH "${RESOURCE_JSON_DESTINATION}/${REL_PATH}")

    message(STATUS "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")

    # Add your custom command to copy the file
    add_custom_command(TARGET CopyResources_JSON POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${RESOURCE_FILE}"
        "${DESTINATION_PATH}"
        COMMENT "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")
endforeach()




add_dependencies(${EXECUTABLE_NAME} CopyResources_JSON)

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Custom Targets - JSON ]]





# [[ Custom Targets - ICONS ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

set(RESOURCE_ICON_DESTINATION

    "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/resources/icons")




add_custom_target(CopyResources_ICON)




# Custom target for copying txt files...
foreach(RESOURCE_FILE ${RESOURCE_ICON_FILES})

    # Get the relative path of the file from where it differs to ${BASE_ICON_LOCATION}
    file(RELATIVE_PATH REL_PATH ${BASE_ICON_LOCATION} ${RESOURCE_FILE})

    # Construct the destination path including relative subdirectory
    set(DESTINATION_PATH "${RESOURCE_ICON_DESTINATION}/${REL_PATH}")

    message(STATUS "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")

    # Add your custom command to copy the file
    add_custom_command(TARGET CopyResources_ICON POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${RESOURCE_FILE}"
        "${DESTINATION_PATH}"
        COMMENT "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")
endforeach()




add_dependencies(${EXECUTABLE_NAME} CopyResources_ICON)

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Custom Targets - ICONS ]]





# [[ Custom Targets - FONTS ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

set(RESOURCE_FONT_DESTINATION

    "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/resources/fonts")




add_custom_target(CopyResources_FONT)




# Custom target for copying txt files...
foreach(RESOURCE_FILE ${RESOURCE_FONT_FILES})

    # Get the relative path of the file from where it differs to ${BASE_QML_LOCATION}
    file(RELATIVE_PATH REL_PATH ${BASE_FONT_LOCATION} ${RESOURCE_FILE})

    # Construct the destination path including relative subdirectory
    set(DESTINATION_PATH "${RESOURCE_FONT_DESTINATION}/${REL_PATH}")

    message(STATUS "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")

    # Add your custom command to copy the file
    add_custom_command(TARGET CopyResources_FONT POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${RESOURCE_FILE}"
        "${DESTINATION_PATH}"
        COMMENT "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")
endforeach()





add_dependencies(${EXECUTABLE_NAME} CopyResources_FONT)

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Custom Targets - FONTS ]]





# [[ Custom Targets - QML ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

set(RESOURCE_QML_DESTINATION

    "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/resources/qml")




add_custom_target(CopyResources_QML)




# Custom target for copying txt files...
foreach(RESOURCE_FILE ${RESOURCE_QML_FILES})

    # Get the relative path of the file from where it differs to ${BASE_QML_LOCATION}
    file(RELATIVE_PATH REL_PATH ${BASE_QML_LOCATION} ${RESOURCE_FILE})

    # Construct the destination path including relative subdirectory
    set(DESTINATION_PATH "${RESOURCE_QML_DESTINATION}/${REL_PATH}")

    message(STATUS "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")

    # Add your custom command to copy the file
    add_custom_command(TARGET CopyResources_QML POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${RESOURCE_FILE}"
        "${DESTINATION_PATH}"
        COMMENT "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")
endforeach()





add_dependencies(${EXECUTABLE_NAME} CopyResources_QML)

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Custom Targets - QML ]]





# [[ Custom Targets - MUSIC ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

set(RESOURCE_MUSIC_DESTINATION

    "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/resources/music")




add_custom_target(CopyResources_MUSIC)




# Custom target for copying txt files...
foreach(RESOURCE_FILE ${RESOURCE_MUSIC_FILES})

    # Get the relative path of the file from where it differs to ${BASE_QML_LOCATION}
    file(RELATIVE_PATH REL_PATH ${BASE_MUSIC_LOCATION} ${RESOURCE_FILE})

    # Construct the destination path including relative subdirectory
    set(DESTINATION_PATH "${RESOURCE_MUSIC_DESTINATION}/${REL_PATH}")

    message(STATUS "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")

    # Add your custom command to copy the file
    add_custom_command(TARGET CopyResources_MUSIC POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${RESOURCE_FILE}"
        "${DESTINATION_PATH}"
        COMMENT "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")
endforeach()





add_dependencies(${EXECUTABLE_NAME} CopyResources_MUSIC)

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Custom Targets - MUSIC ]]





# [[ Custom Targets - WINDOWS ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]

set(RESOURCE_WINDOWS_DESTINATION

    "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/resources/windows")




add_custom_target(CopyResources_WINDOWS)




# Custom target for copying txt files...
foreach(RESOURCE_FILE ${RESOURCE_WINDOWS_FILES})

    # Get the relative path of the file from where it differs to ${BASE_QML_LOCATION}
    file(RELATIVE_PATH REL_PATH ${BASE_WINDOWS_LOCATION} ${RESOURCE_FILE})

    # Construct the destination path including relative subdirectory
    set(DESTINATION_PATH "${RESOURCE_WINDOWS_DESTINATION}/${REL_PATH}")

    message(STATUS "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")

    # Add your custom command to copy the file
    add_custom_command(TARGET CopyResources_WINDOWS POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        "${RESOURCE_FILE}"
        "${DESTINATION_PATH}"
        COMMENT "Copying ${RESOURCE_FILE} to ${DESTINATION_PATH}")
endforeach()





add_dependencies(${EXECUTABLE_NAME} CopyResources_WINDOWS)

# [[ ----------------------------------------------------------------------- ]]
# [[ ----------------------------------------------------------------------- ]]
# [[ Custom Targets - WINDOWS ]]
