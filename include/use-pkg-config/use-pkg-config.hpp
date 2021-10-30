#pragma once

#include <string>

#include <gumbo.h>

/**
 * @brief Return the name of this header-only library
 */
inline auto name() -> std::string
{
  return "use-pkg-config";
}
