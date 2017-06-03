ABOUT
-----

This program scans the memory in order to detect and also kill Metasploit's meterpreter.
You may check screenshots for more information. (meterpreter_detected.jpg & meterpreter_not_detected.jpg)


USAGE
-----

Usage: antimeter.exe [arguments]

Optional arguments:
-t <time interval>      Scans memory in every specified time interval (Default time interval is one minute)
-a                      Automatically kills the meterpreter process (Disabled by default)
-d                      Only detects the meterpreter process (Disabled by default)
-e			Adds process to the exclusion list


EXAMPLES
--------

Scans memory in every 5 minutes, kills the meterpreter process automatically, verbose mode is enabled: antimeter.exe -t 5 -a -v

Scans memory in every minute and only detects the meterpreter process: antimeter.exe -n

Scans memory in every minute, explorer and winlogon processes are excluded from scanning: antimeter.exe -e explorer.exe,winlogon.exe


CHANGELOG (v2.0)
----------------

Added logging feature. (log file is antimeter.txt)
Added auto kill feature. (Kills the meterpreter process automatically after detection, no user interaction)
Added "detection mode only" feature. (Does not kill the meterpreter process, detection only)
Added exclusion support. (Do not scan specified processes. Seperate multiple processes with , (comma))


CONTACT
-------

Author: Mert SARICA
Email: mert [ . ] sarica [ @ ] gmail [ . ] com
URL: http://www.mertsarica.com