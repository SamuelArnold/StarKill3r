@echo off
::for /f %%i in ("%~0") do set curpath=%%~dpi
set "curpath=%~dp0"
cd "%curpath%"

call mbar.exe %1 %2 %3 %4 %5 %6

if NOT '%errorlevel%' == '10' goto :checkPrivileges
exit /B

:checkPrivileges
call NET FILE
cls
if '%errorlevel%' == '0' ( goto noUAC ) else ( goto getPrivileges )

:getPrivileges

setlocal DisableDelayedExpansion
set "batchPath=%~f0"
setlocal EnableDelayedExpansion

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\mbar.vbs"
ECHO str="/c ""!batchPath!""" >> "%temp%\mbar.vbs"
ECHO for i=0 to Len(str) >> "%temp%\mbar.vbs"
ECHO ch=Mid(str,i+1,1) >> "%temp%\mbar.vbs"
ECHO if ch="&" or ch="^" or ch="|" then args=args+"^" >> "%temp%\mbar.vbs"
ECHO args=args+ch >> "%temp%\mbar.vbs"
ECHO Next >> "%temp%\mbar.vbs"
ECHO UAC.ShellExecute "cmd.exe", args+" %1 %2 %3 %4 %5 %6", "", "runas", 0 >> "%temp%\mbar.vbs"
"%temp%\mbar.vbs"
del "%temp%\mbar.vbs"
exit /B

:noUAC
cls
setlocal & pushd .
if exist mbar-pro.dll (call rundll32.exe mbar-pro.dll Start /z %1 %2 %3 %4 %5 %6) else (
call rundll32.exe mbar.dll Start /z %1 %2 %3 %4 %5 %6)
exit /B

