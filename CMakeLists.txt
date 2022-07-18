cmake_minimum_required(VERSION 3.12)
project(helloworld VERSION 0.0.0)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)         # Generate compile_commands.json for ccls
set(CMAKE_SUPPRESS_REGENERATION ON)           # Remove ZERO_CHECK target
set_property(GLOBAL PROPERTY USE_FOLDERS ON)  # Group CMake targets inside a folder

# Compilation flags
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 17)

# Output location
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/bin")

# miniaudio library
add_library(miniaudio STATIC IMPORTED)
find_library(MINIAUDIO_LIB
    NAMES libminiaudio.a miniaudio.lib
    PATHS "$ENV{MINIAUDIO_SDK}/build" "${PROJECT_SOURCE_DIR}/bin"
)
set_target_properties(miniaudio PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "$ENV{MINIAUDIO_SDK}"
    INTERFACE_LINK_DIRECTORIES "$ENV{MINIAUDIO_SDK}/build"
    IMPORTED_LOCATION "${MINIAUDIO_LIB}"
)

# warnings and errors
if (NOT MSVC)
    string(JOIN " " CMAKE_CXX_FLAGS
        ${CMAKE_CXX_FLAGS}
        "-Wall"
        "-Wextra"
        "-Wconversion"
        "-Wpedantic"
        "-Werror"
    )
else()
    string(JOIN " " CMAKE_CXX_FLAGS
        ${CMAKE_CXX_FLAGS}
        "/W4"
        "/WX"
    )
endif()

# Source files, include paths and library link
file(GLOB TARGET_SOURCE_FILES
    "${PROJECT_SOURCE_DIR}/helloworld.cpp"
)
add_executable(${PROJECT_NAME} ${TARGET_SOURCE_FILES})
include_directories(${PROJECT_SOURCE_DIR})
target_link_libraries(${PROJECT_NAME}
    miniaudio
)

# Show the file directory structure inside IDE
source_group(TREE "${CMAKE_CURRENT_LIST_DIR}" FILES ${TARGET_SOURCE_FILES})
