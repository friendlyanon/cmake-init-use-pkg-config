#[=======================================================================[.rst:
Findgumbo
---------

Find the `gumbo-parser library <https://github.com/google/gumbo-parser>`_.

IMPORTED Targets
^^^^^^^^^^^^^^^^

This module defines the :prop_tgt:`IMPORTED` target ``gumbo::gumbo``, if
gumbo-parser has been found.

Result Variables
^^^^^^^^^^^^^^^^

This module defines the following variables:

``gumbo_FOUND``
  The system has gumbo-parser.

Cache variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``gumbo_LIBRARY``
  The gumbo-parser library file.

``gumbo_INCLUDE_DIR``
  The gumbo-parser include directory.

Hints
^^^^^

Because gumbo-parser provides
`pkg-config <https://www.freedesktop.org/wiki/Software/pkg-config/>`_ files,
those will attempted to be used.  The following environment variable may also
be set to affect that:

``PKG_CONFIG_PATH``
  A ``PATH``-like variable that may be set to ``<gumbo-prefix>/lib/pkgconfig``,
  if gumbo-parser was installed to a custom location.
#]=======================================================================]

set(quiet "")
if(gumbo_FIND_QUIETLY)
  set(quiet QUIET)
endif()

# gumbo provides .pc files, let's try to use pkg-config if available
find_package(PkgConfig ${quiet})
if(PkgConfig_FOUND)
  pkg_check_modules(gumbo ${quiet} gumbo)
else()
  set(gumbo_FOUND NO)
endif()

# If either pkg-config is not installed or the .pc file couldn't be found, then
# just fall back to find_*() commands. The user can set these cache variables
# in either case.
if(gumbo_FOUND)
  set(gumbo_LIBRARY "${gumbo_LINK_LIBRARIES}" CACHE FILEPATH "Path to gumbo")
  set(gumbo_INCLUDE_DIR "${gumbo_INCLUDE_DIRS}" CACHE PATH "Path to gumbo")
else()
  find_library(gumbo_LIBRARY NAMES gumbo)
  find_path(gumbo_INCLUDE_DIR NAMES gumbo.h)
endif()
mark_as_advanced(gumbo_LIBRARY gumbo_INCLUDE_DIR)

# Use this CMake provided module to check the variables. The version
# information will exist only if pkg-config found gumbo, otherwise this doesn't
# do anything with version requirements.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    gumbo
    REQUIRED_VARS gumbo_LIBRARY gumbo_INCLUDE_DIR
    VERSION_VAR gumbo_VERSION
)

# Create a library target only if the above checks passed
if(gumbo_FOUND AND NOT TARGET gumbo::gumbo)
  # Can't easily tell how gumbo was compiled, so just default to UNKNOWN
  # library type and CMake will make a best effort guess
  add_library(gumbo::gumbo UNKNOWN IMPORTED)

  set_property(
      TARGET gumbo::gumbo PROPERTY
      INTERFACE_INCLUDE_DIRECTORIES "${gumbo_INCLUDE_DIR}"
  )
  if(EXISTS "${gumbo_LIBRARY}")
    set_property(
        TARGET gumbo::gumbo PROPERTY
        IMPORTED_LOCATION "${gumbo_LIBRARY}"
    )
  endif()
endif()
