########################################
# Win Honey Ver .01 
# Created By Samuel Arnold
# Goals To mimic file structure of Windows
#
########################################


########################################
# Prompt User
########################################

Write-Host "########################################"
Write-Host "Welcome to WinHoneyDrive created by Sam Arnold"
Write-Host "########################################"


$Size = Read-Host -Prompt 'Enter Size of Win Honey Drive - (GB) : '
$Location = Read-Host -Prompt 'Drive Letter : '
Write-Host "You input '$Size' and '$Location'"



########################################
# Create Mount M Drive to current folder: 
#$var = Get-Location
#echo $var 
#subst M: $var 
########################################

##cd .\Desktop\Linux
mkdir C
cd C
########################################
# Now Fill C: W/ Folders
########################################
mkdir '$Recycle.Bin'
mkdir '$SysReset'
mkdir AdwCleaner
mkdir Eclipse
mkdir "My Website"
mkdir mysql
mkdir Octave 
mkdir "Program Files"
mkdir "Program Files(x86)"
mkdir "System Volume Information"
mkdir "Document and Settings"
mkdir "PerfLogs"
mkdir Recovery
mkdir SymCache
mkdir TEMP
mkdir Wamp64
mkdir Windows
mkdir Users
echo "WinHoney ver .2 Created SA" > "BOOTNXT"
echo "WinHoney ver .2 Created SA" > "install.res.1028.Dll"
echo "WinHoney ver .2 Created SA" > "install.res.1031.Dll"
echo "WinHoney ver .2 Created SA" > "install.res.1033.Dll"
echo "WinHoney ver .2 Created SA" > "VC_RED.exe"
echo "WinHoney ver .2 Created SA" > "vcredist"

########################################
# Fill C:/TEMP FOLDER 
########################################
cd TEMP 
echo "WinHoney ver .2 Created SA" > "Minecraft.exe"
echo "WinHoney ver .2 Created SA" > "LOL.exe"
echo "WinHoney ver .2 Created SA" > "dropbox_error_v4dsv"
echo "WinHoney ver .2 Created SA" > "dropbox_error8pljdt"
echo "WinHoney ver .2 Created SA" > "dropbox_errorm90d4n"
cd ..

########################################
# Fill C:/USERS
########################################
cd USERS
mkdir Admin
mkdir Default
mkdir Public
mkdir BACKUP
mkdir System
mkdir SYSADMIN
echo "WinHoney ver .2 Created SA" > "Desktop.ini"

cd ..

########################################
# Fill C:/Windows
########################################


#.. keep Filling
