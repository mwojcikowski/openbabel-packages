cmake ^
      -G "%CMAKE_GENERATOR%" ^
      -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
      -DPYTHON_EXECUTABLE=%PYTHON% ^
      -DPYTHON_BINDINGS=ON ^
      -DRUN_SWIG=ON ^
      -DCMAKE_BUILD_TYPE=Release ^
      .

::MSBuild openbabel.sln /m /t:Build /p:Configuration=Release /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll"
cmake --build . --target install --config Release
::-- /msbuild:m /msbuild:logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll"

::The python library and shared object do not install into site-packages so
::we put them there manually after the build.  This may be possible from CMake
::using option -DPYTHON_PREFIX from ob wiki, but doesn't seem to work

:: Copy the key binary files to the site packages.  this is an unfortunate workaround for windows
copy bin\Release\_openbabel.pyd %PREFIX%\Lib\site-packages
copy scripts\Release\_openbabel.dll %PREFIX%\Lib\site-packages
copy scripts/Release/_openbabel.lib %PREFIX%\Lib\site-packages
copy scripts\python\openbabel.py %PREFIX%\Lib\site-packages
copy scripts\python\pybel.py %PREFIX%\Lib\site-packages
xcopy %PREFIX%\bin\data %PREFIX%\share\openbabel\2.3.90 /e /c
rmdir /s /q %PREFIX%\bin\data
xcopy %PREFIX%\bin %PREFIX%\Library\bin /e /c
rmdir /s /q %PREFIX%\bin

:: Install the python site package
::cd scripts\python
::%PYTHON% setup.py install
