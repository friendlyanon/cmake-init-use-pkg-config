# ---- Developer mode ----

# Developer mode enables targets and code paths in the CMake scripts that are
# only relevant for the developer(s) of use-pkg-config
# Targets necessary to build the project must be provided unconditionally, so
# consumers can trivially build and package the project
if(PROJECT_IS_TOP_LEVEL)
  option(use-pkg-config_DEVELOPER_MODE "Enable developer mode" OFF)
endif()

# ---- Warning guard ----

# target_include_directories with the SYSTEM modifier will request the compiler
# to omit warnings from the provided paths, if the compiler supports that
# This is to provide a user experience similar to find_package when
# add_subdirectory or FetchContent is used to consume this project
set(use-pkg-config_warning_guard "")
if(NOT PROJECT_IS_TOP_LEVEL)
  option(
      use-pkg-config_INCLUDES_WITH_SYSTEM
      "Use SYSTEM modifier for use-pkg-config's includes, disabling warnings"
      ON
  )
  mark_as_advanced(use-pkg-config_INCLUDES_WITH_SYSTEM)
  if(use-pkg-config_INCLUDES_WITH_SYSTEM)
    set(use-pkg-config_warning_guard SYSTEM)
  endif()
endif()

# ---- Enable customization of gumbo ----

set(
    use-pkg-config_GUMBO_PACKAGE_NAME gumbo
    CACHE STRING "The name of the package to import gumbo with"
)
set(
    use-pkg-config_GUMBO_PACKAGE_NAME_IN_CONFIG
    "${use-pkg-config_GUMBO_PACKAGE_NAME}"
    CACHE STRING
    "The name of the package to import gumbo with in the config file"
)
set(
    use-pkg-config_GUMBO_TARGET_NAME gumbo::gumbo
    CACHE STRING "The name of the target export from gumbo"
)
set(
    use-pkg-config_GUMBO_TARGET_NAME_IN_CONFIG
    "${use-pkg-config_GUMBO_TARGET_NAME}"
    CACHE STRING
    "The name of the target export from gumbo to use in the config file"
)
set(
    use-pkg-config_GUMBO_PROVIDE_FIND_MODULE ON
    CACHE BOOL "Install find module for gumbo"
)
mark_as_advanced(
    use-pkg-config_GUMBO_PACKAGE_NAME
    use-pkg-config_GUMBO_PACKAGE_NAME_IN_CONFIG
    use-pkg-config_GUMBO_TARGET_NAME
    use-pkg-config_GUMBO_TARGET_NAME_IN_CONFIG
    use-pkg-config_GUMBO_PROVIDE_FIND_MODULE
)
