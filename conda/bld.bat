set PATH=C:\\MinGW\\bin;%PATH%
:: remove git from PATH
set PATH=%PATH:C:\Program Files\Git\usr\bin;=%

cmake ^
      -G "Visual Studio 9 2008" ^
      -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
      -DPYTHON_BINDINGS=ON ^
      -DRUN_SWIG=ON

cmake --build . --target install --config Release

::The python library and shared object do not install into site-packages so
::we put them there manually after the build.  This may be possible from CMake
::using option -DPYTHON_PREFIX from ob wiki, but doesn't seem to work


:: Copy the key binary files to the site packages.  this is an unfortunate workaround for windows
copy bin\_openbabel.pyd %PREFIX%\Lib\site-packages
xcopy %PREFIX%\bin %PREFIX%\Library\bin /E
rmdir /S %PREFIX%\bin

:: Install the python site package
cd scripts\python
%PYTHON% setup.py install

if errorlevel 1 exit 1
