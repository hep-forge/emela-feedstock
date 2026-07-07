#! /usr/bin/bash
set -e

# eMELA hardcodes C++11, but conda-forge's current Boost needs C++14+ for
# the std:: type_traits aliases (is_final, remove_cv_t, etc.) its
# boost/math headers use
sed -i 's/CMAKE_CXX_STANDARD 11/CMAKE_CXX_STANDARD 14/; s/-std=c++11/-std=c++14/g' source/CMakeLists.txt

cmake ${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DWITH_LHAPDF=ON -S source -B build

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
cmake --build build --parallel="${NPROC}"
cmake --install build
