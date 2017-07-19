#################
# PowerSHell banner
# Created by Sam Arnold
# 7/17/17
# 
#################


# get the Get history change from online 
#(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
#import-module PsGet -erroraction 'silentlycontinue' > $null
#install-module PsUrl -erroraction 'silentlycontinue' > $null
##install-module PSReadline 
#import-module PSReadline  
#import-module PsUrl
Start-Sleep -s 2
clear 
# if you don't already have this configured...
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Ctrl+C -BriefDescription "Exit on Command" -ScriptBlock  {
	Exit
} 
Write-Host "Loading...Please hold my beer"
Start-Sleep -s 2
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

#Log information
function prompt { 'Sams watching you ' + $env:USERNAME + " " + (get-location) + '> '}
$Mydate=Get-Date -Format g
$parentpid = (gwmi Win32_Process -filter "processid = $($([System.Diagnostics.Process]::GetCurrentProcess() | select Id).Id)" | select ParentProcessId).ParentProcessId
New-Item C:\PowershellLogs -type directory -erroraction 'silentlycontinue' > $null
New-Item C:\PowershellLogs\log.txt -type file -erroraction 'silentlycontinue' > $null
echo "powershell Banner created by Sam Arnold"        >> C:\PowershellLogs\log.txt
$env:UserName                                         >> C:\PowershellLogs\log.txt
Get-Date -Format g                                    >>C:\PowershellLogs\log.txt
echo  "my Proccess ID:  "  + $pid                     >>C:\PowershellLogs\log.txt
echo  "my Parent Proccess ID:  "  + $parentpid        >>C:\PowershellLogs\log.txt
Get-NetTCPConnection                                  >>C:\PowershellLogs\log.txt

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