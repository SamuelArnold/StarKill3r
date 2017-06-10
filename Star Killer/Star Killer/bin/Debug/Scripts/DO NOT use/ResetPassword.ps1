Add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010
$newpwd = Read-Host "Enter the new password" -AsSecureString
Get-LocalUser | ForEach-Object {
    $_ | Set-LocalUser -Password $newpwd  
}