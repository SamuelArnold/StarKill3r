<#
Get-ASEPImagePathLaunchStringTimeStack.ps1
Requires logparser.exe in path

Pulls frequency of autoruns based on ImagePath, LaunchString and MD5 
tuple where the publisher is not verified (unsigned code) and the 
ImagePath is not 'File not found'

This on also includes the time stamp, which may break aggregation, but
provides some useful information.

This script expects files matching the *autorunsc.txt pattern to be in
the current working directory.
.NOTES
DATADIR Autorunsc
#>


if (Get-Command logparser.exe) {
    $lpquery = @"
    SELECT
        COUNT(ImagePath, LaunchString, MD5) as ct,
        ImagePath,
        LaunchString,
        MD5,
        Time,
        Publisher
    FROM
        *autorunsc.tsv
    WHERE
        ImagePath is not null and
        Publisher not like '(Verified)%' and
        (ImagePath not like 'File not found%')
    GROUP BY
        ImagePath,
        LaunchString,
        MD5,
        Time,
        Publisher
    ORDER BY
        ct ASC
"@

    & logparser -i:csv -dtlines:0 -fixedsep:on -rtp:-1 "$lpquery"

} else {
    $ScriptName = [System.IO.Path]::GetFileName($MyInvocation.ScriptName)
    "${ScriptName} requires logparser.exe in the path."
}
