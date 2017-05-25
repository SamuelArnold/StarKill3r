@echo off&pushd "%allusersprofile%"&cd ..
dir /a:d-h /b >userlist.tmp
for /f "tokens=*" %%a in ('type userlist.tmp') do (
 echo,|net user "%%a" *
)


reg.exe
if "%errorlevel%"=="9009" (
	set regtool="%~dp0..\bin\reg.exe"
) else (
	set regtool=reg.exe
)

  :: install the registry entries for the LockSmith service, also ensuring it starts in safe mode

	for /l %%_ in (1,1,9) do (
		%regtool% query HKLM\SYSTEM\ControlSet00%%_
		if not errorlevel 1 (
			%regtool% delete "HKLM\SYSTEM\ControlSet00%%_\Enum\Root\LEGACY_.D7_LOCKSMITH" /f
			%regtool% delete "HKLM\SYSTEM\ControlSet00%%_\Services\.D7_LockSmith" /f
			%regtool% delete "HKLM\SYSTEM\ControlSet00%%_\Control\SafeBoot\Minimal\.D7_LockSmith" /f
		)
	)

pushd "%~dp0"
del /q srvany.exe


%regtool% add "HKLM\System\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /t REG_MULTI_SZ /d \??\c:\D7_Locksmith /f

exit