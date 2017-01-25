local Vector = require "algo.Vector"
local Distance = require "ds.Distance"

-- Euclidean distance
do
  local v1 = Vector:from_table({0, 1, 2})
  local v2 = Vector:from_table({3, 4, 5})

  assert(math.abs(Distance:euclidean(v1, v2) - 5.196152) < 1e-6)
end

-- Chebyshev distance
do
  local v1 = Vector:from_table({0, 1, 2})
  local v2 = Vector:from_table({3, 4, 5})

  assert(math.abs(Distance:maximum(v1, v2) - 3) < 1e-6)
end

-- Manhatten distance
do
  local v1 = Vector:from_table({0, 1, 2})
  local v2 = Vector:from_table({3, 4, 5})

  assert(math.abs(Distance:manhattan(v1, v2) - 9) < 1e-6)
end

-- Canberra distance
do
  local v1 = Vector:from_table({0, 1, 2})
  local v2 = Vector:from_table({3, 4, 5})

  assert(math.abs(Distance:canberra(v1, v2) - 2.028571) < 1e-6)
end

-- Jaccard distance.
do
  local v1 = Vector:from_table({0, 1, 2})
  local v2 = Vector:from_table({3, 4, 5})

  assert(math.abs(Distance:binary(v1, v2) - 0.3333333) < 1e-6)
end

-- Minkowski distance, when p = 3
do
  local v1 = Vector:from_table({0, 1, 2})
  local v2 = Vector:from_table({3, 4, 5})

  assert(math.abs(Distance:minkowski(v1, v2, 3) - 4.326749) < 1e-6)
end
