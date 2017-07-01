
Get-Process | ForEach-Object {
    Write-Host $_.name -foregroundcolor cyan;
    Write-Host $_.Path -foregroundcolor yellow;
    Write-Host $_.id -foregroundcolor yellow;
    #./../Pluggys/Yara/
    #.\yarac64.exe    ./../../Pluggys/Yara/Rules/KevTheHermitRulesSet/AAR.yar .

    ./yara64.exe  ./Rules/KevTheHermitRulesSet/AAR.yar $_.Path >> results.txt

  }

Get-Process | ForEach-Object {
    Write-Host $_.name -foregroundcolor cyan;
    Write-Host $_.Path -foregroundcolor yellow;
    Write-Host $_.id -foregroundcolor yellow;
    #./../Pluggys/Yara/
    #.\yarac64.exe    ./../../Pluggys/Yara/Rules/KevTheHermitRulesSet/AAR.yar .

    ./yara64.exe  ./Rules/KevTheHermitRulesSet/AAR.yar $_.Path >> results.txt

    ./yara64.exe  ./Rules/rules-master/Antidebug_AntiVM_index.yar $_.Path >> results.txt

  }

  #Get-WmiObject win32_service  | select Name, DisplayName, State, PathName {
  #}
 
  
  
  