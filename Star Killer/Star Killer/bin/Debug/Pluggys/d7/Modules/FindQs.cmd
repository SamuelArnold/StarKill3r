:: FindQs by John N. Shaw
:: direct all complaints to your mother 
:: Created:    late 2006
:: Last edit:  3/11/08
:: 
:: Finds and reports ?'s in files which do not appear in Explorer
::
:: Ex:  Explorer shows "Symantec" when file/dir is actually named "?ymantec" or similar
:: (or rather, they are actually a localized or other uninterpretible character, and are 
:: detected by CMD.EXE as a "?")  Not sure how it works... but I can find it, so I can fix it!  
::
:: Confirmed to be used by newer malware; suspect it is (mis)use of localized character sets.  
::
:: Although the "?" doesn't show up in Explorer, it does recognize the character as NOT an "S" for 
:: example, so I first discovered the anomaly when changing Explorer's file/dir sort order to 
:: "by Name" and seeing "Symantec" listed AFTER "Windows Update" was the tip off.  
::
:: The current batch will not delete the ?'s automatically as "?" is interpreted as a wildcard in 
:: CMD.EXE and will delete every character in place of the "?" ... in addition, the client may actually 
:: be using a localized character set and you might be deleting his Word docs or whatever!

@echo off

title FindQs

set guest=%1

if [%1]==[] (
	echo No Guest Drive specified; expected target partition as a parameter!  &echo, &echo e.g. C: & echo, &echo Press any key to use the current drive %~d0 & echo, &echo or use CTRL-C or close this window to cancel. & pause>nul
	set guest=%~d0

)

title FindQs - Scanning %guest%

pushd "%~dp0"


:start
	set qfound=
	del /s "%Temp%\findqout.txt">nul
	cls
	pushd "%guest%\"
	dir/s/a:d/b|find "?"
	if errorlevel=1 goto ph1f
	set qfound=on
	call :fmsg
	echo    ---=== Find these DIRECTORIES and delete them: ===--- >> "%Temp%\findqout.txt"
	echo, >> "%Temp%\findqout.txt"
	dir/s/a:d/b|find "?" >> "%Temp%\findqout.txt"
	echo, >> "%Temp%\findqout.txt"

:ph1f
	dir/s/a:-d/b|find "?"
	if errorlevel=1 goto end
	if not "%qfound%"=="on" call :fmsg
	set qfound=on
	echo    ---=== Find these FILES and delete them: ===--- >> "%Temp%\findqout.txt"
	echo, >> "%Temp%\findqout.txt"
	dir/s/a:-d/b|find "?" >> "%Temp%\findqout.txt"
	echo, >> "%Temp%\findqout.txt"
	goto end

:fmsg
	echo These directories and files are likely malicious, however they may be related >> "%Temp%\findqout.txt"
	echo to localized character sets that you may find on a system with the need to  >> "%Temp%\findqout.txt"
	echo display asian or russian characters for example.   >> "%Temp%\findqout.txt"
	echo, >> "%Temp%\findqout.txt"
	echo If they are malicious, when viewed through Windows explorer they will likely >> "%Temp%\findqout.txt"
	echo appear as normal names without the question marks and could appear to be exact >> "%Temp%\findqout.txt"
	echo duplicates of existing directories, so BE CAREFUL to delete the right ones!!! >> "%Temp%\findqout.txt"
	echo, >> "%Temp%\findqout.txt"
	echo Close this notepad *ONLY* when finished and the script will confirm the >> "%Temp%\findqout.txt"
	echo problem is resolved; else this window will continue to pop up until that time. >> "%Temp%\findqout.txt"
	echo, >> "%Temp%\findqout.txt"
	echo If you have weeded out the malware and still have non-malicious entries, you >> "%Temp%\findqout.txt"
	echo must force this script to terminate by closing the "Stop FindQs console window" >> "%Temp%\findqout.txt"
	echo and close this Notepad window.  This will allow AutoTBC to continue normally. >> "%Temp%\findqout.txt"
	echo ---------------------------------------------------------------------------------- >> "%Temp%\findqout.txt"
	echo, >> "%Temp%\findqout.txt"
	goto :eof

:end
	if not "%qfound%"=="on" goto :eof
	if exist "%Temp%\findqout.txt" (
		notepad "%Temp%\findqout.txt"
		if exist "%Temp%\findqout.txt" goto start
	)