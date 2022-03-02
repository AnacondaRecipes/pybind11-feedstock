:: cmd

:: Isolate the build.
mkdir Build
cd Build
if errorlevel 1 exit 1

:: Generate the build files.
cmake %SRC_DIR% -G"Ninja" %CMAKE_ARGS% ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DPYBIND11_TEST=ON ^
      -DCMAKE_BUILD_TYPE=Release


:: Build.
ninja
if errorlevel 1 exit 1


:: Perforem tests.
ninja check
::  if errorlevel 1 exit 1


:: Install.
ninja install
if errorlevel 1 exit 1


:: Install Python package
set PYBIND11_USE_CMAKE=1
set CMAKE_GENERATOR=Ninja
cd %SRC_DIR%
%PYTHON% %SRC_DIR%\setup.py install --single-version-externally-managed --record record.txt
if errorlevel 1 exit 1


:: Error free exit.
exit 0
