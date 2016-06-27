set CC=gcc
set CXX=g++
set F77=gfortran
set F90=gfortran

copy "%PREFIX%\..\..\libs\libpython27.a" "%PREFIX%\libs\libpython27.a"
copy "%PREFIX%\..\..\Lib\distutils\distutils.cfg" "%PREFIX%\Lib\distutils\distutils.cfg"
:: pip install -i https://pypi.anaconda.org/rmg/simple pycairo

set PATH=C:\\MinGW\\bin;%PATH%

gcc --version

:: remove git from PATH
set PATH=%PATH:C:\Program Files\Git\usr\bin;=%

cmake -G "MinGW Makefiles" ^
      -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
      -DPYTHON_LIBRARY=%PREFIX%\libs\libpython27.a ^
      -DPYTHON_EXECUTABLE=%PYTHON% ^
      -DPYTHON_INCLUDE_DIR=%PREFIX%\include ^
      -DOPTIMIZE_NATIVE=OFF ^
      -DPYTHON_BINDINGS=ON ^
      -DRUN_SWIG=ON

mingw32-make -j4
mingw32-make install

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