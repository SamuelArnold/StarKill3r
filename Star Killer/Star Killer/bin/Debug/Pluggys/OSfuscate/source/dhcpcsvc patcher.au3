#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=fingerprint.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <string.au3>
;dhcpcsvc.dll patcher by Irongeek from http://irongeek.com
;Base on work from piccaso
$line = "4d53465420352e30"
;$vendorcode = "4675636b20204954"
$vendorcode = InputBox("Dhcpcsvc.dll patcher by Irongeek from http://irongeek.com", "What 8  byte string do you want to use?", "MSFT 5.0")&"        "
$vendorcode = StringLeft($vendorcode,8)
;MsgBox(0,"",$vendorcode)
$vendorcode = Hex(StringToBinary($vendorcode))
;MsgBox(0,"",$vendorcode)
$vendorcode=$vendorcode
$file = FileOpenDialog("Find dhcpcsvc.dll", @SystemDir, "All (*.dll)", 1)
If @error Then Exit -1
$filesize = FileGetSize($file)
$data = FileRead($file)
If Not IsBinary($data) Then $data = Binary($data)
FileMove($file, "*.bak")
$hex = Hex($data)
;If StringInStr($hex,"55505830") And StringInStr($hex,"55505831") And StringInStr($hex,"55505821") Then
;    ConsoleWrite("Would you de-upx it for me?" & @LF)
;    Exit -2
;EndIf
$hex = StringReplace($hex, $line, $vendorcode)
If @extended = 1 Then
	ConsoleWrite("Done" & @LF)
Else
	MsgBox(0,"Error", "Something bad happend with hex replace!" & @LF)
	exit
EndIf
FileDelete("patched-dhcpcsvc.dll")
FileWrite("patched-dhcpcsvc.dll", Binary("0x" & $hex))
If FileGetSize($file) <> $filesize Then ConsoleWrite("Bad Filesize")
MsgBox(0,"Done", "'patched-dhcpcsvc.dll' created in same folder as dhcpcsvc.dll. Reboot using a LiveCD with NTFS support (Linux or BartPE), backup dhcpcsvc.dll and rename patched-dhcpcsvc.dll to dhcpcsvc.dll. DO THIS AT YOUR OWN RISK!!! It could screw up your system.")