$newpwd = Read-Host "Enter the new password" -AsSecureString
$UserAccount = Get-LocalUser
$UserAccount | Set-LocalUser -Password $newpwd