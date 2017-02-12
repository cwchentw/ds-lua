local Math = require "ds.Math"

-- sqrt function
do
  assert(Math:abs(Math:sqrt(2) - 1.414214) < 1e-6)
  assert(Math:abs(Math:sqrt(4) - 2) < 1e-6)
end

-- Gamma function
do
  assert(Math:abs(Math:gamma(0.5) - 1.772454) < 1e-6)
end

-- Natural logarithm of gamma function
do
  assert(Math:abs(Math:gamma_ln(0.5) - 0.5723649) < 1e-6)
end

-- Beta function
do
  assert(Math:abs(Math:beta(0.5, 0.5) - 3.141593) < 1e-6)
end

-- Regularized incompleted beta function
do
  assert(Math:abs(Math:ribeta(0.5, 2, 2) - 0.5) < 1e-6)
end
