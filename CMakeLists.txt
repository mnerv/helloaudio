cmake_minimum_required(VERSION 3.12)
project(helloworld VERSION 0.0.0)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)         # Generate compile_commands.json for ccls
set(CMAKE_SUPPRESS_REGENERATION ON)           # Remove ZERO_CHECK target
set_property(GLOBAL PROPERTY USE_FOLDERS ON)  # Group CMake targets inside a folder

# miniaudio library
add_library(miniaudio STATIC IMPORTED)
find_library(MINIAUDIO_LIB
    NAMES libminiaudio.a miniaudio.lib
    PATHS "$ENV{MINIAUDIO_SDK}/build" "${PROJECT_SOURCE_DIR}/build"
)
set_target_properties(miniaudio PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "$ENV{MINIAUDIO_SDK}"
    INTERFACE_LINK_DIRECTORIES "$ENV{MINIAUDIO_SDK}/build"
    IMPORTED_LOCATION "${MINIAUDIO_LIB}"
)

#find_package(ncurses 6.3 REQUIRED)

# Source files, include paths and library link
file(GLOB TARGET_SOURCE_FILES
    "${PROJECT_SOURCE_DIR}/helloworld.cpp"
)
add_executable(${PROJECT_NAME} ${TARGET_SOURCE_FILES})
target_include_directories(${PROJECT_NAME}
    PRIVATE
        ${PROJECT_SOURCE_DIR}
)
target_link_libraries(${PROJECT_NAME}
    PRIVATE
        miniaudio
)
target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_20)
if (NOT MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE
        "-Wall"
        "-Wextra"
        "-Wconversion"
        "-Wpedantic"
        "-Werror"
    )
else()
    target_compile_options(${PROJECT_NAME} PRIVATE
        "/W4"
        "/WX"
    )
endif()

# Show the file directory structure inside IDE
source_group(TREE "${CMAKE_CURRENT_LIST_DIR}" FILES ${TARGET_SOURCE_FILES})

