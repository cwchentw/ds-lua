# ds-lua

Data Science in Lua.

## Notice

This package intends to demonstrate common algorithms in data science, which
is implemented in Lua.  Don't use it in production environment.

## Introduction

This module demonstrates common algorithms in data science, including
statistics and data mining, in Lua.  Since Lua is a slow language compared
with C/C++, you should not rely on this module for critical tasks.  In
addition, this module is still in alpha stage; the API may change without warning.

Lua community is split by two major Lua implementations, official [Lua](https://www.lua.org/)
and [LuaJIT](http://luajit.org/). Although LuaJIT is behind official Lua in
language features, the former outperforms the latter by about 10x-50x.  Therefore,
this library targets LuaJIT.

## Install

After clone the repository, make a LuaRocks package from it.

```
$ git clone https://github.com/cwchentw/ds-lua.git
$ cd ds-lua
$ luarocks make ds-0.1.0-1.rockspec
```

## Documentation

After installation, see the API documentation and their examples in the package
document.

```
$ luarocks doc ds
```

## Copyright

2017, Michael Chen.

## License

ds-lua is free software, using MIT License.
