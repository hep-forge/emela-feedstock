#! /usr/bin/bash
set -e

cmake ${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DWITH_LHAPDF=ON -S source -B build

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
cmake --build build --parallel="${NPROC}"
cmake --install build
