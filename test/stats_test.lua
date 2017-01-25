local Vector = require "algo.Vector"
local Stats = require "ds.Stats"

-- Mean
do
  local v = Vector:from_table({1, 2, 3, 4, 5, 6})

  assert(math.abs(Stats:mean(v) - 3.5) < 1e-6)
end

-- Geometric mean
do
  local v = Vector:from_table({1, 2, 3, 4, 5, 6})

  assert(math.abs(Stats:gm(v) - 3.67195) < 1e-6)
end

-- Median, even items
do
  local v = Vector:from_table({1, 2, 3, 4, 5, 6})

  assert(math.abs(Stats:median(v) - 3.5) < 1e-6)
end

-- Median, odd items
do
  local v = Vector:from_table({1, 2, 3, 4, 5})

  assert(Stats:median(v) == 3)
end

-- Mode
do
  local v = Vector:from_table({1, 1, 2, 2, 2, 3, 4, 4, 4})
  local out = Stats:mode(v)

  assert(out:contain(2))
  assert(out:contain(4))
  assert(not out:contain(1))
  assert(not out:contain(3))
end

-- Range
do
  local v = Vector:from_table({1, 2, 3, 4, 5, 6})
  local range = Stats:range(v)

  assert(range:get(1) == 1)
  assert(range:get(2) == 6)
end

-- Quantile
do
  local v = Vector:from_table({1, 2, 3, 4, 5, 6, 7, 8, 9, 10})
  local p = Vector:from_table({0.0, 0.25, 0.50, 0.75, 1.0})
  local quantile = Stats:quantile(v, p)

  assert(quantile == Vector:from_table({1, 3, 5, 8, 10}))
end

-- Variance
do
  local v = Vector:from_table({1, 2, 3, 4, 5, 6})

  assert(math.abs(Stats:var(v) - 3.5) < 1e-6)
end

-- Standard deviation
do
  local v = Vector:from_table({1, 2, 3, 4, 5, 6})

  assert(math.abs(Stats:sd(v) - 1.870829) < 1e-6)
end

-- Skewness
do
  local v = Vector:from_table({19.09, 19.55, 17.89, 17.73, 25.15, 27.27, 25.24,
    21.05, 21.65, 20.92, 22.61, 15.71, 22.04, 22.60, 24.25})

  assert(math.abs(Stats:skewness(v) - -0.01565162) < 1e-6)
end

-- Kurtosis
do
  local v = Vector:from_table({19.09, 19.55, 17.89, 17.73, 25.15, 27.27, 25.24,
    21.05, 21.65, 20.92, 22.61, 15.71, 22.04, 22.60, 24.25})

  assert(math.abs(Stats:kurtosis(v) - 2.301051) < 1e-6)
end

-- Covariance
do
  local v1 = Vector:from_table({2.1, 2.5, 4.0, 3.6})
  local v2 = Vector:from_table({8, 12, 14, 10})

  assert(math.abs(Stats:cov(v1, v2) - 1.533333) < 1e-6)
end

-- Correlation
do
  local v1 = Vector:from_table({2.1, 2.5, 4.0, 3.6})
  local v2 = Vector:from_table({8, 12, 14, 10})

  assert(math.abs(Stats:cor(v1, v2) - 0.6625739) < 1e-6)
end

-- T test, paired, two_tailed
do
  local v1 = Vector:from_table({123, 146, 135, 141, 139, 162, 128, 137, 145,
    151, 131, 143})
  local v2 = Vector:from_table({136, 145, 140, 147, 142, 160, 137, 136, 149,
    158, 120, 150})

  local t, p = Stats:t_test(v1, v2, { paired = true, mu = 0 })

  assert(math.abs(t - -1.7918) < 1e-4)
  assert(math.abs(p - 0.1007) < 1e-4)
end

-- T test, unpaired, two-tailed, equal variance
do
  local v1 = Vector:from_table({123, 146, 135, 141, 139, 162, 128, 137, 145,
    151, 131, 143})
  local v2 = Vector:from_table({136, 145, 140, 147, 142, 160, 137, 136, 149,
    158, 120, 150})

    local t, p = Stats:t_test(v1, v2, { equal_var = true })

    assert(math.abs(t - -0.74448) < 1e-4)
    assert(math.abs(p - 0.4645) < 1e-4)
end

-- T test, unpaired, two-tailed, unequal variance
do
  local v1 = Vector:from_table({123, 146, 135, 141, 139, 162, 128, 137, 145,
    151, 131, 143})
  local v2 = Vector:from_table({136, 145, 140, 147, 142, 160, 137, 136, 149,
    158, 120, 150})

    local t, p = Stats:t_test(v1, v2, { equal_var = false })

    assert(math.abs(t - -0.74448) < 1e-4)
    assert(math.abs(p - 0.4645) < 1e-4)
end

-- ANOVA
do
  local v1 = Vector:from_table({8, 9, 6, 7, 3})
  local v2 = Vector:from_table({2, 4, 3, 5, 1})
  local v3 = Vector:from_table({3, 5, 4, 2, 3})
  local v4 = Vector:from_table({2, 2, -1, 0, 3})

  local f, p = Stats:anova_oneway({v1, v2, v3, v4})

  assert(math.abs(f - 8.5593220339) < 1e-6)
  assert(math.abs(p - 0) < 1e-6)
end
