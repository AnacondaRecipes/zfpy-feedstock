setlocal EnableDelayedExpansion

del /F/Q/S build

:: Make a build folder and change to it.
mkdir build
cd build

set PYTHON_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,2%.lib

cmake -G "Ninja"                               ^
  -DBUILD_ZFPY=ON                              ^
  -DBUILD_UTILITIES=ON                         ^
  -DBUILD_CFP=ON                               ^
  -DZFP_WITH_OPENMP=ON                         ^
  -DCMAKE_BUILD_TYPE:STRING=Release            ^
  -DPYTHON_EXECUTABLE:FILEPATH="%PYTHON%"      ^
  -DPYTHON_LIBRARY:FILEPATH="%PYTHON_LIBRARY%" ^
  -DPYTHON_INCLUDE_DIR:PATH="%PREFIX%\include" ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"    ^
  -DPython_ROOT_DIR=%PREFIX%                   ^
  -DPython_FIND_VIRTUALENV=ONLY                ^
  ..

if errorlevel 1 exit 1

cmake --build . --config Release
if errorlevel 1 exit 1

:: Ninja outputs to bin/, lib/ directly (no Release/ subdirectory)
COPY "%SRC_DIR%\build\bin\*.pyd" "%PREFIX%\DLLs"
if errorlevel 1 exit 1
COPY "%SRC_DIR%\build\lib\*" "%LIBRARY_LIB%"
if errorlevel 1 exit 1
COPY "%SRC_DIR%\build\bin\*" "%LIBRARY_BIN%"
if errorlevel 1 exit 1