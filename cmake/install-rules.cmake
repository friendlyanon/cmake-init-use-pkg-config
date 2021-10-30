if(PROJECT_IS_TOP_LEVEL)
  set(CMAKE_INSTALL_INCLUDEDIR include/use-pkg-config CACHE PATH "")
endif()

# Project is configured with no languages, so tell GNUInstallDirs the lib dir
set(CMAKE_INSTALL_LIBDIR lib CACHE PATH "")

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package use-pkg-config)

install(
    DIRECTORY include/
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT use-pkg-config_Development
)

install(
    TARGETS use-pkg-config_use-pkg-config
    EXPORT use-pkg-configTargets
    INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
    ARCH_INDEPENDENT
)

# Allow package maintainers to freely override the path for the configs
set(
    use-pkg-config_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(use-pkg-config_INSTALL_CMAKEDIR)

if(use-pkg-config_GUMBO_PROVIDE_FIND_MODULE)
  install(
      DIRECTORY cmake/find
      DESTINATION "${use-pkg-config_INSTALL_CMAKEDIR}"
      COMPONENT use-pkg-config_Development
  )
endif()

configure_file(cmake/install-config.cmake.in "${package}Config.cmake" @ONLY)

install(
    FILES
    "${PROJECT_BINARY_DIR}/${package}Config.cmake"
    "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${use-pkg-config_INSTALL_CMAKEDIR}"
    COMPONENT use-pkg-config_Development
)

install(
    EXPORT use-pkg-configTargets
    NAMESPACE use-pkg-config::
    DESTINATION "${use-pkg-config_INSTALL_CMAKEDIR}"
    COMPONENT use-pkg-config_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
