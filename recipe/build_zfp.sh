#!/usr/bin/env bash
set -e

mkdir build
cd build
cmake                              \
  -DBUILD_CFP=ON                   \
  -DBUILD_UTILITIES=ON             \
  -DZFP_WITH_OPENMP=ON             \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_PREFIX_PATH=${PREFIX}    \
  -DCMAKE_INSTALL_LIBDIR=lib       \
  -DCMAKE_INSTALL_BINDIR=bin       \
  ..

make -j${CPU_COUNT}
make test
make install

./bin/testzfp

