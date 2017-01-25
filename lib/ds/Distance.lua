--- `ds.Distance` class.
-- Common distance (metric) algorithm for high-dimensional data. Use `algo.Vector`
-- as default vector-like object.  You may implement your own vector object which
-- providing `get` and `len` method.
-- @classmod Distance
local Vector = require "algo.Vector"

local abs = math.abs
local sqrt = math.sqrt

local Distance = {}
package.loaded['Distance'] = Distance

Distance.__index = Distance

-- Check whether two vectors are of equal size.
local function _check_vectors(v1, v2)
  assert(type(v1) == "table" and v1["get"] and v1["len"])
  assert(type(v2) == "table" and v2["get"] and v2["len"])

  assert(v1:len() == v2:len())
end

--- Euclidean distance.
-- @param v1 vector-like object
-- @param v2 vector-like object
-- @return Euclidean distance.
function Distance:euclidean(v1, v2)
  return Distance:minkowski(v1, v2, 2)
end

--- Chebyshev distance.
-- @param v1 vector-like object
-- @param v2 vector-like object
-- @return Chebyshev distance.
function Distance:chebyshev(v1, v2)
  _check_vectors(v1, v2)

  local len = v1:len()
  if len == 0 then
    return nil
  end

  local max = abs(v1:get(1) - v2:get(1))
  for i = 2, len do
    local d = abs(v1:get(i) - v2:get(i))
    if d > max then
      max = d
    end
  end

  return max
end

--- Maximum distance.
-- An alias to Chebyshev distance.
function Distance:maximum(v1, v2)
  return Distance:chebyshev(v1, v2)
end

--- Manhatten distance.
-- @param v1 vector-like object
-- @param v2 vector-like object
-- @return Manhatten distance.
function Distance:manhattan(v1, v2)
  _check_vectors(v1, v2)

  local len = v1:len()
  if len == 0 then
    return nil
  end

  local d = 0
  for i = 1, len do
    d = d + abs(v1:get(i) - v2:get(i))
  end

  return d
end

--- Canberra distance.
-- @param v1 vector-like object
-- @param v2 vector-like object
-- @return Canberra distance.
function Distance:canberra(v1, v2)
  _check_vectors(v1, v2)

  local len = v1:len()
  if len == 0 then
    return nil
  end

  local d = 0
  for i = 1, len do
    local p = v1:get(i)
    local q = v2:get(i)
    d = d + abs(p - q) / (abs(p) + abs(q))
  end

  return d
end

--- Jaccard distance.
-- @param v1 vector-like object
-- @param v2 vector-like object
-- @return Jaccard distance.
function Distance:jaccard(v1, v2)
  local function _only(a, b)
    if (((a == 0) and (b ~= 0)) or ((a ~= 0) and (b == 0))) then
      return 1
    else
      return 0
    end
  end

  local function _either(a, b)
    if ((a ~= 0) or (b ~= 0)) then
      return 1
    else
      return 0
    end
  end

  _check_vectors(v1, v2)

  local len = v1:len()
  if len == 0 then
    return nil
  end

  local p = 0
  local q = 0
  for i = 1, len do
    local m = v1:get(i)
    local n = v2:get(i)
    p = p + _only(m, n)
    q = q + _either(m, n)
  end

  return p / q
end

--- Binary distance.
-- An alias to Jaccard distance.
function Distance:binary(v1, v2)
  return Distance:jaccard(v1, v2)
end

--- Minkowski distance.
-- @param v1 vector-like object.
-- @param v2 vector-like object.
-- @param p The power of Minkowski distance.  Optional, default to 2.  When in
-- default condition, Minkowski distance is equal to Euclidean distance.
-- @return Minkowski distance.
function Distance:minkowski(v1, v2, p)
  _check_vectors(v1, v2)

  local len = v1:len()
  if len == 0 then
    return nil
  end

  if p == nil then
    p = 2
  end

  local d = 0
  for i = 1, len do
    d = d + abs(v1:get(i) - v2:get(i)) ^ p
  end

  return d ^ (1 / p)
end

return Distance
