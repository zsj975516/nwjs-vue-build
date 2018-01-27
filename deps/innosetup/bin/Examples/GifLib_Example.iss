; �ű��� Inno Setup �ű��� ���ɣ�
; �йش��� Inno Setup �ű��ļ�����ϸ��������İ����ĵ���
#include "compiler:GifLib.iss"

[Setup]
; ע: AppId��ֵΪ������ʶ��Ӧ�ó���
; ��ҪΪ������װ����ʹ����ͬ��AppIdֵ��
; (�����µ�GUID����� ����|��IDE������GUID��)
AppId={{A18A3B64-E516-4299-A51A-5A48BF64E94D}
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

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: compiler:Examples\MyProg.exe; DestDir: {app}; Flags: ignoreversion

[Code]
var
  GifHandle:Integer;

procedure InitializeWizard();
begin
  GifHandle := GifInit(WizardForm.WelcomePage.Handle);
  GifSetBounds(GifHandle, WizardForm.WizardBitmapImage.Left, WizardForm.WizardBitmapImage.Top, WizardForm.WizardBitmapImage.Width ,WizardForm.WizardBitmapImage.Height);
  GifSetFile(GifHandle, '1139681544755.gif');
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  Case CurPageID of
    wpWelcome : GifSetParentWindow(GifHandle, WizardForm.WelcomePage.Handle);
    wpFinished: GifSetParentWindow(GifHandle, WizardForm.FinishedPage.Handle);
  end;
end;

procedure DeinitializeSetup();
begin
  GifAllFree;
end;
