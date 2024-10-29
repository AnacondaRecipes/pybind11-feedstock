mkdir build
cmake -G "Visual Studio 16 2019" -S . -B ./build -DBUILD_TESTING=OFF -DPYBIND11_NOPYTHON=ON -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%
cmake --install build
if errorlevel 1 exit 1
