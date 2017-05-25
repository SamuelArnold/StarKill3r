@echo off&pushd "%~dp0"
cd "..\..\3rd Party Tools"
start /wait JRT.exe -y -nr
pushd %systemdrive%\JRT
if not exist "get.bat" pushd "%temp%\jrt"
if not exist "get.bat" goto :eof
find /v /i "pause" get.bat>tmp.bat
find /v /i "notepad" tmp.bat>get.bat
start /wait get.bat