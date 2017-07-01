########################
# Written by Sam Arnold 
# 6/28/17
# Loops through all process and runs yara
# prints results to Result.txt 
########################

#Clear the Result File
echo "" > results2.txt


# loop Through processes
Get-Process | ForEach-Object {

    #Get Name, ID, and Locatio of each process
    Write-Host $_.name -foregroundcolor cyan;
    Write-Host $_.Path -foregroundcolor yellow;
    Write-Host $_.id -foregroundcolor yellow;
     
    # Scan With Yara
    ./yara64.exe  ./Rules/rules-master/Exploit-Kits_index.yar $_.id 
    ./yara64.exe  ./Rules/rules-master/Exploit-Kits_index.yar $_.id >> results2.txt

    #./yara64.exe  ./Rules/rules-master/malware_index.yar $_.id 
    #./yara64.exe  ./Rules/rules-master/malware_index.yar $_.id >> results2.txt

    ./yara64.exe  ./Rules/rules-master/CVE_Rules_index.yar $_.id 
    ./yara64.exe  ./Rules/rules-master/CVE_Rules_index.yar $_.id >> results2.txt

    #./yara64.exe  ./Rules/rules-master/Malicious_Documents_index.yar $_.id 
    #./yara64.exe  ./Rules/rules-master/Malicious_Documents_index.yar $_.id >> results2.txt

    #./yara64.exe  ./Rules/rules-master/Packers_index.yar $_.id 
    #./yara64.exe  ./Rules/rules-master/Packers_index.yar $_.id >> results2.txt

    ./yara64.exe  ./Rules/rules-master/Webshells_index.yar $_.id 
    ./yara64.exe  ./Rules/rules-master/Webshells_index.yar $_.id >> results2.txt
  }

  