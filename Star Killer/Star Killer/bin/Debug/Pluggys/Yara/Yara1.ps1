########################
# Written by Sam Arnold 
# 6/28/17
# Loops through all process and runs yara
# prints results to Result.txt 
########################

#Clear the Result File
echo "" > results1.txt


# loop Through processes
Get-Process | ForEach-Object {

    #Get Name, ID, and Locatio of each process
    Write-Host $_.name -foregroundcolor cyan;
    Write-Host $_.Path -foregroundcolor yellow;
    Write-Host $_.id -foregroundcolor yellow;
     
    # Scan With Yara
    ./yara64.exe  ./Rules/KevTheHermitRulesSet/allrules.yar $_.id 
    ./yara64.exe  ./Rules/KevTheHermitRulesSet/allrules.yar  $_.id >> results1.txt
  }

  