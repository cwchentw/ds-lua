--- Data Science in Lua.
-- This module demostrates common algoritms in data science, including
-- statistics and data mining, in Lua.  Since Lua is a slow language compared
-- with C/C++, you should not rely on this module for critical tasks.  In
-- addition, this module is still in alpha stage; the API may change without warning.
--
-- Lua community is split by two major Lua implementations, official [Lua](https://www.lua.org/)
-- and [LuaJIT](http://luajit.org/). Although LuaJIT is behind official Lua in
-- language features, the former outperforms the latter by about 10x-50x.  Therefore,
-- this library targets LuaJIT.
-- @module ds
local ds = {}
package.loaded["ds"] = ds

ds.BigInt = require "ds.BigInt"
ds.Math = require "ds.Math"
ds.DoubleVector = require "ds.DoubleVector"
ds.LuaVector = require "ds.LuaVector"
ds.Vector = require "ds.Vector"
ds.DoubleMatrix = require "ds.DoubleMatrix"
ds.Stats = require "ds.Stats"
ds.Distance = require "ds.Distance"
ds.Evaluation = require "ds.Evaluation"

return ds
