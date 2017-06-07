netsh interface show interface
netsh dnsclient add dnsserver "Local Area Connection" 208.67.222.222 1
netsh dnsclient add dnsserver "Local Area Connection" 208.67.220.220 2
$host.enternestedprompt()