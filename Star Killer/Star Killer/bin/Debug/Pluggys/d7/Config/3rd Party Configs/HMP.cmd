pushd "%~dp0"
cd..
echo %cd%\>HMP_Excludes.txt
echo %systemdrive%\Program Files\dSupportSuite\>>HMP_Excludes.txt
echo %systemdrive%\Program Files (x86)\dSupportSuite\>>HMP_Excludes.txt
move /y HMP_Excludes.txt "3rd Party Tools"
