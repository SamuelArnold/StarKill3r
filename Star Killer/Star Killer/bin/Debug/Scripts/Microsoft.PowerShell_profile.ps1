#################
# PowerSHell banner
# Created by Sam Arnold
# 7/17/17
# 
#################

(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
import-module PsGet -erroraction 'silentlycontinue' > $null
install-module PsUrl -erroraction 'silentlycontinue' > $null
install-module PSReadline -erroraction 'silentlycontinue' > $null
$HistoryFilePath = Join-Path ([Environment]::GetFolderPath('UserProfile')) .ps_history
Register-EngineEvent PowerShell.Exiting -Action { Get-History | Export-Clixml $HistoryFilePath } | out-null
if (Test-path $HistoryFilePath) { Import-Clixml $HistoryFilePath | Add-History }
# if you don't already have this configured...
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

clear 
#Set Banner 
Write-Host "                      .~#########%%.~. "
Write-Host "                     /############%%.`\ "
Write-Host "                   /######/~\/~\%%.,.,\ "
Write-Host "                   |#######\    /.....,.|"
Write-Host "                   |#########\/%......,.|"
Write-Host "          XX       |##/~~\####%.../~~\.,|       XX"
Write-Host "        XX..X      |#|  o  \##%./  o  |.|      X..XX"
Write-Host "      XX.....X     |##\____/##%.\____/.,|     X.....XX"
Write-Host "XXXXX.....XX      \#########/\......,, /      XX.....XXXXX"
Write-Host "X |......XX%,.@      \######/%.\...., /      @#%,XX......| X"
Write-Host "X |.....X  @#%,.@     |######%%....,.|     @#%,.@  X.....| X"
Write-Host "X  \...X     @#%,.@   |# # # % . . .,|   @#%,.@     X.../  X"
Write-Host " X# \.X        @#%,.@                  @#%,.@        X./  #"
Write-Host "  ##  X          @#%,.@              @#%,.@          X   #"
Write-Host ", .# #X            @#%,.@          @#%,.@            X ##"
Write-Host "   `###X             @#%,.@      @#%,.@             ####."
Write-Host "  . . ###              @#%.,@  @#%,.@              ###`."
Write-Host "    . ...                @#%.@#%,.@                ..` . ."
Write-Host "      .                    @#%,.@                   ,."
Write-Host "      ` ,                @#%,.@  @@                "
Write-Host "                          @@@  @@@  "
						  
 Write-Host "ALERT! You are entering into a secured area! Your IP, Login Time, Username has been noted and has been sent to the server administrator!
This service is restricted to authorized users only. All activities on this system are logged.
Unauthorized access will be fully investigated and reported to the appropriate law enforcement agencies"
Write-Host " Created by Sam Arnold"
Write-Host "" 
Write-Host "**************************"

function prompt { 'Sams watching you ' + $env:USERNAME + " " + (get-location) + '> '}

New-Item C:\PowershellLogs -type directory -erroraction 'silentlycontinue' > $null
New-Item C:\PowershellLogs\log.txt -type file -erroraction 'silentlycontinue' > $null
echo "powershell Banner created by Sam Arnold"        >> C:\PowershellLogs\log.txt
$env:UserName                                         >> C:\PowershellLogs\log.txt
Get-Date -Format g                                    >>C:\PowershellLogs\log.txt
echo  "my Proccess ID:  "  + $pid                     >>C:\PowershellLogs\log.txt
Get-NetTCPConnection                                  >>C:\PowershellLogs\log.txt



   # password if in default location
   # Write-Host "Path exists on Server"
    #Create password
    $Answer="yes"
    $response= "null"

    #check for password
    While ($response -ne $Answer){
           $response = Read-host "Whats your password?"
          }
    #check for password again if broke with Ctrl C
    While ($response -ne $Answer){
           $response = Read-host "Whats your password?"
          }
    #check for password again if broke with Ctrl C
    While ($response -ne $Answer){
           $response = Read-host "Whats your password?"
          }
    #check for password again if broke with Ctrl C
    While ($response -ne $Answer){
           $response = Read-host "Whats your password?"
          }
   
   
   
   
   #see profile $profile