local Vector = require "ds.DoubleVector"
local LuaVector = require "ds.LuaVector"

do
  local v = Vector:new(3)
  assert(v:len(), 3)
  assert(v:get(1) == 0)
  assert(v:get(2) == 0)
  assert(v:get(3) == 0)
end

-- Create a vector from a table.
do
  local v = Vector:from_table({1, 2, 3})
  assert(v:len(), 3)
  assert(v:get(1) == 1)
  assert(v:get(2) == 2)
  assert(v:get(3) == 3)
end

-- Magnitude.
do
  local v = Vector:from_table({1, 2, 3})
  assert(math.abs(v:magnitude() - 3.741657) < 1e-6)
end

-- Vector equality
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({1, 2, 3})
  local v3 = Vector:from_table({2, 3, 4})
  local v4 = Vector:from_table({1, 2, 3, 4})

  assert(v1 == v2)
  assert(v1 ~= v3)
  assert(v1 ~= v4)
end

-- Vector addition
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({2, 3, 4})

  local v = v1 + v2
  assert(v == Vector:from_table({3, 5, 7}))
end

-- Vector scalar addition
do
  local v1 = Vector:from_table({1, 2, 3})

  local v2 = v1 + 3
  assert(v2 == Vector:from_table({4, 5, 6}))

  local v3 = 3 + v1
  assert(v3 == Vector:from_table({4, 5, 6}))
end

-- Vector substration.
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({2, 3, 4})

  local v = v1 - v2
  assert(v == Vector:from_table({-1, -1, -1}))
end

-- Vector scalar substration
do
  local v1 = Vector:from_table({1, 2, 3})

  local v2 = v1 - 3
  assert(v2 == Vector:from_table({-2, -1, 0}))

  local v3 = 3 - v1
  assert(v3 == Vector:from_table({2, 1, 0}))
end

-- Vector multiplication.
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({2, 3, 4})

  local v = v1 * v2
  assert(v == Vector:from_table({2, 6, 12}))
end

-- Vector scalar multiplication.
do
  local v1 = Vector:from_table({1, 2, 3})

  local v2 = v1 * 3
  assert(v2 == Vector:from_table({3, 6, 9}))

  local v3 = 3 * v1
  assert(v3 == Vector:from_table({3, 6, 9}))
end

-- Vector division.
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({2, 3, 4})

  local v = v1 / v2

  assert(math.abs(v:get(1) - 0.5) < 1e-6)
  assert(math.abs(v:get(2) - 0.666666) < 1e-6)
  assert(math.abs(v:get(3) - 0.75) < 1e-6)
end

-- Vector scalar division.
do
  local v1 = Vector:from_table({1, 2, 3})

  local v2 = v1 / 3
  assert(math.abs(v2:get(1) - 0.333333) < 1e-6)
  assert(math.abs(v2:get(2) - 0.666666) < 1e-6)
  assert(math.abs(v2:get(3) - 1) < 1e-6)

  local v3 = 3 / v1
  assert(math.abs(v3:get(1) - 3) < 1e-6)
  assert(math.abs(v3:get(2) - 1.5) < 1e-6)
  assert(math.abs(v3:get(3) - 1) < 1e-6)
end

-- Vector power.
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({2, 3, 4})

  local v = v1 ^ v2

  assert(math.abs(v:get(1) - 1) < 1e-6)
  assert(math.abs(v:get(2) - 8) < 1e-6)
  assert(math.abs(v:get(3) - 81) < 1e-6)
end

-- Vector scalar power.
do
  local v1 = Vector:from_table({1, 2, 3})

  local v2 = v1 ^ 3
  assert(math.abs(v2:get(1) - 1) < 1e-6)
  assert(math.abs(v2:get(2) - 8) < 1e-6)
  assert(math.abs(v2:get(3) - 27) < 1e-6)

  local v3 = 3 ^ v1
  assert(math.abs(v3:get(1) - 3) < 1e-6)
  assert(math.abs(v3:get(2) - 9) < 1e-6)
  assert(math.abs(v3:get(3) - 27) < 1e-6)
end

-- Vector dot operation.
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({2, 3, 4})

  local result = v1:dot(v2)
  assert(result == (1 * 2 + 2 * 3 + 3 * 4))
end

-- Vector dot operation on different vector class.
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = LuaVector:from_table({2, 3, 4})

  local result = v1:dot(v2)
  assert(result == (1 * 2 + 2 * 3 + 3 * 4))
end

-- Prevent segmentation fault
os.exit(0)

