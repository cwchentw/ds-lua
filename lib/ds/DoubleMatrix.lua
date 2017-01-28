--- `ds.DoubleMatrix` class.
-- A matrix with double-precision floating points as its elements, which is
-- implemented in C.  Implicitly called when the elements are numbers.
-- [ffi from LuaJIT](http://luajit.org/ext_ffi.html) is used for binding.
-- @classmod DoubleMatrix
local ffi = require "ffi"
local Util = require "algo.Util"

ffi.cdef([[
typedef struct DoubleMatrix {
  size_t nrow;
  size_t ncol;
  double* mtx;
} DoubleMatrix;

DoubleMatrix* ds_double_matrix_new(size_t, size_t);
double ds_double_matrix_get_nrow(DoubleMatrix*);
double ds_double_matrix_get_ncol(DoubleMatrix*);
double ds_double_matrix_get(DoubleMatrix*, size_t, size_t);
void ds_double_matrix_set(DoubleMatrix*, size_t, size_t, double);
DoubleVector* ds_double_matrix_get_row(DoubleMatrix*, size_t);
DoubleVector* ds_double_matrix_get_col(DoubleMatrix*, size_t);
void ds_double_matrix_free(DoubleMatrix*);
]])

local algo_c = Util:ffi_load(ffi, "libds")

local DoubleVector = require "ds.DoubleVector"
local DoubleMatrix = {}
package.loaded['DoubleMatrix'] = DoubleMatrix

DoubleMatrix.__index = DoubleMatrix

DoubleMatrix.__gc = function (m)
  algo_c.ds_double_matrix_free(m.mtx)
end

--- Create a matrix with specific dimension.
-- @param nrow row size
-- @param ncol col size
-- @return A matrix (object).
function DoubleMatrix:new(nrow, ncol)
  assert(nrow > 0 and ncol > 0)

  self = {}
  setmetatable(self, DoubleMatrix)
  self.mtx = algo_c.ds_double_matrix_new(nrow, ncol);

  return self
end

--- Create a matrix from a matrix-style table
-- @param table a matrix-style table
-- @return A matrix (object).
function DoubleMatrix:from_table(table)
  local nrow = #table
  assert(nrow > 0)

  local ncol = #(table[1])
  assert(ncol > 0)

  local mtx = DoubleMatrix:new(nrow, ncol)

  for i = 1, nrow do
    for j = 1, ncol do
      mtx:set(i, j, table[i][j])
    end
  end

  return mtx
end

--- Get the row size of the matrix.
-- @return Row size (number).
function DoubleMatrix:row()
  return algo_c.ds_double_matrix_get_nrow(self.mtx)
end

--- Get the column size of the matrix.
-- @return Column size (number).
function DoubleMatrix:col()
  return algo_c.ds_double_matrix_get_ncol(self.mtx)
end

--- Index matrix by (row, col) pair
-- @param row Row, 1-based number
-- @param col Column, 1-based number
-- @return Data (number).
function DoubleMatrix:get(row, col)
  local nrow = self:row()
  assert(1 <= row and row <= nrow)

  local ncol = self:col()
  assert(1 <= col and col <= ncol)

  return algo_c.ds_double_matrix_get(self.mtx, row - 1, col - 1)
end

--- Assign data to the matrix by (row, col) pair.
-- @param row, Row, 1-based number
-- @param col, Column, 1-based number
-- @param data, Data (number).
function DoubleMatrix:set(row, col, data)
  local nrow = self:row()
  assert(1 <= row and row <= nrow)

  local ncol = self:col()
  assert(1 <= col and col <= ncol)

  assert(type(data) == "number")

  algo_c.ds_double_matrix_set(self.mtx, row - 1, col - 1, data)
end

-- Create a double vector from raw vector.
local function _vector_from_raw(v)
  local vector = DoubleVector:new(0)
  algo_c.ds_double_vector_free(vector.vec)
  vector.vec = v
  return vector
end

--- Get specific row from the matrix.
-- @param row Row, 1-based number
-- @return A DoubleVector (object).
function DoubleMatrix:get_row(row)
  local nrow = self:row()
  assert(1 <= row and row <= nrow)

  local raw_vec = algo_c.ds_double_matrix_get_row(self.mtx, row - 1)

  return _vector_from_raw(raw_vec)
end

--- Get specific column from the matrix.
-- @param col Column, 1-based number
-- @return A DoubleVector (object).
function DoubleMatrix:get_col(col)
  local ncol = self:col()
  assert(1 <= col and col <= ncol)

  local raw_vec = algo_c.ds_double_matrix_get_col(self.mtx, col - 1)

  return _vector_from_raw(raw_vec)
end

return DoubleMatrix
