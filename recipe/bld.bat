:: cmd

:: Isolate the build.
mkdir Build
cd Build
if errorlevel 1 exit 1

:: Generate the build files.
cmake %SRC_DIR% -G"Ninja" %CMAKE_ARGS% ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DPYBIND11_TEST=OFF ^
      -DCMAKE_BUILD_TYPE=Release


:: Build and install.
ninja install
if errorlevel 1 exit 1


:: Perforem tests.
::  ninja test
::  path_to\test
::  if errorlevel 1 exit 1


:: Install Python package
set PYBIND11_USE_CMAKE=1
cd %SRC_DIR%
python %SRC_DIR%\setup.py install --single-version-externally-managed --record record.txt
if errorlevel 1 exit 1


:: Error free exit.
exit 0
