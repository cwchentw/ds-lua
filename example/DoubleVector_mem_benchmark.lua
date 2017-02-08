local unistd = require("posix.unistd")
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

  local NTIME = 100000
  local time_before = os.clock()
  local count_before = collectgarbage("count")
  for i = 1, NTIME do
    local v = v1 + v2
  end
  local time_after = os.clock()
  local count_after = collectgarbage("count")

  print("Total execution time: " .. (time_after - time_before) .. "s")
  print("Average execution time: " .. (time_after - time_before) / NTIME .. "s")

  print("Total garbage count: " .. (count_after - count_before))
  print("Average garbage count: " .. (count_after - count_before) / NTIME)

  local pid = unistd.getpid()
  local f = io.popen("ps -o rss= -p " .. pid)
  local rss = f:read("*a")
  f:close()
  print("RSS: " .. rss)
end

-- Prevent program crash when using OpenMP
os.exit(0)
