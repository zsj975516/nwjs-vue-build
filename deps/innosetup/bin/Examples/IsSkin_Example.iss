; �ű��� Inno Setup �ű��� ���ɣ�
; �йش��� Inno Setup �ű��ļ�����ϸ��������İ����ĵ���

[Setup]
AppName=ISSkin ʾ��
AppVerName=ISSkin ʾ�� v1.0
AppVersion=1.0.0.3
AppCopyright=?1998-2008 Codejock Software
DefaultDirName={pf}\ISSkin
DefaultGroupName=ISSkin
Compression=lzma
SolidCompression=true
WizardImageFile=compiler:Office2007.bmp
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp
UninstallDisplayIcon={app}\SkinHelper.exe
OutputDir=userdocs:Inno Setup Examples Output
OutputBaseFilename=SetupOffice2007
VersionInfoVersion=1.0.0.3
VersionInfoCompany=Codejock Software
VersionInfoDescription=ISSkin Example Setup
VersionInfoTextVersion=1, 0, 0, 3

[Files]
; Add the ISSkin DLL used for skinning Inno Setup installations.
Source: compiler:ISSkin.dll; DestDir: {app}; Flags: dontcopy

; Add the Visual Style resource contains resources used for skinning,
; you can also use Microsoft Visual Styles (*.msstyles) resources.
Source: compiler:IsSkins\Office2007.cjstyles; DestDir: {tmp}; Flags: dontcopy

[Icons]
Name: {group}\Uninstall =ISSkin; Filename: {app}\unins000.exe

; The following code block is used to load the ISS, pass in
; an empty string ('') as the second parameter to LoadSkin to use
; the Blue color scheme, this is the default color scheme for
; Office2007.cjstyles.
[Code]
// Importing LoadSkin API from ISSkin.DLL
procedure LoadSkin(lpszPath: AnsiString; lpszIniFileName: AnsiString);
external 'LoadSkin@files:isskin.dll stdcall';

// Importing UnloadSkin API from ISSkin.DLL
procedure UnloadSkin();
external 'UnloadSkin@files:isskin.dll stdcall';

// Importing ShowWindow Windows API from User32.DLL
function ShowWindow(hWnd: Integer; uType: Integer): Integer;
external 'ShowWindow@user32.dll stdcall';

function InitializeSetup(): Boolean;
begin
	ExtractTemporaryFile('Office2007.cjstyles');
	LoadSkin(AnsiString(ExpandConstant('{tmp}\Office2007.cjstyles')), '');
	Result := True;
end;

procedure DeinitializeSetup();
begin
	// Hide Window before unloading skin so user does not get
	// a glimse of an unskinned window before it is closed.
	ShowWindow(StrToInt(ExpandConstant('{wizardhwnd}')), 0);
	UnloadSkin();
end;
