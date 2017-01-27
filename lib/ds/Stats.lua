--- `ds.Stats` class.
-- A class for common statistics algorithms.  Use `algo.Vector` as default
-- vector-like object.  You may implement your own vector object which providing
-- `get` and `len` method.
-- @classmod Stats
local Set = require "algo.Set"
local Vector = require "algo.Vector"
local Math = require "ds.Math"

local Stats = {}
package.loaded['ds.Stats'] = Stats

Stats.__index = Stats

--- Mean.
-- @param v vector-like object
-- @return Mean.
function Stats:mean(v)
  assert(type(v) == "table" and v["len"] and v["get"])

  local sum = 0
  local len = v:len()
  for i = 1, len do
    sum = sum + v:get(i)
  end

  return sum / len
end

--- Geometric mean.
-- @param v vector-like object
-- @return Geometric mean.
function Stats:gm(v)
  assert(type(v) == "table" and v["len"] and v["get"])

  local product = 1
  local len = v:len()
  for i = 1, len do
    product = product * v:get(i)
  end

  return math.log(product) / math.log(len)
end

--- Median.
-- @param v vector-like object
-- @return Median.
function Stats:median(v)
  assert(type(v) == "table" and v["len"] and v["get"])
  local len = v:len()
  if len % 2 ~= 0 then
    return v:get(math.ceil(len/2))
  else
    return (v:get(math.floor(len/2)) + v:get(math.floor(len/2) + 1)) / 2
  end
end

--- Mode.
-- @param v vector-like object
-- @return A `algo.Set` object which contains the mode.
function Stats:mode(v)
  assert(type(v) == "table" and v["len"] and v["get"])

  local t = {}
  local len = v:len()

  for i = 1, len do
    k = v:get(i)
    if t[k] == nil then
      t[k] = 0
    else
      t[k] = t[k] + 1
    end
  end

  local max = nil
  for k, _ in pairs(t) do
    if max == nil then
      max = t[k]
    elseif max < t[k] then
      max = t[k]
    end
  end

  local out = Set:new()
  for k, _ in pairs(t) do
    if t[k] >= max then
      out:insert(k)
    end
  end

  return out
end

--- Range
-- @param v vector-like object
-- @return (min, max) pair.
function Stats:range(v)
  assert(type(v) == "table" and v["len"] and v["get"])

  local vec = Vector:new(2)
  vec:set(1, nil)
  vec:set(2, nil)

  local len = v:len()
  if len == 0 then
    return vec
  end

  local min = v:get(1)
  local max = v:get(1)

  for i = 2, len do
    n = v:get(i)
    if n < min then
      min = n
    end

    if n > max then
      max = n
    end
  end

  return min, max
end

--- Quantile
-- @param v vector-like object
-- @param p vector-like object presents percentage
-- @return A `algo.Vector` object which contains (e1, e2, ...) of v
function Stats:quantile(v, p)
  assert(type(v) == "table" and v["len"] and v["get"])
  assert(type(p) == "table" and p["len"] and p["get"])

  local len_v = v:len()
  local len_p = p:len()

  for i = 1, len_p do
    if p:get(i) < 0 or p:get(i) > 1 then
      error("Invalid range: " .. p:get(i))
    end
  end

  local j = 1

  local t = {}

  for i = 1, len_v do
    if i / len_v >= p:get(j) then
      table.insert(t, v:get(i))
      j = j + 1
    end
  end

  return Vector:from_table(t)
end

--- Variance
-- @param v vector-like object
-- @return Variance
function Stats:var(v)
  assert(type(v) == "table" and v["len"] and v["get"])

  local len = v:len()
  local n = 0
  local mean = Stats:mean(v)

  for i = 1, len do
    n = n + (v:get(i) - mean) ^ 2
  end

  return (1 / (len - 1)) * n
end

--- Standard deviation
-- @param v vector-like object
-- @return Standard deviation
function Stats:sd(v)
  return math.sqrt(Stats:var(v))
end

--- Skewness
-- @param v vector-like object
-- @return Skewness
function Stats:skewness(v)
  local mean = Stats:mean(v)
  local sd = Stats:sd(v)

  local len = v:len()
  local temp1 = 0
  for i = 1, len do
    temp1 = temp1 + (v:get(i) - mean) ^ 3
  end
  temp1 = temp1 / len

  local temp2 = 0
  for i = 1, len do
    temp2 = temp2 + (v:get(i) - mean) ^ 2
  end
  temp2 = temp2 / len

  return (temp1 / (temp2 ^ 1.5))
end

--- Kurtosis
-- @param v vector-like object
-- @return Kurtosis
function Stats:kurtosis(v)
  local mean = Stats:mean(v)
  local len = v:len()

  local temp1 = 0
  for i = 1, len do
    temp1 = temp1 + (v:get(i) - mean) ^ 4
  end

  local temp2 = 0
  for i = 1, len do
    temp2 = temp2 + (v:get(i) - mean) ^ 2
  end
  temp2 = temp2 ^ 2

  return len * temp1 / temp2
end

--- Covariance
-- @param v1 vector-like object
-- @param v2 vector-like object
-- @return Covariance.
function Stats:cov(v1, v2)
  assert(type(v1) == "table" and v1["len"] and v1["get"])
  assert(type(v2) == "table" and v2["len"] and v2["get"])

  local len = v1:len()
  local mean_v1 = Stats:mean(v1)
  local mean_v2 = Stats:mean(v2)

  local temp = 0
  for i = 1, len do
    temp = temp + (v1:get(i) - mean_v1) * (v2:get(i) - mean_v2)
  end

  local cov = (1 / (len - 1)) * temp

  return cov
end

--- Correlation
-- @param v1 vector-like object
-- @param v2 vector-like object
-- @return Covariance
function Stats:cor(v1, v2)
  return Stats:cov(v1, v2) / (Stats:sd(v1) * Stats:sd(v2))
end

-- T distribution PDF
local function _t_pdf(t, df)
  local temp = (1 + (t ^ 2) / df) ^ (-(df + 1)/2)

  local temp1 = Math:gamma_ln((df+1)/2)
  local temp2 = math.sqrt(math.pi * df) * Math:gamma_ln(df/2) * temp

  return temp1 / temp2
end

-- T distribution CDF
local function _t_cdf(t, df)
  if df == 1 then
    return 0.5 + ((1 / math.pi) * math.atan(t))
  elseif df == 2 then
    return 0.5 + (t / (2 * math.sqrt(2 + t * t)))
  end

  local x = df / ((t * t) + df)
  local p = 1 - 0.5 * Math:ribeta(x, df / 2, 0.5)

  if t > 0 then
    return p
  else
    return 1 - p
  end
end

local function _t_test_equal_var(v1, v2)
  local len_v1 = v1:len()
  local len_v2 = v2:len()

  local mean_v1 = Stats:mean(v1)
  local mean_v2 = Stats:mean(v2)
  local var_v1 = Stats:var(v1)
  local var_v2 = Stats:var(v2)

  local s_2 = ((len_v1 - 1) * var_v1 + (len_v2 - 1) * var_v2) / (len_v1 + len_v2 - 2)
  local s = math.sqrt(s_2)

  local t = (mean_v1 - mean_v2) / (s * math.sqrt((1 / len_v1) + (1 / len_v2)))

  return t
end

local function _t_test_unequal_var(v1, v2)
  local len_v1 = v1:len()
  local len_v2 = v2:len()

  local mean_v1 = Stats:mean(v1)
  local mean_v2 = Stats:mean(v2)
  local var_v1 = Stats:var(v1)
  local var_v2 = Stats:var(v2)

  local s_2 = (var_v1 / len_v1) + (var_v2 / len_v2)
  local s = math.sqrt(s_2)

  local t = (mean_v1 - mean_v2) / s

  return t
end

local function _t_test_df(v1, v2)
  local len_v1 = v1:len()
  local len_v2 = v2:len()
  local var_v1 = Stats:var(v1)
  local var_v2 = Stats:var(v2)

  local temp1 = ((var_v1 / len_v1) + (var_v2 / len_v2)) ^ 2

  local temp2 = ((var_v1 / len_v1) ^ 2) / (len_v1 - 1) +
    ((var_v2 / len_v2) ^ 2) / (len_v2 - 1)

  return temp1 / temp2
end

-- Unpaired T test
local function _t_test(v1, v2, options)
  local len_v1 = v1:len()
  local len_v2 = v2:len()
  local var_v1 = Stats:var(v1)
  local var_v2 = Stats:var(v2)

  local t = nil
  local p = nil
  if options["equal_var"] then
    t = _t_test_equal_var(v1, v2)
    p = _t_cdf(t, (len_v1 - 1) + (len_v2 - 1))
  else
    t = _t_test_unequal_var(v1, v2)
    local df = _t_test_df(v1, v2)
    p = _t_cdf(t, df)
  end

  return t, p
end

-- Paired T-test
local function _paired_t_test(v1, v2, mu)
  local len_v1 = v1:len()
  local len_v2 = v2:len()
  assert(len_v1 == len_v2)

  local v = v1 - v2

  local mean = Stats:mean(v)
  local sd = Stats:sd(v)

  local t = (mean - mu) / (sd / math.sqrt(len_v1))
  local p = _t_cdf(t, len_v1 - 1)

  return t, p
end

--- Paired/Unpaired T-test
-- @param v1 vector-like object
-- @param v2 vector-like object
-- @param options Optional. A hash-style table presents options.  Supported options:
--
-- * paired: true or false
-- * one_tailed: true or false
-- * equal_var: true or false
-- * mu: 0 or other number
--
-- @return A (t, p) pair.
function Stats:t_test(v1, v2, options)
  assert(type(v1) == "table" and v2["len"] and v2["get"])
  assert(type(v2) == "table" and v2["len"] and v2["get"])

  local mu = nil
  local paired = nil
  local one_tailed = nil
  local equal_var = nil

  if type(options) == "table" then
    mu = options["mu"]
    paired = options["paired"]
    one_tailed = options["one_tailed"]
    equal_var = options["equal_var"]
  end

  if mu == nil then
    mu = 0
  end

  if paired then
    local t, p = _paired_t_test(v1, v2, mu)

    if not one_tailed then
      p = p * 2
    end

    return t, p
  else
    local t, p = _t_test(v1, v2, options)

    if not one_tailed then
      p = p * 2
    end

    return t, p
  end
end

--- ANOVA, one-way
-- @param t a array-like table with vector-like objects, e.g. { v1, v2, ... v_n }
-- @return (F, p) pair.
function Stats:anova_oneway(t)
  local _t = {}
  for _, v in ipairs(t) do
    assert(type(v) == "table" and v["len"] and v["get"])
    table.insert(_t, v)
  end

  local len_all = 0
  local sum_all = 0

  for i = 1, #_t do
    local len = _t[i]:len()
    len_all = len_all + len
    sum_all = sum_all +  len * Stats:mean(_t[i])
  end

  local mean_all = sum_all / len_all

  local ssf = 0
  local sse = 0
  for i = 1, #_t do
    local len = _t[i]:len()
    ssf = ssf + len * ((Stats:mean(_t[i]) - mean_all) ^ 2)
    sse = sse + (len - 1) * Stats:var(_t[i])
  end

  local d1 = #_t - 1
  local d2 = len_all - #_t

  local msf = ssf / d1
  local mse = sse / d2

  local f = msf / mse

  --[[
    F distribution CDF:
                      b           a      b
    F(x, a, b) = I(-----------, -----, -----)
                    a + b * x     2      2
  ]]--
  local temp = d2 * f / (d1 + d2 * f)
  local p = 1 - Math:ribeta(temp, d1 / 2, d2 / 2)

  return f, p
end

return Stats
