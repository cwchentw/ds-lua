ifeq ($(OS), Windows_NT)
	SUFFIX=.dll
else
	UNAME := $(shell uname)
	ifeq ($(UNAME), Darwin)
		SUFFIX=.dylib
	else
		SUFFIX=.so
	endif
endif

LIBDIR=lib
LIB_SUBDIR=$(LIBDIR)/ds

SRCDIR=src
SRC_SUBDIR=$(SRCDIR)/ds

ALGO_DOUBLE_VECTOR=dsDoubleVector.c
ALGO_DOUBLE_MATRIX=dsDoubleMatrix.c
SOURCE=$(ALGO_DOUBLE_VECTOR) $(ALGO_DOUBLE_MATRIX)
LIB=libds

USER=$(shell whoami)
ifeq ($(USER), "root")
	PREFIX=/usr/local
else
	PREFIX=$(shell echo $$HOME)
endif



ifeq ($(USER), "root")
	DESTDIR=$(PREFIX)
endif

LUAENV=$(shell luaenv)

ifdef LUAENV
	DESTDIR=$(shell dirname $(shell $$HOME/.luaenv/libexec/luaenv which lua))/..
else
	DESTDIR=$(PREFIX)/.luarocks
endif

LUA_VERSION=5.1
CLUADIR = $(DESTDIR)/lib/lua/$(LUA_VERSION)
LUADIR = $(DESTDIR)/share/lua/$(LUA_VERSION)/ds


CC=gcc
CFLAGS_OBJ=-fPIC -std=c11 -fopenmp
CFLAGS_LIB=-shared -fopenmp -lgomp
RM=rm
RMFLAG=-rf

all: install

install: lib
	mkdir -p $(LUADIR)
	mkdir -p $(CLUADIR)
	install $(LIBDIR)/init.lua $(LUADIR)
	install $(LIB_SUBDIR)/*.lua $(LUADIR)
	install $(SRCDIR)/$(LIB)$(SUFFIX) $(CLUADIR)

lib: object
	$(CC) $(CFLAGS_LIB) -o $(SRCDIR)/$(LIB)$(SUFFIX) $(SRCDIR)/*.o

object:
	$(CC) -c -o $(SRCDIR)/$(ALGO_DOUBLE_VECTOR:.c=.o) $(CFLAGS_OBJ) -lm $(SRCDIR)/$(ALGO_DOUBLE_VECTOR)
	$(CC) -c -o $(SRCDIR)/$(ALGO_DOUBLE_MATRIX:.c=.o) $(CFLAGS_OBJ) -lm $(SRCDIR)/$(ALGO_DOUBLE_MATRIX)

clean:
	$(RM) $(RMFLAG) $(SRCDIR)/*.o $(SRCDIR)/*$(SUFFIX) *.dSYM doc
