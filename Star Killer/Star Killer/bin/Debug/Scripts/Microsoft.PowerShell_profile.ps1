#################
# PowerSHell banner
# Created by Sam Arnold
# 7/17/17
# 
#################

# change freaking language 
$ExecutionContext.SessionState.LanguageMode=[System.Management.Automation.PSLanguageMode]::ConstrainedLanguage

#get the Get history change from online 
(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
import-module PsGet -erroraction 'silentlycontinue' > $null
install-module PsUrl -erroraction 'silentlycontinue' > $null
install-module PSReadline 
import-module PSReadline  
import-module PsUrl
$env:tmp = "c:\temp"
Start-Sleep -s 2
clear 
# if you don't already have this configured...
[console]::TreatControlCAsInput = $true

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Chord Ctrl+C -BriefDescription "Exit on Command" -ScriptBlock  {
	Exit
} 
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Ctrl+C -BriefDescription "Exit on Command" -ScriptBlock  {
	Exit
} 

#Clear console
clear 

#Log information
function prompt { 'Sams watching you ' + $env:USERNAME + " " + (get-location) + '> '}
$Mydate=Get-Date -Format g
New-Item C:\PowershellLogs -type directory -erroraction 'silentlycontinue' > $null
New-Item C:\PowershellLogs\log.txt -type file -erroraction 'silentlycontinue' > $null
echo "powershell Banner created by Sam Arnold"        >> C:\PowershellLogs\log.txt
$env:UserName                                         >> C:\PowershellLogs\log.txt
Get-Date -Format g                                    >>C:\PowershellLogs\log.txt
echo  "my Proccess ID:  "  + $pid                     >>C:\PowershellLogs\log.txt
Get-NetTCPConnection                                  >>C:\PowershellLogs\log.txt

# Set Exit routine 
Register-EngineEvent PowerShell.Exiting -Action { 
	$env:UserName              >>C:\PowershellLogs\myhistory.txt
	Get-Date -Format g         >>C:\PowershellLogs\myhistory.txt
	"Exiting $(Get-History)"   >>C:\PowershellLogs\myhistory.txt
}

#Clear console
clear 

Write-Host "Loading...Please hold my beer"
Start-Sleep -s 2

#Clear console
clear 

#Set Banner 
Write-Host "                      .~#########%%.~. "  -foregroundcolor red
Write-Host "                     /############%%.`\ " -foregroundcolor red
Write-Host "                   /######/~\/~\%%.,.,\ " -foregroundcolor red
Write-Host "                   |#######\    /.....,.|" -foregroundcolor red
Write-Host "                   |#########\/%......,.|" -foregroundcolor red
Write-Host "          XX       |##/~~\####%.../~~\.,|       XX" -foregroundcolor red
Write-Host "        XX..X      |#|  o  \##%./  o  |.|      X..XX" -foregroundcolor red
Write-Host "      XX.....X     |##\____/##%.\____/.,|     X.....XX" -foregroundcolor red
Write-Host "XXXXX.....XX      \#########/\......,, /      XX.....XXXXX" -foregroundcolor red
Write-Host "X |......XX%,.@      \######/%.\...., /      @#%,XX......| X" -foregroundcolor red
Write-Host "X |.....X  @#%,.@     |######%%....,.|     @#%,.@  X.....| X" -foregroundcolor red
Write-Host "X  \...X     @#%,.@   |# # # % . . .,|   @#%,.@     X.../  X" -foregroundcolor red
Write-Host " X# \.X        @#%,.@                  @#%,.@        X./  #" -foregroundcolor red
Write-Host "  ##  X          @#%,.@              @#%,.@          X   #"-foregroundcolor red
Write-Host ", .# #X            @#%,.@          @#%,.@            X ##"-foregroundcolor red
Write-Host "   `###X             @#%,.@      @#%,.@             ####."-foregroundcolor red
Write-Host "  . . ###              @#%.,@  @#%,.@              ###`."-foregroundcolor red
Write-Host "    . ...                @#%.@#%,.@                ..` . ."-foregroundcolor red
Write-Host "      .                    @#%,.@                   ,."-foregroundcolor red
Write-Host "      ` ,                @#%,.@  @@                "-foregroundcolor red
Write-Host "                          @@@  @@@  "-foregroundcolor red
						  
 Write-Host "ALERT! You are entering into a secured area! Your IP, Login Time, Username has been noted and has been sent to the server administrator!
This service is restricted to authorized users only. All activities on this system are logged.
Unauthorized access will be fully investigated and reported to the appropriate law enforcement agencies" -foregroundcolor yellow
Write-Host " Created by Sam Arnold" -foregroundcolor yellow
Write-Host "" 
Write-Host "**************************"


#keep loading
Write-Host "Loading...Please hold my beer"
Start-Sleep -s 5
   # password if in default location
   # Write-Host "Path exists on Server"
    #Create password
    $Answer="yes"
    $response= "null"

    try{
            #check for password
            While ($response -ne $Answer){
						
                   $response = Read-host -prompt "Whats your password?"
                  }
         }
	catch {
			exit;
		}
    finally {
		  While ($response -ne $Answer){
				#check for password
				While ($response -ne $Answer){
					   $response = Read-host  -prompt "Whats your password?"
					  }
				#check for password again if broke with Ctrl C
				While ($response -ne $Answer){
					   $response = Read-host  -prompt "Whats your password?"
					  }
				#check for password again if broke with Ctrl C
				While ($response -ne $Answer){
					   $response = Read-host  -prompt "Whats your password?"
					  }
				#check for password again if broke with Ctrl C
				While ($response -ne $Answer){
					   $response = Read-host  -prompt "Whats your password?"
					  }
				}
        }
   	
   	 Write-Host "Please hold on sir, I have other people to attend"
     Start-Sleep -s 5
	 #What if they canceled the command? Oh ya exit? 
	 While ($response -ne $Answer){
		exit; 
	 }
	Start-Sleep -s 1
	Write-Host "Burp...Already!"
   #see profile $profile