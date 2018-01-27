[Files]
Source: compiler:FlashLib.dll; DestDir: {tmp}; Flags: noencryption nocompression

[Code]
//hWndParent����FLASH�������Ǹ������
//BmpTransparenthWnd ��FLASH��һ��ͼ����ʱ������Ҫ͸������ͼ�񣬾�Ҫָ����ͼ��ľ����
//			���Ҹ�FLASH��X, Y, nWidth, nHeightһ��Ҫ��ͼ���һ�£��粻��ͼ���ϣ�������Ϊ0
//Transparent���Ƿ�͸��
Function FlashLibInit(X, Y, nWidth, nHeight: Integer; hWndParent, BmpTransparenthWnd: HWND; Transparent: BOOL): HWND;
External 'FlashLibInit@files:FlashLib.dll Stdcall';

//�˳�ʱһ��Ҫִ�и�API������ᱨ��
Procedure FlashLibFree(H: HWND);
External 'FlashLibFree@files:FlashLib.dll Stdcall';

//֧��SWF��FLV
Function FlashLoadMovie(HWND: HWND; Path: AnsiString): Boolean;
External 'FlashLoadMovie@files:FlashLib.dll Stdcall';

Function FlashPlay(HWND: HWND): Boolean;
External 'FlashPlay@files:FlashLib.dll Stdcall';

Function FlashStop(HWND: HWND): Boolean;
External 'FlashStop@files:FlashLib.dll Stdcall';

Function FlashStopPlay(HWND: HWND): Boolean;
External 'FlashStopPlay@files:FlashLib.dll Stdcall';

Function FlashPutLoop(HWND: HWND; Loop: BOOL): Boolean;
External 'FlashStop@files:FlashLib.dll Stdcall';

Function FlashPutMenu(HWND: HWND; Menu: BOOL): Boolean;
External 'FlashPutMenu@files:FlashLib.dll Stdcall';

Function FlashPutStandardMenu(HWND: HWND; bEnable: BOOL): Boolean;
External 'FlashPutStandardMenu@files:FlashLib.dll Stdcall';

Function FlashBack(HWND: HWND): Boolean;
External 'FlashBack@files:FlashLib.dll Stdcall';

Function FlashForward(HWND: HWND): Boolean;
External 'FlashForward@files:FlashLib.dll Stdcall';

Function FlashRewind(HWND: HWND): Boolean;
External 'FlashRewind@files:FlashLib.dll Stdcall';

Function FlashZoom(HWND: HWND; Factor: DWORD): Boolean;
External 'FlashZoom@files:FlashLib.dll Stdcall';

Function FlashGotoFrame(HWND: HWND; FrameNum: DWORD): Boolean;
External 'FlashGotoFrame@files:FlashLib.dll Stdcall';

Function FlashSetVariableA(HWND: HWND; Name, Value: AnsiString): Boolean;
External 'FlashSetVariableA@files:FlashLib.dll Stdcall';
