###################
# CMD and Powershell Lockdown
# Created by Sam Arnold
# 7 / 11 /17
# Changes the permissions of Powershell and CMD
# To Administrator only
#
#
####################



####################
#Lockdown CMD
####################

./chml C:\Windows\syswow64\cmd.exe -i:h -b -fs
./chml C:\Windows\system32\cmd.exe -i:h -b- fs


####################
#Lockdown Powershell
####################

./chml C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -i:h -b -fs
./chml C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe -i:h -b -fs
./chml C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell_ise.exe -i:h -b -fs
./chml C:\Windows\system32\WindowsPowerShell\v1.0\powershell_ise.exe -i:h -b -fs
