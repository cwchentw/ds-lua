-- -*- mode: lua -*-

package = "ds"
version = "0.1.0-1"

source = {
    url = "..."
}

description = {
  summary = [[
Common algorithms for data science implemented in Lua
    ]],
  detailed = [[
    This library demostrates several common algorithms related to data science,
    including statistics and data mining, mostly in Lua.  Since Lua is a slow
    language compared to C/C++, you should not rely on this package for critical
    tasks. In addition, the package is still in alpha stage.  The API may change
    without warning.

    Compile the package with optional environment variable USE_OPENMP=1 to get
    OpenMP support.  This feature is still experimental.
    ]],
  homepage = "...",
  license = "MIT"
}

dependencies = {
  "lua >= 5.1, < 5.3",
  "algo >= 0.1.0-1"
}

build = {
  type = "make",
}
