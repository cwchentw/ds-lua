local Vector = require("ds.DoubleVector")

-- Benchmark on Vector addition.
do
  local LENGTH = 10000
  local v1 = Vector:new(LENGTH)
  local v2 = Vector:new(LENGTH)
  -- Fixed random seed.
  math.randomseed(1234)

  for i = 1, LENGTH do
    v1:set(i, math.random())
    v2:set(i, math.random())
  end

  local NTIME = 20000
  local time_before = os.time()
  for i = 1, NTIME do
    local v = v1 + v2
  end
  local time_after = os.time()

  print("Total execution time: " .. (time_after - time_before) .. "s")
  print("Average execution time: " .. (time_after - time_before) / NTIME .. "s")
end
