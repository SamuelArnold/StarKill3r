########################
# Written by Sam Arnold 
# 6/28/17
# Loops through all process and runs yara
# prints results to Result.txt 
########################

#Clear the Result File
echo "" > results3.txt


# loop Through processes
Get-Process | ForEach-Object {

    #Get Name, ID, and Locatio of each process
    Write-Host $_.name -foregroundcolor cyan;
    Write-Host $_.Path -foregroundcolor yellow;
    Write-Host $_.id -foregroundcolor yellow;
     
    # Scan With Yara
    ./yara64.exe  ./Rules/rules-master/Antidebug_AntiVM_index.yar $_.id 
    ./yara64.exe  ./Rules/rules-master/Antidebug_AntiVM_index.yar $_.id >> results3.txt
  }

  