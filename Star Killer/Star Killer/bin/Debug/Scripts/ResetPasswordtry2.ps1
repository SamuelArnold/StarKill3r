# Specify the OU.
$OU = [ADSI]"LDAP://ou=West,dc=MyDomain,dc=com"

# Enumerate all objects in the OU.
$arrChildren = $OU.Get_Children()
ForEach ($User In $arrChildren)
{
    # Only consider user objects.
    If ($User.Class -eq "user")
    {
        # Set password.
        $User.Invoke("SetPassword", "Cutman20xx")
        # Expire the password.
        $User.pwdLastSet = 0
        $User.SetInfo()
    }
}