file(GLOB_RECURSE HEADER_LIST CONFIGURE_DEPENDS "${PROJECT_SOURCE_DIR}/src/hello_world/*.h")
file(GLOB_RECURSE SOURCES_LIST CONFIGURE_DEPENDS "${PROJECT_SOURCE_DIR}/src/hello_world/*.cpp")

add_executable(hello_world ${SOURCES_LIST} ${HEADER_LIST})
target_compile_features(hello_world PRIVATE cxx_std_23)
target_compile_options(hello_world PRIVATE -Wall -Wextra -pedantic -Werror)


