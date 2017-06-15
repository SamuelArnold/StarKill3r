#include <Windows.h>
#include <stdio.h>
#include "detours.h"

static void print_help()
{
	printf("Usage: ProcessInjectionMonitorLauncher.exe target_to_monitor.exe\n");
	exit(1);
}

static void print_error(char *error)
{
	printf("Error: %s\n", error);
	exit(1);
}

int main(int argc, char *argv[])
{
	char fullPathName[MAX_PATH];
	STARTUPINFO si;
	PROCESS_INFORMATION pi;
	BOOL success;

	if (argc != 2) print_help();

	if (GetFullPathName(argv[1], MAX_PATH, fullPathName, NULL) == 0) print_error("invalid path");

	ZeroMemory(&si, sizeof(STARTUPINFO));
	ZeroMemory(&pi, sizeof(PROCESS_INFORMATION));
	si.cb = sizeof(STARTUPINFO);
	success = DetourCreateProcessWithDll(NULL, fullPathName, NULL, NULL, FALSE, CREATE_DEFAULT_ERROR_MODE, NULL, NULL, &si, &pi, "ProcessInjectionMonitor.dll", NULL);
	if (!success) {
		printf("Cannot create the new process, error is %d\n", GetLastError());
	}

	ResumeThread(pi.hThread);

	WaitForSingleObject(pi.hProcess, INFINITE);

	return 0;
}