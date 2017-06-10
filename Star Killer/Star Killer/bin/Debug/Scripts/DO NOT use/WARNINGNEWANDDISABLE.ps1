$AdminPwd = ConvertTo-SecureString -string "foobar2016!" -AsPlainText -Force
$UserPwd = ConvertTo-SecureString -string "foobar2016!" -AsPlainText -Force

$NewAdmin = "NewAdmin"

New-LocalUser -Name $NewAdmin -FullName "New Admin" -Password $AdminPwd
Add-LocalGroupMember -Member $NewAdmin -Group "Administrators"

Get-LocalUser | ForEach-Object {

    if ($_.Name -ne $NewAdmin)
    {
        $_ | Set-LocalUser -Password $UserPwd
        $_ | Disable-LocalUser 
    }
}