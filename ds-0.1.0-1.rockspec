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
    including statistics and data mining, in Lua.  Since Lua is a slow language
    compared to C/C++, you should not rely on this package for critical tasks.
    In addition, the package is still in alpha stage.  The API may change
    without warning.
    ]],
  homepage = "...",
  license = "MIT"
}

dependencies = {
  "lua >= 5.1, < 5.2",
  "algo >= 0.1.0-1"
}

build = {
  type = "make",
}
