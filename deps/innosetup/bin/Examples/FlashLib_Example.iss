; �ű��� Inno Setup �ű��� ���ɣ�
; �йش��� Inno Setup �ű��ļ�����ϸ��������İ����ĵ���

#include "compiler:FlashLib.iss"
[Setup]
; ע: AppId��ֵΪ������ʶ��Ӧ�ó���
; ��ҪΪ������װ����ʹ����ͬ��AppIdֵ��
; (�����µ�GUID����� ����|��IDE������GUID��)
AppId={{07A9667A-62FA-4EE1-BA80-DE7B0AC3C12E}
AppName=�ҵĳ���
AppVerName=�ҵĳ��� 1.5
AppPublisher=�ҵĹ�˾
AppPublisherURL=http://www.example.com/
AppSupportURL=http://www.example.com/
AppUpdatesURL=http://www.example.com/
DefaultDirName={pf}\�ҵĳ���
DefaultGroupName=�ҵĳ���
OutputDir=userdocs:Inno Setup Examples Output
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes

[Files]
; ע��: ��Ҫ���κι���ϵͳ�ļ���ʹ�á�Flags: ignoreversion��
Source: compiler:FlashLib.swf; DestDir: {tmp}; Flags: noencryption nocompression

[Icons]
Name: {group}\{cm:UninstallProgram, �ҵĳ���}; Filename: {uninstallexe}

[Code]
var
  FlashHwnd: HWND;

procedure InitializeWizard();
var
  F: String;
begin
  ExtractTemporaryFile('FlashLib.swf');
  F:= ExpandConstant('{tmp}\FlashLib.swf');
  FlashHwnd := FlashLibInit(WizardForm.WizardBitmapImage.Left,
   WizardForm.WizardBitmapImage.Top, WizardForm.WizardBitmapImage.Width,
   WizardForm.WizardBitmapImage.Height,WizardForm.WelcomePage.Handle,
    WizardForm.WizardBitmapImage.Bitmap.Handle,True);
  FlashLoadMovie(FlashHwnd, AnsiString(F));
end;

procedure DeinitializeSetup();
begin
  FlashLibFree(FlashHwnd);
end;
