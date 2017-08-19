#################
#Created by Sam Arnold
# 7/17/17
# Set up the banner! for powershell
#################

#Unlocks scripts....but at the cost of letting powershell scripts
Set-ExecutionPolicy unrestricted

# Set up profile 
New-Item –Path $Profile –Type File –Force


# Create Temp if not created.
New-Item C:\TEMP -type directory -erroraction 'silentlycontinue' > $null

# Move Files to Temp
Copy-Item -Path "Microsoft.PowerShell_profile.ps1"  -Destination C:\TEMP\ -Force
Copy-Item -Path "Profile.ps1"  -Destination C:\TEMP\ -Force

$users=Get-LocalUser
ForEach ($user in $users){
    echo  $user.Name
    cd C:\Users -erroraction 'silentlycontinue'> $null
    cd $user.Name -erroraction 'silentlycontinue'> $null
    cd Documents -erroraction 'silentlycontinue'> $null
    #Create  for powershell
    New-Item WindowsPowerShell -type directory -erroraction 'silentlycontinue' > $null
    cd WindowsPowerShell -erroraction 'silentlycontinue' > $null
    #copy-Item -Path "C:\TEMP\Microsoft.PowerShell_profile.ps1"  -Destination Microsoft.PowerShell_profile.ps1 -Force -erroraction 'silentlycontinue' > $null
    Copy-Item -Path "C:\TEMP\Profile.ps1"  -Destination Profile.ps1 -Force -erroraction 'silentlycontinue' > $null
    }
  