$SecurePassword = Read-Host -Prompt "Enter password for all users" -AsSecureString 
$Exclude="Administrator","Guest","DefaultAccount"
Get-LocalUser|
  Where Enabled -eq 'True'|
  Where {$Exclude -notcontains $_.Name}|
    Set-Localuser -Password $SecurePassword