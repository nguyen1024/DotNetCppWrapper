@echo off 
REM Deactivate printing commands to the screen to reduce clutter.
REM This comment block comes after the command so that this comment block does
REM not get printed to the screen.

REM ############################################################################
REM ...
REM ############################################################################

REM \todo Figure out how to specify a build directory for cl.
REM \todo Figure out how to not create a build directory if it already exists.

REM ############################################################################
REM Create build directory.
REM ############################################################################

REM Create build directory.
mkdir ..\build_dotnet_cpp_wrapper

REM ############################################################################
REM Build .NET library.
REM ############################################################################

REM Go .NET library directory.
cd YahooApi

REM Build .NET library.
csc /target:library /out:../../build_dotnet_cpp_wrapper/YahooApi.dll YahooAPI.cs

REM Go to root directory.
cd ..

REM ############################################################################
REM Build wrapper.
REM ############################################################################

REM Go to wrapper directory.
cd YahooApiWrapper

REM Build wrapper.
REM HOW TO SPECIFY THE "USING" DIRECTORY
REM https://msdn.microsoft.com/en-us/library/x1x72k9t.aspx
cl /clr /AI../../build_dotnet_cpp_wrapper /LD YahooAPIWrapper.cpp

REM Move binaries to build directory.
move YahooAPIWrapper.dll ../../build_dotnet_cpp_wrapper
move YahooAPIWrapper.lib ../../build_dotnet_cpp_wrapper

REM Delete intermediate binaries.
del YahooAPIWrapper.exp
del YahooAPIWrapper.obj

REM Go to root directory.
cd ..

REM ############################################################################
REM Build application.
REM ############################################################################

REM Go to application directory.
cd Test 

REM Build application.
REM HOW TO SPECIFY THE LIBRARY PATH.
REM https://stackoverflow.com/questions/12124739/visual-c-library-directories-command-line-equivalent
cl /EHsc /I../YahooAPIWrapper test.cpp YahooAPIWrapper.lib /link /LIBPATH:../../build_dotnet_cpp_wrapper

REM Move binaries to build directory.
move test.exe ../../build_dotnet_cpp_wrapper

REM Delete intermediate binaries.
del test.obj 

REM Go to root directory.
cd ..