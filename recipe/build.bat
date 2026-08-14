:: An undefined %VAR% expands to itself in cmd, not to nothing, so make
:: sure CMAKE_ARGS is defined before it reaches the command line.
if not defined CMAKE_ARGS set "CMAKE_ARGS="

cmake -G "Ninja" ^
    -S . ^
    -B build ^
    %CMAKE_ARGS% ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=True ^
    -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON ^
    -DBUILD_SHARED_LIBS=ON ^
    -Duse_installed_dependencies=ON ^
    -Duse_etw=OFF
if errorlevel 1 exit 1

cmake --build build --config Release --target install
if errorlevel 1 exit 1
