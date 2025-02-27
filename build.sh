#!/bin/bash

set -e

#============================================================
# Prerequisities 0

echo ""
echo "============================================================"
echo "Prerequisities 0"
echo ""

#sudo apt-get update -y
#sudo apt-get upgrade -y
echo "sudo apt-get install -y build-essential gdb texinfo mono-complete"
sudo apt-get install -y build-essential gdb texinfo mono-complete

#============================================================
# Prerequisities 1

echo ""
echo "============================================================"
echo "Prerequisities 1"
echo ""

mkdir -p artifacts
cd artifacts
if [ ! -f dotnet-install.sh ]; then
  wget https://dot.net/v1/dotnet-install.sh
  chmod 755 dotnet-install.sh
  ./dotnet-install.sh -c 2.2
  ./dotnet-install.sh -c 3.1
  ./dotnet-install.sh -c 5.0
  ./dotnet-install.sh -c 6.0
  ./dotnet-install.sh -c 7.0
  ./dotnet-install.sh -c 8.0
fi
cd ..

#============================================================
# Prerequisities 2

echo ""
echo "============================================================"
echo "Prerequisities 2"
echo ""

export PATH=~/.dotnet:~/.dotnet/tools:$PATH
export DOTNET_ROOT=~/.dotnet

#============================================================
# Build toolchain

echo ""
echo "============================================================"
echo "Build toolchain"
echo ""

(cd chibicc-cil-toolchain && dotnet clean && dotnet build)

#============================================================
# Build libc (bootstrap)

echo ""
echo "============================================================"
echo "Build libc (bootstrap)"
echo ""

(cd libc-cil && ./build-crt0.sh && dotnet clean libc.sln && dotnet build libc.sln)

#============================================================
# Build chibicc-cil (bootstrap)

echo ""
echo "============================================================"
echo "Build chibicc-cil (bootstrap)"
echo ""

(cd chibicc-cil && make clean && make -j test && make -j test-stage2 && make -j test-stage3)

#============================================================
# Build newlib

echo ""
echo "============================================================"
echo "Build newlib"
echo ""

(cd libc-cil && ./build-newlib.sh)

#============================================================
# Build libgloss

echo ""
echo "============================================================"
echo "Build libgloss"
echo ""

(cd libc-cil && dotnet clean libgloss.sln && dotnet build libgloss.sln)

export CHIBICC_CIL_INCLUDE_PATH=`pwd`/libc-cil/newlib/newlib/libc/include
export CHIBICC_CIL_LIB_PATH=`pwd`/libc-cil/libgloss/bin/Debug/netstandard2.0

#============================================================
# Build chibicc-cil (main)

echo ""
echo "============================================================"
echo "Build chibicc-cil (main)"
echo ""

# Broken
#(cd chibicc-cil && make clean && make -j test && make -j test-stage2 && make -j test-stage3)
