:: patch MSVS 2008 64bit
regedit /s x64\VC_OBJECTS_PLATFORM_INFO.reg

regedit /s x64\600dd186-2429-11d7-8bf6-00b0d03daa06.reg
regedit /s x64\600dd187-2429-11d7-8bf6-00b0d03daa06.reg
regedit /s x64\600dd188-2429-11d7-8bf6-00b0d03daa06.reg
regedit /s x64\600dd189-2429-11d7-8bf6-00b0d03daa06.reg
regedit /s x64\656d875f-2429-11d7-8bf6-00b0d03daa06.reg
regedit /s x64\656d8760-2429-11d7-8bf6-00b0d03daa06.reg
regedit /s x64\656d8763-2429-11d7-8bf6-00b0d03daa06.reg
regedit /s x64\656d8766-2429-11d7-8bf6-00b0d03daa06.reg

copy "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcpackages\AMD64.VCPlatform.config" "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcpackages\AMD64.VCPlatform.Express.config"
copy "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcpackages\Itanium.VCPlatform.config" "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcpackages\Itanium.VCPlatform.Express.config"


set PATH=C:\\MinGW\\bin;%PATH%
:: remove git from PATH
set PATH=%PATH:C:\Program Files\Git\usr\bin;=%

cmake ^
      -G "%CMAKE_GENERATOR%" ^
      -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
      -DPYTHON_BINDINGS=ON ^
      -DRUN_SWIG=ON ^
      -DCMAKE_BUILD_TYPE=Release ^
      ..

MSBuild openbabel.sln /m /verbosity:minimal
::cmake --build . --target ALL_BUILD --config Release
::cmake --build . --target install --config Release

:: mingw32-make -j4
:: mingw32-make install

::The python library and shared object do not install into site-packages so
::we put them there manually after the build.  This may be possible from CMake
::using option -DPYTHON_PREFIX from ob wiki, but doesn't seem to work


:: Copy the key binary files to the site packages.  this is an unfortunate workaround for windows
copy bin\_openbabel.pyd %PREFIX%\Lib\site-packages
xcopy %PREFIX%\bin %PREFIX%\Library\bin /E
:: rmdir /S %PREFIX%\bin

:: Install the python site package
cd scripts\python
%PYTHON% setup.py install
