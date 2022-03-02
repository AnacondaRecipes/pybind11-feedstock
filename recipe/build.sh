#!/bin/bash

# Isolate the build.
mkdir -p Build
cd Build || exit 1

# Generate the build files.
cmake ${SRC_DIR} -G"Ninja" ${CMAKE_ARGS} \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DPYTHON_EXECUTABLE=$PREFIX/bin/python \
      -DPYBIND11_TEST=OFF \
      -DCMAKE_BUILD_TYPE=Release

# Build and install.
ninja install || exit 1

# Perform tests.
#  ninja test || exit 1
#  path_to/test || exit 1

# Install Python package
export PYBIND11_USE_CMAKE=1
cd $SRC_DIR
python $SRC_DIR/setup.py install --single-version-externally-managed --record record.txt
