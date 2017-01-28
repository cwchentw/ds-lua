local BigInt = require "ds.BigInt"

local NUM_UPPER = 99999999999999
local NUM_LOWER = -99999999999999
local STR_UPPER = "99999999999999"
local STR_LOWER = "-99999999999999"

-- Get BigInt from number
do
  local n = BigInt:new(-9999)
  assert(n:raw() == -9999)

  local n = BigInt:new(100)
  assert(n:raw() == 100)

  local n = BigInt:new(0)
  assert(n:raw() == 0)
end

-- Get BigInt from string
do
  local n = BigInt:new("-9999")
  assert(n:raw() == -9999)

  local n = BigInt:new("-100")
  assert(n:raw() == -100)

  local n = BigInt:new("0")
  assert(n:raw() == 0)
end
