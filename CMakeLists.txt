cmake_minimum_required(VERSION 3.30)

set(_PATCH_VERSION "1" CACHE INTERNAL "Patch version")
set(PROJECT_VERSION 0.0.${_PATCH_VERSION})

project(project_name VERSION 0.0.${_PATCH_VERSION})

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_C_COMPILER /opt/homebrew/opt/llvm/bin/clang)
set(CMAKE_CXX_COMPILER /opt/homebrew/opt/llvm/bin/clang++)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(CMAKE_CXX_EXTENSIONS OFF)

# Let's nicely support folders in IDEs
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

set(CMAKE_CXX_FLAGS ${CompilerFlags} -stdlib=libc++)

if ($ENV{ASAN_ON})
    set(ASAN_SYMBOLIZER_PATH /usr/local/opt/llvm/bin)
    set(ASAN_OPTIONS detect_stack_use_after_return=1)
    set(CMAKE_CXX_FLAGS ${CompilerFlags} -fsanitize=address)

    add_compile_options(-g -O1 -fno-omit-frame-pointer -fno-optimize-sibling-calls)
    #    add_compile_options( -fno-omit-frame-pointer -fno-optimize-sibling-calls)
elseif ($ENV{LSAN_ON})
    set(LSAN_SYMBOLIZER_PATH /usr/local/opt/llvm/bin)
    set(CMAKE_CXX_FLAGS ${CompilerFlags} -fsanitize=leak)

    add_compile_options(-g -O1 -fno-omit-frame-pointer -fno-optimize-sibling-calls)
endif ()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/bin")

# Для нормального отображение содержимого STL контейнеров в дебагере
# https://www.jetbrains.com/help/clion/configuring-debugger-options.html #gdb-config
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -gdwarf-3 -D_LIBCPP_DEBUG=1 -D_GLIBCXX_DEBUG=1 -D_GLIBCXX_DEBUG_PEDANTIC=1")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -gdwarf-3")


# FetchContent added in CMake 3.11, downloads during the configure step
include(FetchContent)

add_subdirectory(src/hello_world)

