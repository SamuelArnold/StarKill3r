;Code By Irongeek@irongeek.com, based on ideas and research from Craig Heffner
;Consider it GPLed, and check for updates on my site:http://Irongeek.com
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=fingerprint.ico
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIComboBox.au3>
#include <GuiConstantsEx.au3>
#include <Constants.au3>
Opt('MustDeclareVars', 1)
$Debug_CB = False
GUICreate("OSfuscate 0.3", 250, 90, 193, 115)
GUICtrlCreateLabel("Choose OS Profile To Apply:", 0, 0, 245, 28)
GUICtrlSetFont(-1, 15, 400, 0, "MS Sans Serif")
Global $OSCombo = GUICtrlCreateCombo("Remove All Settings", 8, 32, 233, 299)
Global $ApplyButton = GUICtrlCreateButton("Apply", 168, 64, 75, 25, 0)
Global $iglink = GUICtrlCreateButton("Go to http://Irongeek.com", 0, 70, 150, 15)
Global $nMsg ; For switch statement
GUISetState(@SW_SHOW)

_GUICtrlComboBox_BeginUpdate($OSCombo)
_GUICtrlComboBox_AddDir($OSCombo, "profiles" & "\*.os")
_GUICtrlComboBox_EndUpdate($OSCombo)
While 1
	$nMsg = GUIGetMsg()
	
	Switch $nMsg
		Case $ApplyButton
			SetOSFingerprint(GUICtrlRead($OSCombo))
			MsgBox(0, "Done", "Profile " & GUICtrlRead($OSCombo) & " applied, please reboot for the changes to take effect.")
			Exit
		Case $iglink
			ShellExecute("http://www.irongeek.com/i.php?page=security/osfuscate-change-your-windows-os-tcp-ip-fingerprint-to-confuse-p0f-networkminer-ettercap-nmap-and-other-os-detection-tools")
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

Func SetOSFingerprint($osprofile)
	Local $regkeypath = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\"
	Local $ttl
	Local $stamp
	Local $pmtu
	Local $urg
	Local $window
	Local $sack
	Local $mtu
	Local $subkey
	If $osprofile = "Remove All Settings" Then
		$ttl = "x"
		$stamp = "x"
		$pmtu = "x"
		$urg = "x"
		$window = "x"
		$sack = "x"
		$mtu = "x"
		
	Else
		$osprofile = "profiles\" & $osprofile
		$ttl = IniRead($osprofile, "tcpstack", "ttl", "x")
		$stamp = IniRead($osprofile, "tcpstack", "stamp", "x")
		$pmtu = IniRead($osprofile, "tcpstack", "pmtu", "x")
		$urg = IniRead($osprofile, "tcpstack", "urg", "x")
		$window = IniRead($osprofile, "tcpstack", "window", "x")
		$sack = IniRead($osprofile, "tcpstack", "sack", "x")
		$mtu = IniRead($osprofile, "tcpstack", "mtu", "x")
	EndIf
	;MsgBox(0,"",$osprofile)
	If $ttl = "x" Then
		RegDelete($regkeypath, "DefaultTTL")
	Else
		RegWrite($regkeypath, "DefaultTTL", "REG_DWORD", $ttl)
	EndIf

	If $stamp = "x" Then
		RegDelete($regkeypath, "Tcp1323Opts")
	Else
		RegWrite($regkeypath, "Tcp1323Opts", "REG_DWORD", $stamp)
	EndIf

	If $pmtu = "x" Then
		RegDelete($regkeypath, "EnablePMTUDiscovery")
	Else
		RegWrite($regkeypath, "EnablePMTUDiscovery", "REG_DWORD", $pmtu)
	EndIf

	If $urg = "x" Then
		RegDelete($regkeypath, "TcpUseRFC1122UrgentPointer")
	Else
		RegWrite($regkeypath, "TcpUseRFC1122UrgentPointer", "REG_DWORD", $urg)
	EndIf

	If $window = "x" Then
		RegDelete($regkeypath, "TcpWindowSize")
	Else
		RegWrite($regkeypath, "TcpWindowSize", "REG_DWORD", $window)
	EndIf

	If $sack = "x" Then
		RegDelete($regkeypath, "SackOpts")
	Else
		RegWrite($regkeypath, "SackOpts", "REG_DWORD", $sack)
	EndIf
	;MsgBox(0, $mtu, "("&$mtu&")")
	If $mtu = "x" Then
		;"REG_DWORD",
		For $i = 1 To 100
			$subkey = RegEnumKey($regkeypath & "Interfaces", $i)
			If @error <> 0 Then ExitLoop
			RegDelete($regkeypath & "Interfaces\" & $subkey, "MTU")
		Next

	Else
		;"REG_DWORD",
		For $i = 1 To 100
			$subkey = RegEnumKey($regkeypath & "Interfaces", $i)
			If @error <> 0 Then ExitLoop
			RegWrite($regkeypath & "Interfaces\" & $subkey, "MTU", "REG_DWORD", $mtu)
		Next
	EndIf

EndFunc   ;==>SetOSFingerprint