--- `ds.Math` class.
-- Some functions used in data science.
-- @classmod Math
local Math = {}
package.loaded['Math'] = Math

Math.__index = {}

--- Gamma function
function Math:gamma(z)
  local epsilon = 0.0000001

  local p = {676.5203681218851, -1259.1392167224028, 771.32342877765313,
       -176.61502916214059, 12.507343278686905, -0.13857109526572012,
       9.9843695780195716e-6, 1.5056327351493116e-7}

  if z < 0.5 then
    return math.pi / (sin(math.pi * z) * Math:gamma(1 - z))
  end

  z = z - 1
  local x =  0.99999999999980993

  for i, v in ipairs(p) do
    x = x + p[i] / (z + i)
  end

  t = z + #p - 0.5

  return math.sqrt(2 * math.pi) * t ^ (z + 0.5) * math.exp(-t) * x
end

--- Natural logarithm of gamma function
function Math:gamma_ln(z)
  return math.log(Math:gamma(z))
end

--- Beta function
function Math:beta(a, b)
  return math.exp(Math:gamma_ln(a) + Math:gamma_ln(b) - Math:gamma_ln(a + b))
end

-- The density fuction of beta distribution
local function _beta_df(x, a, b)
  return (1 / Math:beta(a, b)) * (x ^ (a - 1)) * ((1 - x) ^ (b - 1))
end

-- Beta continued fraction
local function _beta_cf(a, b, x)
  local maxit = 100
  local eps = 3e-16
  local fpmin = 1e-30

  local qab = a + b
  local qap = a + 1
  local qam = a - 1

  local c = 1
  local d = 1 - qab * x / qap

  if math.abs(d) < fpmin then
    d = fpmin
  end

  d = 1 / d

  local h = d

  local m2 = nil
  for m = 1, maxit do
    m2 = 2 * m
    local aa = m * (b - m) * x / ((qam + m2) * (a + m2))

    d = 1 + aa * d
    if math.abs(d) < fpmin then
      d = fpmin
    end

    c = 1 + aa / c
    if math.abs(c) < fpmin then
      c = fpmin
    end

    d =  1 / d
    h = h * d * c
    aa = -(a + m) * (qab + m) * x / ((a + m2) * (qap + m2))
    d = 1 + aa * d

    if math.abs(d) < fpmin then
      d = fpmin
    end

    c = 1 + aa / c
    if math.abs(c) < fpmin then
      c = fpmin
    end

    d = 1 / d

    local del = d * c
    h = h * del
    if math.abs(del - 1) < eps then
      break
    end
  end

  return h
end

--- Regularized incompleted beta function
function Math:ribeta(x, a, b)
  assert(0 <= x and x <= 1)
  if x == 1 and b == 1 then
    return x
  elseif x == 0 then
    return 0
  elseif x == 1 then
    return 1
  elseif a == 0 then
    return 1
  elseif b == 0 then
    return 0
  end

  local g_ab = Math:gamma_ln(a + b)
  local g_a = Math:gamma_ln(a)
  local g_b = Math:gamma_ln(b)

  local bt = nil

  if x == 0 then
    bt = 0
  else
    bt = math.exp(g_ab - g_a - g_b + a * math.log(x) + b * math.log(1 - x))
  end

  if x < (a + 1) / (a + b / 2) then
    return bt * _beta_cf(a, b, x) / a
  else
    return 1 - bt * _beta_cf(1 - x, b, a) / b
  end
end

return Math
