--- `ds.Vector` class.
-- A factory class that generates specific vector object under user's request.
-- Currently, `ds.DoubleVector` and `ds.LuaVector` are implemented.
-- @classmod Vector
local DoubleVector = require "ds.DoubleVector"
local LuaVector = require "ds.LuaVector"

local Vector = {}
package.loaded['Vector'] = Vector

Vector.__index = Vector

local function _check_type(e)
  assert(e == "native" or e == "number" or e == nil)
end

local function _get_type(options)
  local _type = nil

  if type(options) == "table" then
    _type = options["type"]
  end
  _check_type(_type)

  if _type == nil then
    _type = "native"
  end

  return _type
end

local function _infer_type(t)
  local n = #t
  if n > 10 then
    n = 10
  end

  local is_number = true
  for i = 1, n do
    if type(t[i]) ~= "number" then
      is_number = false
      break
    end
  end

  local _type = nil
  if is_number then
    _type = "number"
  else
    _type = "native"
  end

  return _type
end

--- Create an empty vector.
-- @param size size
-- @param options Optional. A hash-style table presents options, including:
--
-- * type: native or number.  Default to native, i.e. LuaVector.
--
-- @return A vector.
function Vector:new(size, options)
  local _type = _get_type(options)

  if _type == "number" then
    return DoubleVector:new(size)
  elseif _type == "native" then
    return LuaVector:new(size)
  else
    return nil
  end
end

--- Create an vector with the elements from an array-style table.
-- @param table an array-style table
-- @param options Optional. A hash-style table presents options, including:
--
-- * type: native or number.  Default to native, i.e. LuaVector.
--
-- If no option supplied, the method will infer proper vector type by the
-- elements in the table.
-- @return A vector.
function Vector:from_table(table, options)
  local _type = nil

  if type(options) == "table" then
    _type = _get_type(options)
  else
    _type = _infer_type(table)
  end

  if _type == "number" then
    return DoubleVector:from_table(table)
  elseif _type == "native" then
    return LuaVector:from_table(table)
  else
    return nil
  end
end

return Vector
