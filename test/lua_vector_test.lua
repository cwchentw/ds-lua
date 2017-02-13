local Vector = require "ds.LuaVector"

do
  local v = Vector:new(3)
  assert(v:len(), 3)
  assert(v:get(1) == 0)
  assert(v:get(2) == 0)
  assert(v:get(3) == 0)
end

do
  v = Vector:from_table({1, 2, 3})
  assert(v:len(), 3)
  assert(v:get(1) == 1)
  assert(v:get(2) == 2)
  assert(v:get(3) == 3)
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

-- vector addition, vector + vector
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({2, 3, 4})
  local v = v1 + v2
  assert(v:len(), 3)
  assert(v:get(1) == 3)
  assert(v:get(2) == 5)
  assert(v:get(3) == 7)
end

-- vector substration, vector - vector
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({2, 3, 4})
  local v = v1 - v2
  assert(v:len(), 3)
  assert(v:get(1) == -1)
  assert(v:get(2) == -1)
  assert(v:get(3) == -1)
end

-- vector scalar substration, scalar - vector
do
  local v1 = Vector:from_table({1, 2, 3})
  local v = 3 - v1
  assert(v:len(), 3)
  assert(v:get(1), 2)
  assert(v:get(2), 1)
  assert(v:get(3), 0)
end

-- vector scalar substration, vector - scalar
do
  local v1 = Vector:from_table({1, 2, 3})
  local v = v1 - 3
  assert(v:len(), 3)
  assert(v:get(1), -2)
  assert(v:get(2), -1)
  assert(v:get(3), 0)
end

-- vector multiplication
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({2, 3, 4})
  local v = v1 * v2
  assert(v:len() == 3)
  assert(v:get(1) == 2)
  assert(v:get(2) == 6)
  assert(v:get(3) == 12)
end

-- vector division, vector / vector
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({2, 3, 4})
  local v = v1 / v2
  assert(v:len() == 3)
  assert(math.abs(v:get(1) - 0.5) < 1 / 1000000)
  assert(math.abs(v:get(2) - 0.6666667) < 1 / 1000000)
  assert(math.abs(v:get(3) - 0.75) < 1 / 1000000)
end

-- vector division, vector / scalar
do
  local v1 = Vector:from_table({1, 2, 3})
  local v = v1 / 3
  assert(v:len() == 3)
  assert(math.abs(v:get(1) - 0.3333333) < 1e-6)
  assert(math.abs(v:get(2) - 0.6666667) < 1e-6)
  assert(math.abs(v:get(3) - 1) < 1e-6)
end

-- vector division, scalar / vector
do
  local v1 = Vector:from_table({1, 2, 3})
  local v = 3 / v1
  assert(v:len() == 3)
  assert(math.abs(v:get(1) - 3) < 1e-6)
  assert(math.abs(v:get(2) - 1.5) < 1e-6)
  assert(math.abs(v:get(3) - 1) < 1e-6)
end
