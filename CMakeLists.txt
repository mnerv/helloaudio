cmake_minimum_required(VERSION 3.12)
project(helloworld VERSION 0.0.0)

set(CMAKE_SUPPRESS_REGENERATION ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${WORKSPACE_LOCATION}/bin")

# compilation flags
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 17)

# miniaudio library
add_library(miniaudio STATIC IMPORTED)
set_target_properties(miniaudio PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES $ENV{MINIAUDIO_PATH}
    INTERFACE_LINK_DIRECTORIES $ENV{MINIAUDIO_PATH}/lib
)
if (NOT MSVC)
    set_target_properties(miniaudio PROPERTIES IMPORTED_LOCATION libminiaudio.a)
else()
    set_target_properties(miniaudio PROPERTIES IMPORTED_LOCATION miniaudio.lib)
endif()

# warnings and errors
if (NOT MSVC)
    string(JOIN " " CMAKE_CXX_FLAGS
        "-Wall"
        "-Wextra"
        "-Wconversion"
        "-Wpedantic"
        "-Werror"
    )
else()
    string(JOIN " " CMAKE_C_FLAGS
        "/W4"
        "/WX"
    )
endif()

# source files and includes
file(GLOB TARGET_SOURCE_FILES
    "${PROJECT_SOURCE_DIR}/helloworld.cpp"
)
add_executable(${PROJECT_NAME} ${TARGET_SOURCE_FILES})
include_directories(${PROJECT_NAME}
    "${PROJECT_SOURCE_DIR}"
    miniaudio
)
target_link_libraries(${PROJECT_NAME}
    miniaudio
)
source_group(TREE "${CMAKE_CURRENT_LIST_DIR}" FILES ${TARGET_SOURCE_FILES})
