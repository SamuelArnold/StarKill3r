#
    .SYNOPSIS
        Enables Complete Memory dumps during a Bug Check
    .DESCRIPTION
        This command will size the page file if neccessary and configure Complete memory dumps
    .PARAMETER  SetPageFileSize
        Tells the command whether you wish to set the page file size during the operation. This may be needed on systems where the pagefile is set to system managed
    .PARAMETER ForceRestart
        Tells the command whether to force restart after configuring the system correctly.
    .PARAMETER PagefileLocation
        This is an optional parameter if you wish to specify the location of the pagefile during the operation. Use with the SetPageFileSize switch.
    .PARAMETER  Multiple
        This is an optional parameter if you wish to specify by what portion to caculate the pagefile size vs physical RAM. By default this option is 1.5
    .PARAMETER NMICrashdump
        Enables NMI Crashdumps as per httpsupport.microsoft.comkb927069
     .PARAMETER CrashOnCtrlScroll
        Enables Crashdumps when [CTRl] + [Scroll lock] + [Scroll lock] is pressed, as per httpsupport.microsoft.comkb244139
     .PARAMETER RebootAfterCrash
        Enables Specifies whether the system should reboot after a crashdump (enabled by default)
     .PARAMETER Overwriteexistingdebugfile
        Enables Specifies whether the system should overwrite a debug file if it already exists (enabled by default)
      .PARAMETER SendAdminAlert
        Enables Specifies whether the system should send an administrative alert (enabled by default)
     .PARAMETER DumpFileLocation
        Enables Specifies where the system should write the dump file (cmemory.dmp by default)
    .EXAMPLE
        PS C&gt; enable-completememorydump
        This command will enable complete memory dumps using the system specified pagefile if possible.
    .EXAMPLE
        PS C&gt; enable-completememorydump -setpagefilesize -pagefilelocation cpagefile1.sys -multiple 2 -forcerestart
        This command forces the pagefile to be Ram  2, sets the page file location to a new file (pagefile1.sys) and forces a restart on completion.
     .EXAMPLE
        PS C&gt; enable-completememorydump -setpagefilesize -forcerestart
        This command forces the pagefile to be Ram  1.5 (the default) and forces a restart on completion.
     .EXAMPLE
        PS C&gt; enable-completememorydump -setpagefilesize -forcerestart -CrashOnCtrlScroll -NMICrashdump
        This command forces the pagefile to be Ram  1.5 (the default), enables crash on ctrlscroll and nmicrashdumps and forces a restart on completion.
     .EXAMPLE
        PS C&gt; enable-completememorydump -RebootafterCrash$false -OverwriteExistingDebugFile$false
        This command enables complete memory dumps, but specifies not to restart after a crash dump, or overwrite an existing dump file.
    .INPUTS
        Strings and switches.
    .OUTPUTS
        Page file settings.
    .NOTEStest
        httpwww.andrewmorgan.ie
    .LINK
        na
#
function enable-completememorydump{

    param(
       [switch]$RebootafterCrash=$false,
       [switch]$OverwriteExistingDebugFile=$True,
       [switch]$SendAdminAlert=$true,
       [switch]$SetPageFileSize=$false,
       [string]$Multiple=,
       [switch]$NMICrashdump=$false,
       [switch]$CrashOnCtrlScroll=$false,
       [string]$dumpfilelocation=cMemory.dmp,
       [string]$PageFileLocation=CPagefile.sys,
       [switch]$forcerestart=$false
    )

    #Checking Current Pagefile Configuration
    $CurrentPageFileConfig = (get-itemproperty HKLMSYSTEMCurrentControlSetControlSession ManagerMemory Management).pagingfiles

    #Calculating Current Physical RAM
    $PhysicalRam = [system.math]round(((gwmi win32_computersystem).totalphysicalmemory 1024) 1024)
    
    #stopping, warning and handling if pagefile configuration is system managed
    if ($CurrentPagefileconfig -eq Pagefile.sys){
        $IsPageFileSystemManaged=$true
    }#endif (check for system managed page file)

    #pagefile isnt system managed
    Else{
        $CurrentPagefilelocation = $CurrentPageFileConfig[0].split()[0]
        $CurrentPagefileInitialSize = $CurrentPagefileConfig[0].split( )[1]
        $CurrentPagefileMaximumSize = $CurrentPagefileConfig[0].split( )[2]

        #check for legacy page file settings
        if ($CurrentPagefileMaximumSize -eq 0){
            $IsPageFileSystemManaged=$true
        }#end if
    }#end else

if ($ispagefilesystemmanaged -eq $true)
    {if ($SetPageFileSize -ne $true){
        write-warning The Pagefile is currently system managed, this can have adverse effects on the full system dump if the Pagefile is less than the ammount of Phyiscal memory available to the system. Use the -SetPageFileSize command to manually manage the Pagefile. No changes have been made.
        break}
}#end if (check for system managed page file)

    if ($SetPageFileSize -eq $true){
        #Checking for multiple integer
        if ($multiple -eq ){
            write-host No Multiple specified for pagefile size, using the default 1.5 calculation, this will set a page file of ram  1.5
            $Multiple=1.5}
    #try here
        $NewPageFileSize=[system.math]round($PhysicalRAM  $multiple)
        set-itemproperty HKLMSYSTEMCurrentControlSetControlSession ManagerMemory Management -name pagingfiles -value $Pagefilelocation $NewPagefilesize $NewPagefilesize
        Write-warning The Pagefile has been configured, a restart is neccessary to apply changes to the Pagefile size
    }#end if for set pagefile size
    
    #Setpage file is not specified, checking to ensure current settings can take a full memory dump
    Else{
        if ($CurrentPageFileInitialSize -lt ($PhysicalRAM) + 2) {
            write-warning The current Initial Pagefile Size is not large enough to capture a full memory dump, try using the -setpagefilesize switch to size the page file appropriately
            Break}
    }#end else (Check of initial size)

    #Configuring Complete dumps, with options
    Get-WmiObject win32_osrecoveryconfiguration -EnableAllPrivileges  Set-WmiInstance -Arguments @{DebugInfoType=1}  out-null
    Get-WmiObject win32_osrecoveryconfiguration -EnableAllPrivileges  Set-WmiInstance -Arguments @{AutoReboot=$RebootafterCrash.tobool()}  out-null
    Get-WmiObject win32_osrecoveryconfiguration -EnableAllPrivileges  Set-WmiInstance -Arguments @{OverwriteExistingDebugFile=$OverwriteExistingDebugFile.tobool()}  out-null
    Get-WmiObject win32_osrecoveryconfiguration -EnableAllPrivileges  Set-WmiInstance -Arguments @{DebugFilePath=$dumpfilelocation}  out-null
    Get-WmiObject win32_osrecoveryconfiguration -EnableAllPrivileges  Set-WmiInstance -Arguments @{SendAdminAlert=$SendAdminAlert.tobool()}  out-null

    #pulling new configuration to be returned at end of function
    $NewPagefileconfig = (get-itemproperty HKLMSYSTEMCurrentControlSetControlSession ManagerMemory Management).pagingfiles

    if ($NMICrashdump -eq $true){
        if (!(test-path HKLMSYSTEMCurrentControlSetControlCrashControl)){
            new-item -path HKLMSYSTEMCurrentControlSetControlCrashControl -itemtype Directory -force  out-null}
        #write-host enabling NMI crashing
        set-itemproperty HKLMSYSTEMCurrentControlSetControlCrashControl -name NMICrashDump -Type DWORD -value 1
    }
    
    if ($CrashOnCtrlScroll -eq $true){
        #write-host enabling ctrl scroll crashing
        #usb keyboards
        if (!(test-path HKLMSystemCurrentControlSetServiceskbdhidParameters)){
            new-item -path HKLMSystemCurrentControlSetServiceskbdhidParameters -itemtype Directory -force  out-null}
        set-itemproperty HKLMSystemCurrentControlSetServiceskbdhidParameters -name CrashOnCtrlScroll -Type DWORD -value 1

        #ps2 keyboards
        if (!(test-path HKLMSystemCurrentControlSetServicesi8042prtParameters)){
            new-item -path HKLMSystemCurrentControlSetServiceskbdhid -itemtype Directory -force  out-null}
        set-itemproperty HKLMSystemCurrentControlSetServicesi8042prtParameters -name CrashOnCtrlScroll -Type DWORD -value 1
    }

   #Forcing a restart if wanted
    if ($forcerestart -eq $true)
        {restart-computer
    }#end restart if

    return $NewPagefileconfig

}#end function