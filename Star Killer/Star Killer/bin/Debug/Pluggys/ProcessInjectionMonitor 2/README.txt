ProcessInjectionMintor by 0x1a0ran
ProcessInjectionMonitor detects any process injection and generate executables to preserve the injected code dynamically.

Usage
------
Make sure ProcessInjectionMonitor.dll is in the same folder with ProcessInjectionMonitorLauncher.exe.

.\ProcessInjectionMonitorLauncher.exe PATH_TO_YOUR_MALWARE


OUTPUT
------
Detected process injection will be output to the console. If there's any direct code injection, the injected code will be assemble into an executable dynamically and stored in the current folder with name "victim_pid.exe".