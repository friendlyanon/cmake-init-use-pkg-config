cmake_minimum_required(VERSION 3.14)

project(use-pkg-configTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)

if(PROJECT_IS_TOP_LEVEL)
  find_package(use-pkg-config REQUIRED)
  enable_testing()
endif()

add_executable(use-pkg-config_test source/use-pkg-config_test.cpp)
target_link_libraries(use-pkg-config_test PRIVATE use-pkg-config::use-pkg-config)
target_compile_features(use-pkg-config_test PRIVATE cxx_std_17)

add_test(NAME use-pkg-config_test COMMAND use-pkg-config_test)
