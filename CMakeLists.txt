cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    use-pkg-config
    VERSION 0.1.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES NONE
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(use-pkg-config_use-pkg-config INTERFACE)
add_library(use-pkg-config::use-pkg-config ALIAS use-pkg-config_use-pkg-config)

set_property(
    TARGET use-pkg-config_use-pkg-config PROPERTY
    EXPORT_NAME use-pkg-config
)

target_include_directories(
    use-pkg-config_use-pkg-config ${use-pkg-config_warning_guard}
    INTERFACE
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_compile_features(use-pkg-config_use-pkg-config INTERFACE cxx_std_17)

find_package("${use-pkg-config_GUMBO_PACKAGE_NAME}" REQUIRED)
target_link_libraries(
    use-pkg-config_use-pkg-config INTERFACE
    "$<BUILD_INTERFACE:${use-pkg-config_GUMBO_TARGET_NAME}>"
)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT use-pkg-config_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of use-pkg-config"
  )
endif()

include(cmake/dev-mode.cmake)
