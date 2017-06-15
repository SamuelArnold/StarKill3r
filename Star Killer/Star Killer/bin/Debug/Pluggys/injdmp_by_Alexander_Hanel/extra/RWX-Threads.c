
/*
Author:
        alexander<dot>hanel<at>gmail<dot>com

NOtes:
Most of the code is hacked together from code snippets I found.  
The code searches for all threads that are running in RWX 
memory. I found a similar approach by Michael Ligh that checks
for threads without modules. Disclaimier: I came up with this before
seeing his work. Anyways I automatically assume everything I have coded has
already been thought of and been implemented in volatility years ago... 

License:
injdmp is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see
<http://www.gnu.org/licenses/>.
*/



#include <windows.h>
#include <Tlhelp32.h>
#include <tchar.h>
 
#define STATUS_SUCCESS ((NTSTATUS)0x00000000L)
#define ThreadQuerySetWin32StartAddress 9
 
typedef NTSTATUS (WINAPI *NTQUERYINFOMATIONTHREAD)(HANDLE, LONG, PVOID, ULONG, PULONG);
 
BOOL MatchAddressToModule(__in DWORD dwProcId, __out_bcount(MAX_PATH + 1) LPTSTR lpstrModule, __in DWORD dwThreadStartAddr, __out_opt PDWORD pModuleStartAddr) // by Echo
{
    BOOL bRet = FALSE;
    HANDLE hSnapshot;
    MODULEENTRY32 moduleEntry32;
 
    hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPMODULE | TH32CS_SNAPALL, dwProcId);
 
    moduleEntry32.dwSize = sizeof(MODULEENTRY32);
    moduleEntry32.th32ModuleID = 1;
 
    if(Module32First(hSnapshot, &moduleEntry32)){
        if(dwThreadStartAddr >= (DWORD)moduleEntry32.modBaseAddr && dwThreadStartAddr <= ((DWORD)moduleEntry32.modBaseAddr + moduleEntry32.modBaseSize)){
            _tcscpy(lpstrModule, moduleEntry32.szExePath);
        }else{
            while(Module32Next(hSnapshot, &moduleEntry32)){
                if(dwThreadStartAddr >= (DWORD)moduleEntry32.modBaseAddr && dwThreadStartAddr <= ((DWORD)moduleEntry32.modBaseAddr + moduleEntry32.modBaseSize)){
                    _tcscpy(lpstrModule, moduleEntry32.szExePath);
                    break;
                }
            }
        }
    }
 
    if(pModuleStartAddr) *pModuleStartAddr = (DWORD)moduleEntry32.modBaseAddr;
    CloseHandle(hSnapshot);
 
    return bRet;
}
 
DWORD WINAPI GetThreadStartAddress(__in HANDLE hThread) // by Echo
{
    NTSTATUS ntStatus;
    DWORD dwThreadStartAddr = 0;
    HANDLE hPeusdoCurrentProcess, hNewThreadHandle;
    NTQUERYINFOMATIONTHREAD NtQueryInformationThread;
 
    if((NtQueryInformationThread = (NTQUERYINFOMATIONTHREAD)GetProcAddress(GetModuleHandle(_T("ntdll.dll")), _T("NtQueryInformationThread")))){
        hPeusdoCurrentProcess = GetCurrentProcess();
        if(DuplicateHandle(hPeusdoCurrentProcess, hThread, hPeusdoCurrentProcess, &hNewThreadHandle, THREAD_QUERY_INFORMATION, FALSE, 0)){
            ntStatus = NtQueryInformationThread(hNewThreadHandle, ThreadQuerySetWin32StartAddress, &dwThreadStartAddr, sizeof(DWORD), NULL);
            CloseHandle(hNewThreadHandle);
            if(ntStatus != STATUS_SUCCESS) return 0;
        }
 
    }
    return dwThreadStartAddr;
}
 
int main()
{
    HANDLE hSnapshot, hThread;
    THREADENTRY32 threadEntry32;
    DWORD dwModuleBaseAddr, dwThreadStartAddr;
    TCHAR lpstrModuleName[MAX_PATH + 1] = {0};
 
	// TH32CS_SNAPTHREAD option allows for a PID to be passed. 
    if((hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 5216)) == INVALID_HANDLE_VALUE) return -1;
 
    puts(_T("Listing thread-dll assocations for winrar.exe....\n"));
 
    threadEntry32.dwSize = sizeof(THREADENTRY32);
    threadEntry32.cntUsage = 0;
 
    if(Thread32First(hSnapshot, &threadEntry32)){
        if(threadEntry32.th32OwnerProcessID == 5216){
            hThread = OpenThread(THREAD_QUERY_INFORMATION, FALSE, threadEntry32.th32ThreadID);
            dwThreadStartAddr = GetThreadStartAddress(hThread);
            MatchAddressToModule(5216, lpstrModuleName, dwThreadStartAddr, &dwModuleBaseAddr);
            printf(_T("[+] %s+0x%08X\n"), lpstrModuleName, dwThreadStartAddr - dwModuleBaseAddr);
            CloseHandle(hThread);
        }
        while(Thread32Next(hSnapshot, &threadEntry32)){
            if(threadEntry32.th32OwnerProcessID == 5216){
                hThread = OpenThread(THREAD_QUERY_INFORMATION, FALSE, threadEntry32.th32ThreadID);
                dwThreadStartAddr = GetThreadStartAddress(hThread);
                MatchAddressToModule(5216, lpstrModuleName, dwThreadStartAddr, &dwModuleBaseAddr);
                printf(_T("[+] %s+0x%08X\n"), lpstrModuleName, dwThreadStartAddr - dwModuleBaseAddr);
                CloseHandle(hThread);
            }
        }
    }
 
    CloseHandle(hSnapshot);
 
    return 0;
}