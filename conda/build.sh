#!/bin/bash
if [ `uname` == Darwin ]; then
    SO_EXT='dylib'
else
    SO_EXT='so'
fi

cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DOPTIMIZE_NATIVE=OFF \
      -DPYTHON_BINDINGS=ON \
      -DRUN_SWIG=ON

make -j${CPU_COUNT}
make install
