module slim.rt.winmain2;

import win32.windows;

private:
__gshared:
extern(C) bool[0] _acrtused;

void start()
{
	extern (Windows)
	static int WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow);

	HINSTANCE hInstance = GetModuleHandle(null); // TODO: this won't work for DLLs

	LPSTR szCmdLine = GetCommandLine();
	if (*szCmdLine == '"')
	{
		while (*szCmdLine != '"')
			szCmdLine++;
	}
	else
	{
		while (*szCmdLine != '"')
			szCmdLine++;
	}
	while (*szCmdLine == ' ')
		szCmdLine++;

	STARTUPINFO si = {STARTUPINFO.sizeof};
	GetStartupInfo(&si);

	int ret = WinMain(hInstance, HINSTANCE.init, szCmdLine, (si.dwFlags & STARTF_USESHOWWINDOW) ? si.wShowWindow : SW_SHOWDEFAULT);
	ExitProcess(ret);
}

pragma(startaddress, start);
