pushd "%~dp0"
cd..
echo %cd%\d7.exe>rkill_Excludes.txt
move /y rkill_Excludes.txt "3rd Party Tools"