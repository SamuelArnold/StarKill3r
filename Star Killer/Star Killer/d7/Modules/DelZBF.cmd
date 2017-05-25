:: DelZBF.cmd by Nick Shaw
:: direct all complaints to your mother 
:: Created:    ?
:: Last edit:  5/12/07
:: 
:: Deletes zero byte files in the directory given as a parameter, or
:: current directory (after confirmation) if no parameters are given.
::
:: Can be run within or seperately of AutoTBC and on any machine at any time
::
:: Subdirectories are scanned only in DRIVE mode
::
:: DRIVE mode only produces the report file
:: 
:: Report file is in the target path, or if exist, %~dp0..\reports 
::
:: Usage examples:
:: 
:: delzbf.cmd drive
::   runs in entire drive mode, scans current drive and all subdirectories
::
:: delzbf.cmd drive d:
::   runs in entire drive mode, scans D: and all subdirectories
::
:: delzbf.cmd
::   runs in current directory, does not scan subdirectories
::
:: delzbf.cmd c:\documents and settings
::   runs in c:\documents and settings, does not scan subdirectories
:: 


  :: Getting conditions explained above here

	if not exist "%AutoTBC%\Script Debug Reports\AutoTBC_debugging.ON" @echo off
	setlocal ENABLEEXTENSIONS

	set zbfcommand=dir/b/a-d/os
	set delcmd=del /q "%%a"
	set zbfreportfile=zerobyte_files_deleted.txt
	if [%1]==[] goto noinput
	if [%1]==[drive] (
		set zbfcommand=dir/s/b/a-d/os
		set delcmd=echo "%%a"
		set zbfreportfile=zerobyte_files_found.txt
		goto drive
	)

	pushd "%1 %2 %3 %4 %5 %6 %7 %8 %9"
	if errorlevel 1 cls&echo PATH NOT VALID or EXCEEDS SPACE LIMITATIONS.&echo,&ECHO change directory to the path and run from there!&pause&goto :eof


:Start
	if exist "%AutoTBC%\..\Client Report History" (
		set reportzbf=%AutoTBC%\..\Client Report History\%zbfreportfile%
		) else (
		set reportzbf=%zbfreportfile%
	)

	echo Path:  %cd% >> "%reportzbf%"
	if exist "%AutoTBC%\Temp" (
		set zbf=%AutoTBC%\Temp\zerobyte.ref
		) else (
		set zbf=%temp%\zerobyte.ref
	)
	
	cd.>"%zbf%"

	for /f "delims=" %%a in ('%zbfcommand%') do (
		fc "%zbf%" "%%a" >nul
		if errorlevel 1 (goto done) else (attrib -a -r -s -h "%%a"&%delcmd%&echo  - %%a >> "%reportzbf%")
	)
  :: above statement - fc has errorlevel 1 if differences found, errorlevel 0 if no differences


:Done
	del /q "%zbf%"
	popd
	goto :eof

:NoInput
	cls&echo,&echo No input given!  Using current directory:&echo,&echo "%cd%"&echo,&echo Press any key if this is ok or CTRL-C to abort.&pause>nul
	cls&goto start

:Drive
	set zbfdrive=%2
	if [%2]==[] (
		set zbfdrive=%~d0
		cls&echo,&echo No DRIVE LETTER given!  For example:&echo,&echo Use " delzbf.cmd drive c: " to scan the entire C: drive.&echo,&echo press any key to use the current drive:  %~d0  or CTRL-C to abort.&pause>nul
	)

	pushd %zbfdrive%\
	cls&echo,&echo When running on an entire drive, REPORT ONLY mode is enabled.
	goto start