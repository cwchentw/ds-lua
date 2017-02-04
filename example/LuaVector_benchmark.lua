local Vector = require("ds.LuaVector")

math.randomseed(1234)

-- Benchmark on LuaVector.
do
  local LENGTH = 10000
  local v1 = Vector:new(LENGTH)
  local v2 = Vector:new(LENGTH)

  for i = 1, LENGTH do
    v1:set(i, math.random())
    v2:set(i, math.random())
  end

  local NTIME = 20000
  local time_before = os.time()
  local count_before = collectgarbage("count")
  for i = 1, NTIME do
    local v = v1 + v2
  end
  local time_after = os.time()
  local count_after = collectgarbage("count")

  print("Total execution time (LuaVector): " .. (time_after - time_before) .. "s")
  print("Average execution time (LuaVector): " .. (time_after - time_before) / NTIME .. "s")

  print("Total garbage count: " .. (count_after - count_before))
  print("Average garbage count: " .. (count_after - count_before) / NTIME)
end
