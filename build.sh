#!/bin/bash

#----------------------------------------
# Prerequisities 1

#sudo apt-get update -y
#sudo apt-get upgrade -y
#sudo apt-get install -y build-essential gdb mono-complete

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

#----------------------------------------
# Prerequisities 2

export PATH=~/.dotnet:~/.dotnet/tools:$PATH
export DOTNET_ROOT=~/.dotnet

dotnet tool update -g chibias-cli
dotnet tool update -g chibiar-cli
dotnet tool update -g chibild-cli

#----------------------------------------
# Build toolchain and libc

(cd chibicc-cil-toolchain; dotnet clean; dotnet build)
(cd libc-cil; dotnet clean; dotnet build)

#----------------------------------------
# Build chibicc-cil

export CHIBICC_CIL_INCLUDE_PATH=`pwd`/chibicc-cil/include
export CHIBICC_CIL_LIB_PATH=`pwd`/libc-cil/libc-bootstrap/bin/Debug/netstandard2.0
export CHIBIAS_CIL_PATH=`pwd`/chibicc-cil-toolchain/chibias/chibias/bin/Debug/net6.0/cil-chibias
export CHIBIAR_CIL_PATH=`pwd`/chibicc-cil-toolchain/chibiar/chibiar/bin/Debug/net6.0/cil-chibiar
export CHIBILD_CIL_PATH=`pwd`/chibicc-cil-toolchain/chibild/chibild/bin/Debug/net6.0/cil-chibild

cd chibicc-cil

make clean;
make -j test
make -j test-stage2
make -j test-stage3
