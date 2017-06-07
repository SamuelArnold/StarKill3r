
$ttl = 128;
$stamp = 0;
$pmtu = 0;
$urg = 0;
$window = 4096;
$sack = 0;
$mtu=1500;
$var = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\", "DefaultTTL")
MsgBox(4096, "", $var)

$var = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\", "Tcp1323Opts")
MsgBox(4096, "", $var)

$var = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\", "EnablePMTUDiscovery")
MsgBox(4096, "", $var)

$var = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\", "TcpUseRFC1122UrgentPointer")
MsgBox(4096, "", $var)

$var = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\", "TcpWindowSize")
MsgBox(4096, "", $var)

$var = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\", "SackOpts")
MsgBox(4096, "", $var)

$var = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\", "DefaultTTL")
MsgBox(4096, "", $var)

;"REG_DWORD",
For $i = 1 To 100
	$var = RegEnumKey("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces", $i)
	If @error <> 0 Then ExitLoop
	$var = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\" & $var, "MTU")
	MsgBox(4096, "", $var)
Next