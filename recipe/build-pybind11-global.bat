:: Backup original pyproject.toml
copy /Y pyproject.toml pyprojectpybind11.toml
if errorlevel 1 exit 1

:: Create pyproject.toml for pybind11-global install
%PYTHON% tools\make_global.py > pyprojectglobal.toml
if errorlevel 1 exit 1

:: Build with generated pyprojectglobal.toml
move /Y pyprojectglobal.toml pyproject.toml

%PYTHON% -m pip install . -vv --no-build-isolation --no-deps --config-settings=wheel.install-dir=/data/Library
if errorlevel 1 exit 1

:: Restore original pyproject.toml
copy /Y pyprojectpybind11.toml pyproject.toml
if errorlevel 1 exit 1

:: Remove duplicated headers, see https://github.com/conda-forge/pybind11-feedstock/issues/107
rmdir /s /q "%PREFIX%\include\pybind11-global"
if errorlevel 1 exit 1