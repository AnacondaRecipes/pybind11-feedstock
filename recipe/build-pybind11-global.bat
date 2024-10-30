:: There are several required flags, like --no-deps, but conda-build nicely sets them for us
:: https://github.com/conda/conda-build/blob/d75ef9c66dbcc832d8d96f33a2aecfe893266e8c/conda_build/build.py#L2517-L2527
set PYBIND11_GLOBAL_SDIST=1
set PYBIND11_GLOBAL_PREFIX=Library
del build 2>null

cmake -G "Visual Studio 16 2019" -S . -B ./build -DBUILD_TESTING=OFF -DPYBIND11_NOPYTHON=ON^
  -DPYTHON_EXECUTABLE:FILEPATH="%PYTHON%"      ^
  -DPYTHON_LIBRARY:FILEPATH="%PYTHON_LIBRARY%" ^
  -DPYTHON_INCLUDE_DIR:PATH="%PREFIX%\include" ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"    ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%

cmake --install build
if errorlevel 1 exit 1
