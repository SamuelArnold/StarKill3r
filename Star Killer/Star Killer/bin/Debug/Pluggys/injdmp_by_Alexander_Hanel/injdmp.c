/*
Author:
        alexander<dot>hanel<at>gmail<dot>com

Notes:
This is a project I started to learn C. It has been on hold for a 
bit. I'm releaseing in case anybody else wants to use it or look 
at the code. Please feel free to shoot me an email with any code 
recomendations, best practice, etc. 

Disclaimer:
This should go without saying but this isn't an incident response
tool. Use volatility if you need to detect injected processes. 
Mostly tested on Windows XP. It does run in 64 bit environments
but will not dump 64 bit processes. 

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
#include <stdio.h>
#include <stdlib.h>
#include <tchar.h>
#include <tlhelp32.h>
#include <psapi.h>
#include <string.h>
#include <time.h>

#define MAX_KEY_LENGTH 255
#define PSAPI_VERSION 1
#pragma comment(lib, "psapi.lib")


/******************************************************************************
* Global Varibles  
******************************************************************************/
BOOL watch = FALSE;

/******************************************************************************
* Structs 
******************************************************************************/

/* This struct is used to store information about DLLs loaded via Registry keys */
typedef struct _PSDLLS
{
	HANDLE hProc;
	char filePath[MAX_PATH];
	int address;
	int size;
	struct _PSDLL *next;

} PSDLLS;

/* This struct is used to store information related to PIDs of commonly injected processes */
typedef struct _PSLIST
{
	int pid;
	char psname[MAX_PATH];
	struct _PSLIST *next;

} PSLIST;

/* This struct is used to store informatio related to blocks of memory with RWX rights */
typedef struct _MEMBLOCK
{
	HANDLE hProc;
	unsigned char *addr;
	int size;
	unsigned char *buffer;
	struct _MEMBLOCK *next;

} MEMBLOCK;

/******************************************************************************
* Function Declaration and Function Prototypes
******************************************************************************/
char * getIePath( );
typedef BOOL (WINAPI *LPFN_ISWOW64PROCESS) (HANDLE, PBOOL);

/*
PSLIST* GetProcessList( );
BOOL EnableTokenPrivilege ( LPTSTR );
MEMBLOCK* create_memblock ( HANDLE,  MEMORY_BASIC_INFORMATION );
void free_memblock ( MEMBLOCK );
char * getIePath( );
MEMBLOCK* create_scan ( unsigned int );
void free_scan ( MEMBLOCK );
int calcSize( MEMBLOCK );
void dump_scan_info ( MEMBLOCK, int);
*/

/******************************************************************************
* This functions displays notes for the code. Function is called in Main().
******************************************************************************/
void notes (  )
{
	printf(" injdmp.exe 1.5 is a process memory scanner for dumping injected code\n"
		  " It dumps RWX memory, registry based DLL injection and executable(s)\n"
		  " injected into private memory. For non-commerical use.\n"
		  " Written by alexander<dot>hanel<at>gmail<dot>com.\n");
}

/******************************************************************************
* This functions displays a help message for the user. Function is called in 
* Main.
******************************************************************************/
void usage (  )
{
	printf("Arugments:\n"
		  " -c      * Scans commonly injected processes\n"									
		  " -pPID   * Scans a process based off of the process id. No spaces \n"
		  " -d      * Opens up dummy process of iexplore.exe and scans it.\n"
		  " -a      * Executes the default scan of commonly injected processes\n"
		  "           and the -d (dummy option).\n"
		  " -s	 * Displays scan results but does not dump memory. Must be the \n"
		  "           last command. Stalker.\n"
		  " -h	 * Prints this help message\n");
}

/******************************************************************************
* This function adjusts the process token.  
* Source: http://cboard.cprogramming.com/c-programming/108648-help-readprocessmemory-function.html#post802074
* Another good resource: http://winterdom.com/dev/security/tokens
******************************************************************************/
BOOL EnableTokenPrivilege (LPTSTR pPrivilege)
{
	HANDLE hToken;                        
	TOKEN_PRIVILEGES token_privileges;                  
	DWORD dwSize;                        
	ZeroMemory (&token_privileges, sizeof (token_privileges));
	token_privileges.PrivilegeCount = 1;
	if ( !OpenProcessToken (GetCurrentProcess(), TOKEN_ALL_ACCESS, &hToken))
	{
		printf("OpenProcessToken failed");
		return FALSE;
	}
	if (!LookupPrivilegeValue ( NULL, pPrivilege, &token_privileges.Privileges[0].Luid))
	{ 
		printf("LookupPrivilegeValue failed");
		CloseHandle (hToken);
		return FALSE;
	}
	token_privileges.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED;
	if (!AdjustTokenPrivileges ( hToken, FALSE, &token_privileges, 0, NULL, &dwSize))
	{ 
		printf("AdjustTokenPrivileges failed");
		CloseHandle (hToken);
		return FALSE;
	}
	CloseHandle (hToken);
	return TRUE;
}

/******************************************************************************
* Check if a process is 64 bit. 
******************************************************************************/
BOOL isWow64( HANDLE hProc )
{
   BOOL bIsWow64 = FALSE;
   LPFN_ISWOW64PROCESS fnIsWow64Process;

    //IsWow64Process is not available on all supported versions of Windows.
    //Use GetModuleHandle to get a handle to the DLL that contains the function
    //and GetProcAddress to get a pointer to the function if available.

    fnIsWow64Process = (LPFN_ISWOW64PROCESS) GetProcAddress( GetModuleHandle(TEXT("kernel32")),"IsWow64Process");

    /* determine if API is present. If not, we can can say this is not a 64 bit os */
    if(NULL != fnIsWow64Process)
    {
        if (!fnIsWow64Process(GetCurrentProcess(),&bIsWow64))
        {
		  /* handle error, can ignore */
            return bIsWow64 = FALSE;
        }
    }
    /* if true, we have a 64 bit OS, now we need to determine if the process is 64 bit */
    if ( bIsWow64 )
    {
	    if (!fnIsWow64Process( hProc ,&bIsWow64))
		{
		  /* handle error, can ignore */
            return bIsWow64 = FALSE;
		}
	    if (bIsWow64 == TRUE)
		    return FALSE;
	    else
		    return TRUE;
    }
    else 
	    return FALSE;

}

/******************************************************************************
* This function gets the PID and Process Path for a set of process names. It 
* is called in Main() under the use case -c (common).
******************************************************************************/
PSLIST* GetProcessList( )
{
	HANDLE hProcessSnap;
	PROCESSENTRY32 pe32;
	int i;
	int psNameSize = 0;
	char psName[][20] = { "firefox.exe", "iexplore.exe", "chrome.exe", "explorer.exe"};
	PSLIST* head, *curr; 
	head = NULL; 
	
	psNameSize = sizeof(psName)/sizeof(psName[0]);
	// Take a snapshot of all processes in the system.
	hProcessSnap = CreateToolhelp32Snapshot( TH32CS_SNAPPROCESS, 0 );
	if( hProcessSnap == INVALID_HANDLE_VALUE )
	{
		printf("CreateToolhelp32Snapshot (of processes)");
		return( NULL );
	}

	// Set the size of the structure before using it.
	pe32.dwSize = sizeof( PROCESSENTRY32 );

	// Retrieve information about the first process,
	// and exit if unsuccessful
	if( !Process32First( hProcessSnap, &pe32 ) )
	{
		printf("Process32First Failed"); // show cause of failure
		CloseHandle( hProcessSnap );          // clean the snapshot object
		return( NULL );
	}

	// Now walk the snapshot of processes, and
	// display information about each process in turn
	do
	{
		// loop through the process name list 
		for ( i = 0; i < psNameSize ; i++)
		{
			if( _stricmp(psName[i], pe32.szExeFile ) == 0)
			{
				curr = (PSLIST *) malloc ( sizeof ( PSLIST ) );
				curr->pid = pe32.th32ProcessID;
				strcpy( curr->psname, pe32.szExeFile );
				curr->next  = head;
				head = curr;
			}
		}

	} while( Process32Next( hProcessSnap, &pe32 ) );
	curr = head;

	CloseHandle( hProcessSnap );
	return( curr );
}

/******************************************************************************
* Opens up a process by it's PID and returns a handle. 
******************************************************************************/
PROCESS_INFORMATION openPid( int pid )
{
	PROCESS_INFORMATION pi;
	if ( pid )
		pi.hProcess = OpenProcess( PROCESS_ALL_ACCESS| PROCESS_VM_READ, FALSE, pid );
	else
	{
		printf(" ERROR: Could not get Process PID\n");
		return pi;
	}
	if ( pi.hProcess )
		return pi;
	else
	{
		printf(" ERROR: Could not get open PID %i\n", pid);
		return pi;
	}
}

/******************************************************************************
* Spawns a process of IE and returns a handle
******************************************************************************/
PROCESS_INFORMATION openIE( void )
{
	char path[MAX_PATH];
	STARTUPINFO si;
	PROCESS_INFORMATION pi;
	ZeroMemory(&si, sizeof(si));
	si.cb = sizeof(si);
	/* Create dummy IE process */
	strcpy( path, getIePath() );
	if(!CreateProcessA(path , NULL, NULL, NULL, FALSE, DEBUG_PROCESS, NULL, NULL, &si, &pi))
	{
		printf("\n Sorry! Broke on CreateProcess()\n\n");
		return pi;
	}
	else
	{
		printf("\n Dummy Process Started with PID %i\n", pi.dwProcessId);
		return pi;
	}
}


/*********************** START ***********************
*	The below functions are related to reading the 
*    registry, enum modules and dumping modules 
/*********************** START ***********************/

/******************************************************************************
* This function creates a PSDLLS struct. This is used to store dll paths that 
* are grabbed from the registry. 
******************************************************************************/
PSDLLS* psListCreate( HANDLE _hProc, const char path[], const int addr, const int _size )
{
	PSDLLS *ps = malloc(sizeof(PSDLLS));
	
	if(ps)
	{
		ps->hProc = _hProc;
		strncpy(ps->filePath, path, MAX_PATH-1);
		ps->address = addr;
		ps->size  = _size;
		ps->next = NULL;
		return ps;
	}
	return NULL;
}

/******************************************************************************
* This function reads the registry to get the path of of AppInit_DLLs. Returns
* a char array. Due to the use of static this fucnction is/should not be
* called twice.
******************************************************************************/
PSDLLS * GetAppInitDlls( PSDLLS *ps_list )
{
	PSDLLS *psTemp = NULL;
	char lszValue[MAX_PATH];
	char temp[MAX_PATH];
	char *result;
	HKEY hKey;
	LONG returnStatus;
	DWORD dwType = REG_SZ;
	DWORD dwSize = MAX_PATH;
	char *delim = " ,";
	int dllCount = 0;

	returnStatus = RegOpenKeyEx(HKEY_LOCAL_MACHINE, TEXT("SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Windows"), 0L, KEY_READ, &hKey);
	if (returnStatus == ERROR_SUCCESS)
	{
		returnStatus = RegQueryValueEx(hKey, "AppInit_DLLs", NULL, &dwType, (LPBYTE)&lszValue, &dwSize);
		if (returnStatus == ERROR_SUCCESS && strlen(lszValue))
		{
			printf(" Registry AppInit_DLLs File Path(s) %s\n", lszValue);
			/* verify that the value contains a path with a .dll */
			if (strstr(lszValue, ".dll") || strstr(lszValue, ".DLL"))
			{	
				if ( ( strstr(lszValue, ",") == NULL )  &&  ( strstr(lszValue, " ") == NULL ) )
				{
					psTemp = psListCreate(NULL, lszValue, 0, 0);
					if(psTemp)
					{
						psTemp->next = ps_list;
						ps_list = psTemp;
						RegCloseKey(hKey);
						return ps_list;
					}
				}
				else
				{
					result = strtok(lszValue, delim);
					while (result != NULL)
					{
						strncpy(temp, result, MAX_PATH - 1);
						temp[MAX_PATH - 1] = '\0';
						psTemp = psListCreate(NULL, temp, 0, 0xdead);
						if(psTemp)
						{
							psTemp->next = ps_list;
							ps_list = psTemp;
						}
						result = strtok(NULL, delim);
					}
					RegCloseKey(hKey);
					return ps_list;
				}
			}
			else
				printf(" NOTE: .DLL extensions were not found in AppInit_DLLs\n");
		}
		else
			if(strlen(lszValue) != 0 )
				printf(" ERROR: Could not read AppInit_DLLs Values\n");
	}
	else
		printf(" ERROR: Could not locate AppInit_DLLs Key\n");
	RegCloseKey(hKey);
	return ps_list;
}



/******************************************************************************
* This function reads the registry to get the path of of APPCERTDLLs. Returns
* a char array.
******************************************************************************/
PSDLLS * GetAppCertDlls( PSDLLS *ps_list )
{
	PSDLLS *psTemp = NULL; 
	char achValue[MAX_KEY_LENGTH];
	char lszValue[MAX_PATH]; 
	DWORD cbName;
	HKEY hKey;
	LONG returnStatus;
	DWORD dwType = REG_SZ;
	DWORD dwSize = MAX_PATH;
	DWORD NumVals;
	size_t i;
	int dllCount = 0;

	returnStatus = RegOpenKeyEx(HKEY_LOCAL_MACHINE, TEXT("System\\CurrentControlSet\\Control\\Session Manager\\AppCertDlls"), 0L, KEY_READ, &hKey);
	if (returnStatus == ERROR_SUCCESS)
	{
		RegQueryInfoKey(hKey,NULL,NULL,NULL,NULL,NULL,NULL,&NumVals,NULL,NULL,NULL,NULL); // Get the value count... nom nom nom
		if(NumVals)
		{
			for (i=0; i<NumVals; i++) //for each value in the key appcertdlls
			{
				cbName = MAX_KEY_LENGTH;
				returnStatus = RegEnumValue(hKey,i, achValue, &cbName, NULL, NULL, NULL, NULL ); // get the value name
				if (returnStatus == ERROR_SUCCESS)
				{
					returnStatus = RegQueryValueEx(hKey, achValue , NULL, &dwType,  (LPBYTE)&lszValue, &dwSize); // read the data of the value
					if (strlen(lszValue))
					{
						printf(" Registry APPCERTDLL File Path %s\n", lszValue);
						if (strstr(lszValue, ".dll")) //verify that the value contains a path with a .dll
						{
							psTemp = psListCreate(NULL, lszValue, 0, 0xbeef );
							if(psTemp)
							{
								psTemp->next = ps_list;
								ps_list = psTemp;
							}
						}
					}
				}
			}
		}
	}
	RegCloseKey(hKey);
	return ps_list;
}

/******************************************************************************
* This function prints all the loaded modules in a process id (PID)
******************************************************************************/
PSDLLS * PrintModules( HANDLE hProcess )
{
	HMODULE hMods[1024];
	DWORD cbNeeded;
	unsigned int i;
	unsigned int sizeOfDll = 0;
	PSDLLS * lDlls = NULL;
	PSDLLS * dllTemp = NULL;
	MODULEINFO  dllInfo;
	MEMORY_BASIC_INFORMATION meminfo;

	// Get a list of all the modules in this process.
	if( EnumProcessModules(hProcess, hMods, sizeof(hMods), &cbNeeded))
	{
		for (i = 0; i < (cbNeeded / sizeof(HMODULE)); i++)
		{
			char szModName[MAX_PATH];
			// Get the full path to the module's file.
			if ( GetModuleFileNameEx(hProcess, hMods[i], szModName, sizeof(szModName)))
			{
				if( GetModuleInformation( hProcess, hMods[i], &dllInfo, sizeof(dllInfo) ) );
				{
					if( VirtualQueryEx( hProcess, hMods[i], &meminfo, sizeof(meminfo) ) )
					{
						/* Values are populated because we will use these to dump the process */
						dllTemp = psListCreate(hProcess, szModName, meminfo.AllocationBase, dllInfo.SizeOfImage);
						if( dllTemp )	
						{
							dllTemp->next = lDlls;
							lDlls = dllTemp;
						}
					}
					else
						printf(" Error on VirtualQueryEx\n");
				}
			}
		}
	}
	// Release the handle to the process.
	//CloseHandle(hProcess);
	return lDlls;
}

/******************************************************************************
* This function is for dumping a dll found via a registry key.  
******************************************************************************/
void dump_dlls ( PSDLLS *ps_list, long int pid)
{
	PSDLLS *ps = ps_list;
	/* allocate memory for our buffer that will be received from ReadProcessMemory */
	char *buffer = (char*) malloc(ps->size);
	FILE *fp;
	char dllFileName[MAX_PATH] = "";
	char fileName[MAX_PATH] = "";
	/* get the file name from the file path*/
	char *temp = strrchr ( ps->filePath, '\\' );
	/* remove the extra '\' character from the filename */
	strcpy(dllFileName, temp+1);
	/* create our output file name */
	sprintf( fileName, "%i.%s", pid, dllFileName );
	printf (" Suspicious Injected DLL Via Registry Key:\n Addr: 0x%08x Size:%d\r\n", ps->address, ps->size);
	if (watch == FALSE)
	{
		if (ReadProcessMemory(ps->hProc,(void*)ps->address, buffer, ps->size, NULL) != 0)
		{
			fp=fopen(fileName, "wb");
			printf (" Dumping Memory at 0x%08x to %s\n", ps->address, fileName );
			fwrite(buffer,1, ps->size, fp);
			fclose(fp);
		}
		else
			printf(" Error Could Not Dump Memory");
	}
	free(buffer);
}

/******************************************************************************
* Reads registry keys for injected DLLs, returns the file names, scans loaded
* modules for the dlls and then dumps them to a file. TO DO. Returns a list of the 
* dumped memory regions. 
******************************************************************************/
PSDLLS * scanDumpModues( PROCESS_INFORMATION pInfo, int pid )
{
	PSDLLS *dllPaths = NULL;
	PSDLLS *loadedDlls = NULL;
	PSDLLS *headDlls = NULL;
	DWORD aProcesses[1024];
	DWORD cbNeeded;
	DWORD cProcesses;

	/* Get the path of dll loaded via AppInit_Dll key */
	dllPaths = GetAppInitDlls(dllPaths);
	/* Get the path of dlls loaded via AppCertDll key */
	dllPaths = GetAppCertDlls(dllPaths);
	// Get the list of process identifiers.	
	if (!EnumProcesses( aProcesses, sizeof(aProcesses), &cbNeeded ) )
		return 0;
	// Calculate how many process identifiers were returned.
	cProcesses = cbNeeded / sizeof(DWORD);
	loadedDlls = PrintModules( pInfo.hProcess );	
	headDlls = dllPaths;
	while(loadedDlls)
	{
		while(dllPaths)
		{
			if( strcmp( dllPaths->filePath, loadedDlls->filePath ) == 0 )
			{
				dump_dlls ( loadedDlls, pid);
			}
			dllPaths = dllPaths->next;
		}
		dllPaths = headDlls;
		loadedDlls = loadedDlls->next; 	 	
	}
	return NULL;
}
 
/*********************** END ***********************
*	The above functions are related to reading the 
*    registry, enum modules and dumping modules 
/*********************** END ***********************/


/*********************** START ***********************
*	The below functions are related to creating the 
	dummpy IE process. 
/*********************** START ***********************/

/******************************************************************************
* This function reads the registry to get the path of iexplore.exe
******************************************************************************/
char * getIePath()
{
	// example of reading registry http://www.codersource.net/Win32/Win32Registry/RegistryOperationsusingWin32.aspx
	char lszValue[MAX_PATH];
	char *newValue = lszValue + 1;
	char *strkey;
	char path[MAX_PATH];
	HKEY hKey;
	LONG returnStatus;
	DWORD dwType = REG_SZ;
	DWORD dwSize = MAX_PATH;
	returnStatus = RegOpenKeyEx(HKEY_CLASSES_ROOT,TEXT("applications\\iexplore.exe\\shell\\open\\command"), 0L, KEY_READ, &hKey);
	if (returnStatus ==  ERROR_SUCCESS)
	{
		returnStatus = RegQueryValueExA(hKey, NULL, NULL, &dwType, (LPBYTE)&lszValue, &dwSize);
		if(returnStatus == ERROR_SUCCESS)
		{
			RegCloseKey(hKey);
			if( ( strkey=strstr(lszValue, "%1" ) ) !=NULL)
				*(strkey=strkey-2)='\0';
			printf("\niexplorer.exe path is %s", newValue);
			// newValue was the easiest way I could find to remove the first char. I miss python
			return newValue;
		}
		else
		{
			printf("ERROR: Registry IE Path not Found");
		}
	}
	else 
	{
		printf("ERROR: Registry IE Path not Found");
	}
	RegCloseKey(hKey);
	return NULL;
}

/*********************** END ***********************
*	The above functions are related to creating the 
	dummpy IE process. 
/*********************** END ***********************/

/*********************** START ***********************
*	The below functions are related to creating or 
*	modifying linked list used. 
/*********************** START ***********************/

/******************************************************************************
* This function creates a memory block struct 
******************************************************************************/
MEMBLOCK* create_memblock (HANDLE hProc,  MEMORY_BASIC_INFORMATION *meminfo)
{
	// used to create the membloc
	MEMBLOCK *mb = malloc(sizeof(MEMBLOCK));

	if (mb)
	{
		mb->hProc = hProc;
		mb->addr = meminfo->BaseAddress;
		mb->size = meminfo->RegionSize;
		mb->buffer = malloc(meminfo->RegionSize);
		mb->next = NULL;

	}
	return mb;
}

/******************************************************************************
* This function creates a free memory block struct 
******************************************************************************/
void free_memblock (MEMBLOCK *mb)
{
	if (mb)
	{
		if (mb->buffer)
		{
			free (mb->buffer);
		}
		free (mb);
	}
}

/******************************************************************************
* This reverse the linked list 
******************************************************************************/
MEMBLOCK * reverseList (MEMBLOCK *mb)
{
	MEMBLOCK* prev = NULL;
	MEMBLOCK* current = mb;
	MEMBLOCK* next;
	while (current != NULL)
	{
		next = current->next;
		current->next = prev;
		prev = current;
		current = next;
	}
	mb = prev;
	return mb;
}

/******************************************************************************
* This function cleans up a memory block 
******************************************************************************/
void free_scan (MEMBLOCK *mb_list)
{
	CloseHandle(mb_list->hProc);
	while ( mb_list) 
	{
		MEMBLOCK *mb = mb_list;
		mb_list = mb_list->next;
		free_memblock (mb);
	}   

}

/*********************** END ***********************
*	The above functions are related to creating or 
*	modifying linked list used. 
/*********************** END ***********************/


/*********************** START ***********************
*	The below functions are related to reading the 
*    memory of private memory and dumping it 
/*********************** START ***********************/

/******************************************************************************
* This function is for dumping a block of memory marked as private. Due to the 
* custom size a previously defined struct would not work. Might revisit. 
******************************************************************************/
void dumpPrivMem ( MEMBLOCK * peB, char * addr, int size , int pid)
{
	char *buffer = (char*) malloc(size);
	FILE *fp;
	BOOL open = FALSE;
	char filename[MAX_PATH];
	/* formats and prints information about what is being dumped */
	sprintf(filename, "%i.0x%08x.bin", pid, addr);
	printf (" Suspicious Private MZ Memory Block:\n Addr: 0x%08x Size:%d\r\n", addr, size);
	/* reverses the linked list order */
	peB = reverseList( peB );
	while ( peB )
	{
		char *buffer = (char*) malloc(peB->size);
		if ( watch == FALSE )
		{
			if ( ReadProcessMemory( peB->hProc, (void*)peB->addr, buffer, peB->size, NULL) != 0 )
			{
				if ( open == FALSE)
				{
					fp=fopen(filename, "wb");
					open = TRUE;
				}
				printf (" Dumping Memory at 0x%08x to %s\n", peB->addr, filename );
				fwrite(buffer,1, peB->size, fp);
			}
			else
				printf(" Error Could Not Dump Memory");
		}
		/* free our buffer */
		free(buffer);
		peB = peB->next;
	}
	/* clean up and free the memory */
	while ( peB )
	{
		free_memblock( peB );
		peB = peB->next;
	}
	/* close our file handle */
	if ( open == TRUE )
		fclose(fp);

	return;
}

/******************************************************************************
* This function scans the memory for memory marked as private, size of 4096,
* and contains an MZ header. If found it will calculate the size of the 
* executable in memory by searching the distance to the next memory marked as
* free. Once found it will dump the memory and the reset the size to 0. This 
* ensures multiple files in memory can be found. 
******************************************************************************/
PSDLLS * scanDumpPrivMem( PROCESS_INFORMATION pInfo, int pid )
{
	/*
	REWRITE - Can this be rewritten to save the memory address and size to a structure that will be 
	used for dumping and/or printing the found memory.

	*/ 
	MEMORY_BASIC_INFORMATION meminfo;
	unsigned char *addr = 0, *base = 0;
	char *buffer = NULL;
	STARTUPINFO si;
	MEMBLOCK *peBlock = NULL;
	char *header = "MZ";
	unsigned int size = 0;
	ZeroMemory(&si, sizeof(si));	
	si.cb = sizeof(si);

	while( 1 )
	{
		if (VirtualQueryEx( pInfo.hProcess, addr, &meminfo, sizeof(meminfo)) == 0)
		{ // query addresses, reads all meomory including non-commited  
			break;
		}
		if (size == 0 )
		{
			if ( ( meminfo.Type & MEM_PRIVATE ) && ( meminfo.RegionSize == 4096  ) ) 
			{
				buffer = (char*) malloc(meminfo.RegionSize);
				if ( ReadProcessMemory( pInfo.hProcess , meminfo.BaseAddress, buffer, meminfo.RegionSize, NULL) ) 
				{
					/* checking the first two bytes for the MZ header */
					if (strncmp( buffer, header, 2 ) == 0 ) 
					{
						MEMBLOCK *peBlock = create_memblock (pInfo.hProcess, &meminfo);
						size = meminfo.RegionSize;
						base = ( unsigned char*)meminfo.AllocationBase;
					}
				}
				free(buffer);
			}
		}

		if (size != 0)  
		{
			/* if memory is free we no longer need to keep track of the size. Assume end of the process size */
			if ( meminfo.State & MEM_FREE )	
			{
				/* Need to return address to dump */
				dumpPrivMem(peBlock, base, size, pid );
				size = 0;
				base = 0;
			}
			/* Update Size of memory */
			else
			{
				MEMBLOCK *mb = create_memblock (pInfo.hProcess, &meminfo);
				if (mb)
				{ 
					mb->next = peBlock;
					peBlock = mb;
				}
				size = size +  meminfo.RegionSize;
			}
		}
		if ( ( meminfo.RegionSize  == -1 )  )
		{
			return NULL;
		}
		addr = ( signed char*)meminfo.BaseAddress + meminfo.RegionSize;
	}
	return NULL;
}

/*********************** END ***********************
*	The above functions are related to reading the 
*    memory of private memory and dumping it 
/*********************** END ***********************/

/*********************** START ***********************
*	The below functions are related to dumping memory 
	marked as RWX.
/*********************** START ***********************/
/******************************************************************************
* This function dumps the memory block to a file. The file name will be 
* formatted as Pid.0xAddress.bin in the working directory
******************************************************************************/
void dump_scan_info ( MEMBLOCK *mb_list , int pid)
{
	MEMBLOCK  *mb = mb_list;
	srand(time(NULL));

	while (mb)
	{
		char *buffer = (char*) malloc(mb->size);
		FILE *fp;
		int random;
		char filename[MAX_PATH];
		sprintf(filename, "%i.0x%08x.bin", pid, mb->addr);
		printf (" Suspicious Memory Block:\n Addr: 0x%08x Size:%d\r\n", mb->addr, mb->size);
		if ( watch == FALSE )
		{
			if (ReadProcessMemory(mb->hProc,(void*)mb->addr, buffer, mb->size, NULL) != 0)
			{
				/* check if file exists */
				if ( fp=fopen(filename, "r") )
				{
					fclose(fp);
					random = rand();
					printf(" Note: %s exists, RWX dump in ",filename);
					sprintf(filename, "%i.0x%08x.%03i.bin", pid, mb->addr, random);
					printf("%s\n", filename);
				}
				fp=fopen(filename, "wb");
				printf (" Dumping Memory at 0x%08x to %s\n", mb->addr, filename );
				fwrite(buffer,1, mb->size, fp);
				fclose(fp);
			}
			else
				printf(" Error Could Not Dump Memory");
		}
		free(buffer);
		mb = mb->next;
	}
}

/******************************************************************************
* This function scans a PID for memory that is marked as RWX. If the PID is 
* zero a dummy process of iexplore.exe is opened using CreateProcess  
******************************************************************************/
MEMBLOCK*  create_scan ( PROCESS_INFORMATION psInfo, int pid )
{
	MEMBLOCK *mb_list = NULL;
	MEMORY_BASIC_INFORMATION meminfo;
	void* addr = 0;
	STARTUPINFO si;
	ZeroMemory(&si, sizeof(si));
	si.cb = sizeof(si);
	
	if (psInfo.hProcess)
	{
		while (1)
		{
			// if 0 we have reached the end of readable memory. 
			if (VirtualQueryEx( psInfo.hProcess, addr, &meminfo, sizeof(meminfo)) == 0)
			{ // query addresses, reads all meomory including non-commited  
				break;
			}
			if ( meminfo.RegionSize  == -1)
				break;
			// if memory is marked as RWX
			if (meminfo.Protect & PAGE_EXECUTE_READWRITE)
			{
				MEMBLOCK *mb = create_memblock (psInfo.hProcess, &meminfo);
				if (mb)
				{ 
					mb->next = mb_list;
					mb_list = mb;
				}
			}
			addr = ( unsigned char*)meminfo.BaseAddress + meminfo.RegionSize;
		}
	}
	return mb_list;
}

/******************************************************************************
* This function calls all the needed functions for dumping out memory that has
* RWX rights. 
******************************************************************************/
PSDLLS * scanRWX(  PROCESS_INFORMATION psInfo, int pid )
{
	MEMBLOCK *scan = create_scan(psInfo, pid) ;
	if (scan)
	{
		dump_scan_info (scan, pid);
		free_scan (scan);
	}
	return NULL;
}

/*********************** END ***********************
*	The above functions are related to dumping memory 
	marked as RWX.
/*********************** END ***********************/

/******************************************************************************
* This function contains is parent function for all the functions that get 
* called to scan a process. The first step is to read the registry for 
* registry keys that are commonly used to inject dlls, the second is to search
* for executables that are in private memory, the third is to dump all memory
* that is marked as RWX. It takes one argument a PID. If the argument is empty
* it means a dummy process of IE will be spawned.
******************************************************************************/
void scanProcess(int pid )
{
	PROCESS_INFORMATION psInfo;
	PSDLLS *dumped = NULL;
	/* verifies the PID is valid and a handle to it can be opened */
	if ( pid == 0 )
	{
		psInfo = openIE();
		pid = psInfo.dwProcessId;
	}
	else
		psInfo = openPid(pid);

	/* openPid returns 0 if the handle could not be found */
	if (psInfo.dwProcessId)
	{
		/* isWow64 returns a TRUE if 64 bit process */
		if ( isWow64 ( psInfo.hProcess ) )
		{
			printf(" NOTE: pid %i is a 64 bit process, skipping\n", pid);
		}
		else
		{
			scanDumpModues(psInfo, pid);  
			scanDumpPrivMem(psInfo, pid );
			scanRWX(psInfo, pid );
		}
	}
	CloseHandle(psInfo.hProcess);
}

/******************************************************************************
* Main() - Main, Main, Parse Arguments, Magic....
******************************************************************************/
int main( int argc, char *argv[] )
{
	/* save off arguments */
	int argctmp = argc;
	char **argvtmp = argv;
	char temp[12];
	/* used for storing the PIDS */
	PSLIST *scannedps;
	int pid = 0;
	/* verify that an argument has been passed */
	if ( argc == 1 )
	{
		printf(" ERROR: Incorrect Arguments. Please try \"injd -h\" for help\n");
		return 0;
	}
	/* Adjust process token */
	if ( !EnableTokenPrivilege (SE_DEBUG_NAME) )
	{
		printf(" EnableTokenPrivilege failed, run with Admin rights.");
		return 0;
	}
	/* Loop through all the arugments and return if non-valid */
	while (( argc >1) && (argv[1][0] == '-' ))
	{
		switch ( argv[1][1] )
		{
			/* use case: help */
			case 'h':
				break;
			/* use case: scan PID */
			case 'p':
				strcpy(temp,&argv[1][2]);
				pid = (int) strtol(temp, NULL, 10 );
				if ( pid == 0)
				{
					printf(" ERROR: Invalid Integer for PID. Reminder no spaces between -p and PID.\n");
					return 0;
				}
				break;
			case 's':
				watch = TRUE;
				break;	
			/* use case: scan dummy process */
			case 'd':
				break;
			/* use case: run all scans, dummp, commonly injected processes */
			case 'a':
				break;
			/* use case: scan only common injected processes */
			case 'c':
				break;
			/* use case: incorrect argument */
			default:
				printf(" ERROR: Incorrect Arguments. Please try -h for help\n");
				return 0;
		}
		++argv;
		--argc;
	}
	argc = argctmp;
	argv = argvtmp;
	/* Loop through all the arugments again and call the needed functions. Yes, the use of duplicating code is bad
	   but this is actually a very simple method to remove bad entries and being able to use multiple arguments*/
	while (( argc >1) && (argv[1][0] == '-' ))
	{
		switch ( argv[1][1] )
		{
			/* use case: help */
			case 'h':
				usage();
				printf("\nNotes:\n");
				notes();
				break;
			/* use case: scan PID */
			case 'p':
				scanProcess( pid );
				break;
			case 's':
				watch = TRUE;
				break;	
			/* use case: scan dummy process */
			case 'd':
				scanProcess(0);
				break;
			/* use case: run all scans, dummp, commonly injected processes */
			case 'a':
				scannedps = GetProcessList( );
				while( scannedps ){
					printf( " Scanning Process %s with PID %i\n", scannedps->psname, scannedps->pid );
					scanProcess( scannedps->pid );
					scannedps = scannedps->next ;
				}
				scanProcess(0);
				break;
			/* use case: scan only common injected processes */
			case 'c':
				scannedps = GetProcessList( );
				while( scannedps ){
					printf( " Scanning Process %s with PID %i\n", scannedps->psname, scannedps->pid );
					scanProcess( scannedps->pid );
					scannedps = scannedps->next ;
				}
				break;
			/* use case: incorrect argument */
			default:
				return 0;
		}
		++argv;
		--argc;
	} // END of arguments Loop 
	

	return 0;
}
