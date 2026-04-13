# Backup original pyproject.toml
cp ./pyproject.toml ./pyprojectpybind11.toml

# Create pyproject.toml for pybind11-global install
$PYTHON ./tools/make_global.py > ./pyprojectglobal.toml

# Build with generated pyprojectglobal.py
mv ./pyprojectglobal.toml ./pyproject.toml

$PYTHON -m pip install . -vv --no-build-isolation --no-deps

# Restore original pyproject.toml
cp ./pyprojectpybind11.toml ./pyproject.toml

# Remove duplicated headers, see https://github.com/conda-forge/pybind11-feedstock/issues/107
rm -rf $PREFIX/include/python*/pybind11-global