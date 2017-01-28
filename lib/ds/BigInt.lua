--- `algo.BigInt` class.
-- Arbitrary precision integer.
local Array = require "algo.Array"
local String = require "algo.String"

local PLUS = "+"
local MINUS = "-"

local UPPER = 99999999999999
local LOWER = -99999999999999

-- Convert Lua string to single digit
local function s2n(s)
  if s == "0" then
    return 0
  elseif s == "1" then
    return 1
  elseif s == "2" then
    return 2
  elseif s == "3" then
    return 3
  elseif s == "4" then
    return 4
  elseif s == "5" then
    return 5
  elseif s == "6" then
    return 6
  elseif s == "7" then
    return 7
  elseif s == "8" then
    return 8
  elseif s == "9" then
    return 9
  else
    error("Unsuppored string: " .. s)
  end
end

-- Check whether `x` is digit
local function _isdigit(x)
  if type(x) == "number" then
    return n2s(x) ~= nil
  elseif type(x) == "string" then
    return s2n(x) ~= nil
  else
    return false
  end
end

-- Convert Lua number to (sign, num_array) pair
local function _num2array(n)
  if n % 1 ~= 0 then
    error("Floating number is not supported: " .. n)
  end

  if n < LOWER or n > UPPER then
    error("Number exceeds the limit: " .. n)
  end

  local sign = nil
  if n < 0 then
    sign = MINUS
  else
    sign = PLUS
  end

  local _n = math.abs(n)
  local t = {}
  while true do
    local digit = _n % 10
    table.insert(t, digit)

    if _n == 0 then
      break
    end

    _n = math.floor(_n / 10)
  end

  local t2 = {}
  for i = #t, 1, -1 do
    table.insert(t2, t[i])
  end

  return sign, Array:from_table(t2)
end

-- Convert external string to BigInt compatible string
local function _str2str(s)
  assert(type(s) == "table" and s["len"])

  local sign = nil
  local _s = nil
  if s:get(1) == "-" then
    sign = MINUS
    _s = s:remove(1, 1)
  else
    sign = PLUS
    if s:get(1) == "+" then
      _s = s:remove(1, 1)
    else
      _s = s
    end
  end

  local len = _s:len()
  for i = 1, len do
    if not _isdigit(_s:get(i)) then
      error("Invalid number presentation: " .. s)
    end
  end

  return sign, _s
end

-- Convert string object to number array
local function _str2array(s)
  assert(type(s) == "table" and s["len"])
  local sign, _s = _str2str(s)

  local len = _s:len()
  local t = {}
  for i = 1, len do
    table.insert(t, s2n(_s:get(i)))
  end

  return sign, Array:from_table(t)
end

-- Convert numbar array to Lua number
local function _array2num(s)
  assert(type(s) == "table" and s["len"])

  local len = s:len()
  local n = 0
  for i = len, 1, -1 do
    n = n + s:get(i) * 10 ^ (len - i)
  end

  return n
end

local BigInt = {}
package.loaded['BigInt'] = BigInt

BigInt.__index = BigInt

--- Create a big integer.
-- @param s a Lua string, Lua number or `algo.String` object
-- @return A big integer.
function BigInt:new(x)
  local _s = nil
  local _n = nil

  if type(x) == "string" then
    _s = String:new(x)
  elseif type(x) == "number" then
    _n = x
  elseif type(x) == "table" and x["len"] then
    _s = x
  else
    error("Unsuppored type " .. type(x) .. " " .. s)
  end

  self = {}
  setmetatable(self, BigInt)

  if _n then
    self.sign, self.array = _num2array(_n)
  else
    self.sign, self.array = _str2array(_s)
  end

  if not _n then
    self.raw_number = _array2num(self.array)

    if self.sign == MINUS then
      self.raw_number = -self.raw_number
    end
  else
    self.raw_number = _n
  end

  return self
end

--- Get Lua number from the big integer object.
-- **Warning** Number precision may lose when the number is large.
-- @return A Lua number
function BigInt:raw()
  --[[
  if LOWER < self.raw_number and self.raw_number < UPPER then
    return self.raw_number
  end
  ]]--

  local n = _array2num(self.array)

  if self.sign == PLUS then
    return n
  elseif self.sign == MINUS then
    return -n
  end
end

return BigInt
