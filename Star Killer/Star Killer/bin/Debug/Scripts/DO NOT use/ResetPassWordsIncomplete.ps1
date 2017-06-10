write-output "`r`nUsers on This Host `r`n----------`r`n"

#Get local admins group
$variable = Invoke-Command {
net users | 
where {$_ -AND $_ -notmatch "command completed successfully"} | 
#select skip 1
select -skip 1
}
echo $variable

$newpwd = Read-Host "Enter the new password" -AsSecureString
#Set-ADAccountPassword jfrost -NewPassword $newpwd –Reset