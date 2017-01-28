local Matrix = require "ds.DoubleMatrix"
local DoubleVector = require "ds.DoubleVector"

-- Create a matrix
do
  local m = Matrix:new(3, 4)
  assert(m)
  assert(m:row() == 3)
  assert(m:col() == 4)
end

-- Create a matrix from a matrix-style table
do
  local table = {{1, 2, 3},
                 {4, 5, 6}}
  local m = Matrix:from_table(table)
  assert(m:row() == 2)
  assert(m:col() == 3)
end

-- Setter and getter
do
  local m = Matrix:new(3, 4)
  assert(math.abs(m:get(1, 1) - 0) < 1e-6)
  assert(math.abs(m:get(3, 4) - 0) < 1e-6)

  m:set(1, 1, 99)
  assert(math.abs(m:get(1, 1) - 99) < 1e-6)

  m:set(3, 4, -99)
  assert(math.abs(m:get(3, 4) - -99) < 1e-6)
end

-- Get row vector
do
  local table = {{1, 2, 3, 4},
                 {5, 6, 7, 8},
                 {9, 10, 11, 12}}
  local m = Matrix:from_table(table)
  local v = m:get_row(2)
  assert(v == DoubleVector:from_table({5, 6, 7, 8}))
end

-- Get column vector
do
  local table = {{1, 2, 3, 4},
                 {5, 6, 7, 8},
                 {9, 10, 11, 12}}
  local m = Matrix:from_table(table)
  local v = m:get_col(3)
  assert(v == DoubleVector:from_table({3, 7, 11}))
end
