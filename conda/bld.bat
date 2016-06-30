cmake ^
      -G "%CMAKE_GENERATOR%" ^
      -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
      -DPYTHON_EXECUTABLE=%PYTHON% ^
      -DPYTHON_BINDINGS=ON ^
      -DRUN_SWIG=ON ^
      -DCMAKE_BUILD_TYPE=Release ^
      .

cmake --build . --target install --config Release

:: Where should BABEL_DATADIR go?
::xcopy %PREFIX%\bin\data %PREFIX%\share\openbabel\2.3.90 /e /c
::rmdir /s /q %PREFIX%\bin\data

xcopy %PREFIX%\bin %PREFIX%\Library\bin /e /c
rmdir /s /q %PREFIX%\bin
