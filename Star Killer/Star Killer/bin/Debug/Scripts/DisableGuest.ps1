Get-LocalUser | ForEach-Object {
    if ($_.Name -e "Guest")
    {
        $_ | Disable-LocalUser 
    }
}



Get-LocalUser | ForEach-Object {
    if ($_.Name -e "DefaultAccount")
    {
        $_ | Disable-LocalUser 
    }
}
