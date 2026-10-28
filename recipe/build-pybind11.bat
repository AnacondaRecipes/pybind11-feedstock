:: There are several required flags, like --no-deps, but conda-build nicely sets them for us
:: https://github.com/conda/conda-build/blob/d75ef9c66dbcc832d8d96f33a2aecfe893266e8c/conda_build/build.py#L2517-L2527

:: Override the CMake generator to match the available Visual Studio version
:: This is necessary because pybind11's setup.py hardcodes VS2019 generator
if defined CMAKE_GENERATOR (
    echo Using CMAKE_GENERATOR=%CMAKE_GENERATOR%
) else (
    set CMAKE_GENERATOR=Ninja
)

%PYTHON% -m pip install . -vv --no-build-isolation --no-deps
if errorlevel 1 exit 1
