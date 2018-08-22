@echo off 
REM ...

REM ###########################################################################
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

REM ...
move YahooAPIWrapper.dll ../../build_dotnet_cpp_wrapper
move YahooAPIWrapper.lib ../../build_dotnet_cpp_wrapper

REM ...
del YahooAPIWrapper.exp
del YahooAPIWrapper.obj

REM Go to root directory.
cd ..

REM ###########################################################################
REM Build application.

REM
cd Test 

REM
cl /EHsc /I../YahooAPIWrapper test.cpp YahooAPIWrapper.lib /link /LIBPATH:../../build_dotnet_cpp_wrapper

REM
move test.exe ../../build_dotnet_cpp_wrapper

REM
del test.obj 

REM
cd ..