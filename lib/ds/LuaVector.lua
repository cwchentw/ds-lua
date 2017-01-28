--- `ds.LuaVector` class.
-- A high dimensional vector which presents Euclidean vectors, including
-- vector algebra and some statistics.
-- @classmod LuaVector
local Array = require "algo.Array"
local Set = require "algo.Set"
local LuaVector = {}
package.loaded['algo.LuaVector'] = LuaVector

--- Index the vector.
-- Since using builtin indexing is sometimes tricky, use OOP method call `get`
-- is preferred.
LuaVector.__index = function (t, k)
  if type(k) == "number" then
    return t.array:get(k)
  else
    return rawget(LuaVector, k)
  end
end

--- Assign data to the indexed element.
-- Since using builting index assignment is sometimes tricky, use OOP method
-- call `set` is preferred.
LuaVector.__newindex = function (t, k, v)
  if type(k) == "number" then
    t.array:set(k, v)
  else
    rawset(LuaVector, k, v)
  end
end

LuaVector.__tostring = function (o)
  local s = "("

  for i = 1, o:len() do
    s = s .. o:get(i)

    if i < o:len() then
      s = s .. ", "
    end
  end

  s = s .. ")"

  return s
end

--- Check whether two vectors are equal.
LuaVector.__eq = function (v1, v2)
  if type(v1) ~= type(v2) then
    return false
  end

  assert(type(v1) == "table" and v1["get"] and v1["len"])
  assert(type(v2) == "table" and v2["get"] and v2["len"])

  local len = v1:len()
  if len ~= v2:len() then
    return false
  end

  for i = 1, len do
    if v1:get(1) ~= v2:get(1) then
      return false
    end
  end

  return true
end

--- LuaVector addition.
-- Operator overloading on `+`. If one parameter is number,
-- the function will perform scalar addition on vector; otherwise,
-- vector addition.
-- @param a number or vector
-- @param b number or vector
-- @return a new vector
LuaVector.__add = function(a, b)
  local function _scalar_add(s, v0)
    local v = LuaVector:new(v0:len())
    for i = 1, #v0 do
      v:set(i, v0:get(i) + s)
    end
    return v
  end

  if type(a) == "number" then
    return _scalar_add(a, b)
  end

  if type(b) == "number" then
    return _scalar_add(b, a)
  end

  assert(a:len() == b:len())
  local v = LuaVector:new(a:len())
  for i = 1, a:len() do
    v:set(i, a:get(i) + b:get(i))
  end
  return v
end

--- LuaVector substration.
-- Operator overloading on `-`. If one parameter is number,
-- the function will perform scalar substration on vector; otherwise,
-- vector substration.
-- @param a number or vector
-- @param b number or vector
-- @return a new vector
LuaVector.__sub = function(a, b)
  local function _scalar_sub(s, v0)
    local v = LuaVector:new(v0:len())
    for i = 1, #v0 do
      v:set(i, v0:get(i) - s)
    end
    return v
  end

  if type(a) == "number" then
    return _scalar_sub(a, b)
  end

  if type(b) == "number" then
    return _scalar_sub(b, a)
  end

  assert(a:len() == b:len())
  local v = LuaVector:new(a:len())
  for i = 1, a:len() do
    v:set(i, a:get(i) - b:get(i))
  end
  return v
end

--- LuaVector element-wise multiplication.
-- Operator overloading on `*`. If one parameter is number,
-- the function will perform scalar multiplication on vector; otherwise,
-- vector element-wise multiplication.
-- @param a number or vector
-- @param b number or vector
-- @return a new vector
LuaVector.__mul = function (a, b)
  local function __scalar_mul(s, v0)
    local v = LuaVector:new(v0:len())
    for i = 1, v0:len() do
      v:set(i, v0:get(i) * s)
    end
    return v
  end

  if type(a) == "number" then
    return __scalar_mul(a, b)
  end

  if type(b) == "number" then
    return __scalar_mul(b, a)
  end

  assert(a:len() == b:len())
  local v = LuaVector:new(a:len())
  for i = 1, a:len() do
    v:set(i, a:get(i) * b:get(i))
  end
  return v
end

--- LuaVector element-wise division.
-- Operator overloading on `/`. If one parameter is number,
-- the function will perform scalar division on vector; otherwise,
-- vector element-wise division.
-- @param a number or vector
-- @param b number or vector
-- @return a new vector
LuaVector.__div = function (a, b)
  local function __scalar_div(s, v0)
    local v = LuaVector:new(v0:len())
    for i = 1, v0:len() do
      v:set(i, v0:get(i) / s)
    end
    return v
  end

  if type(a) == "number" then
    return __scalar_div(a, b)
  end

  if type(b) == "number" then
    return __scalar_div(b, a)
  end

  assert(a:len() == b:len())
  local v = LuaVector:new(a:len())
  for i = 1, a:len() do
    v:set(i, a:get(i) / b:get(i))
  end
  return v
end

--- Create an empty vector.
-- @param size the size of the vector
-- @return an empty vector with specific size
function LuaVector:new(size)
  self = {}
  self.array = Array:new(size)
  setmetatable(self, LuaVector)
  return self
end

--- Create a vector from an array-style table.
-- @param t an array-style table
-- @return A vector with the elements in the table.
function LuaVector:from_table(t)
  local v = LuaVector:new(#t)
  for i = 1, #t do
    v:set(i, t[i])
  end
  return v
end

--- Index the vector.
-- @param i the index
-- @return The element.
function LuaVector:get(i)
  return self.array:get(i)
end

--- Assign an element by indexing the vector.
-- @param i the index
-- @param e the element
function LuaVector:set(i, e)
  self.array:set(i, e)
end

--- The length of the vector.
-- @return The length of the vector.
function LuaVector:len()
  return self.array:len()
end

return LuaVector
