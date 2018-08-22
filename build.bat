@echo off 
REM Deactivate printing commands to the screen to reduce clutter.
REM This comment block comes after the command so that this comment block does
REM not get printed to the screen.

REM ###########################################################################

REM \todo Figure out how to specify a build directory for cl.

REM ###########################################################################
REM Create build directory.

REM Create build directory.
mkdir ..\build_dotnet_cpp_wrapper

REM ###########################################################################
REM Build .NET library.

REM Go .NET library directory.
cd YahooApi

REM Build .NET library.
csc /target:library /out:../../build_dotnet_cpp_wrapper/YahooApi.dll YahooAPI.cs

REM Go to root directory.
cd ..

REM ###########################################################################
REM Build wrapper.

REM Go to wrapper directory.
cd YahooApiWrapper

REM Build wrapper.
cl /clr /AI../../build_dotnet_cpp_wrapper /LD YahooAPIWrapper.cpp

REM Move binaries to build directory.
move YahooAPIWrapper.dll ../../build_dotnet_cpp_wrapper
move YahooAPIWrapper.lib ../../build_dotnet_cpp_wrapper

REM Delete intermediate binaries.
del YahooAPIWrapper.exp
del YahooAPIWrapper.obj

REM Go to root directory.
cd ..

REM ###########################################################################
REM Build application.

REM Go to application directory.
cd Test 

REM Build application.
cl /EHsc /I../YahooAPIWrapper test.cpp YahooAPIWrapper.lib /link /LIBPATH:../../build_dotnet_cpp_wrapper

REM Move binaries to build directory.
move test.exe ../../build_dotnet_cpp_wrapper

REM Delete intermediate binaries.
del test.obj 

REM Go to root directory.
cd ..