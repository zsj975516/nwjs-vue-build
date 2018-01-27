; 脚本由 Inno Setup 脚本向导 生成！
; 有关创建 Inno Setup 脚本文件的详细资料请查阅帮助文档！

;英文名
#define EnglishName "$EnglishName$"
;中文名
#define MyAppName "$ChineaseName$"
;应用版本
#define MyAppVersion "$AppVersion$"
;文件版本
#define FileVersion "$FileVersion$"
;版权
#define Copyright "$Copyright$"
;发布者
#define MyAppPublisher "$Publisher$"
;应用链接
#define MyAppURL "$AppURL$"
;主exe名称
#define MyAppExeName "$AppExeName$.exe"
;应用ID，唯一
#define AppId "{$AppId$"
;安装文件的输出路径（文件夹）
#define OutputDir "$OutputDir$"
;主exe文件的全路径
#define MainExe "$MainExe$"
#define Files "$Files$"
#define OutputBaseFilename "$OutputBaseFilename$"
#define SetupIconFile "$SetupIconFile$"
#define LicenseFile "$LicenseFile$"

[Setup]
; 注: AppId的值为单独标识该应用程序。
; 不要为其他安装程序使用相同的AppId值。
; (生成新的GUID，点击 工具|在IDE中生成GUID。)
AppId={#AppId}
;程序名
AppName={#MyAppName}
;版本号
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
;发布者者
AppPublisher={#MyAppPublisher}
;相关连接
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
;默认安装目录
DefaultDirName={pf$Platform$}\{#EnglishName}
;安装协议
LicenseFile={#LicenseFile}
;安装前查看的文本文件
;InfoBeforeFile={#InfoBeforeFile}
;安装后查看文本文件
;InfoAfterFile={#InfoAfterFile}
;输出文件夹
OutputDir={#OutputDir}
;输出文件名
OutputBaseFilename={#OutputBaseFilename}
;安装图标
SetupIconFile={#SetupIconFile}
;安装需要输入密码
;Password=123
;Encryption=yes
;压缩相关
Compression=lzma
SolidCompression=yes
;可以让用户忽略选择语言相关
;ShowLanguageDialog = yes
PrivilegesRequired=admin
Uninstallable=yes
UninstallDisplayName={#MyAppName}
;默认开始菜单名
DefaultGroupName={#MyAppName}
;UninstallIconFile={#ResourcesPath}\logo.ico
;备注版本信息
Versioninfodescription={#MyAppName} 安装程序
versioninfocopyright={#Copyright}
VersionInfoProductName={#MyAppName}
VersionInfoVersion={#FileVersion}
VersionInfoCompany={#MyAppPublisher}

DisableReadyPage=yes
DisableProgramGroupPage=yes
DirExistsWarning=no
DisableDirPage=no
;是否打开->可选安装开始菜单项
AllowNoIcons=yes

;制作选择语言
[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Default.isl"

;用户定制任务
[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkedonce;
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkedonce;

;文件安装
[Files]
;Source: "{#ResourcesPath}\*"; DestDir: {tmp}; Flags: dontcopy solidbreak ; Attribs: hidden system
Source: "{#MainExe}"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#Files}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; 注意: 不要在任何共享系统文件上使用“Flags: ignoreversion”

;更改显示在程序中显示的消息文本
[Messages]
SetupAppTitle={#MyAppName} 安装向导
SetupWindowTitle={#MyAppName} 安装向导
;BeveledLabel=HKiss科技
;定义解压说明
;StatusExtractFiles=解压并复制主程序文件及相关库文件...
;卸载对话框说明
;ConfirmUninstall=您真的想要从电脑中卸载ISsample吗?%n%n按 [是] 则完全删除 %1 以及它的所有组件;%n按 [否]则让软件继续留在您的电脑上.

;开始菜单，桌面快捷方式
[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

;用来在程序安装完成后 在安装程序显示最终对话框之前执行程序 常用与运行主程序 显示自述文件 删除临时文件
[Run]
;安装过程安装另一个exe程序
;Filename: "{app}/othersetup.exe"; Description: "运行XX驱动"; Flags: hidewizard
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

;[Types]
;Name: Full ;Description:"完全安装"; Flags: iscustom
;Name: Compact ;Description:"简洁安装";
;Name: Custom; Description:"自定义安装";
;用与在用户系统中创建，修改或删除注册表健值

[Registry]
Root: HKLM ;SubKey:"Software\{#EnglishName}";ValueType:dword;ValueName:config;ValueData:10 ;Flags:uninsdeletevalue

[Code]
  var ErrorCode: Integer;

//if MsgBox('不知道是个啥', mbConfirmation, MB_OKCANCEL) = IDOK then
//  begin
//     MsgBox('执行了ok', mbConfirmation, MB_OK);
//  end else
//    begin
//      MsgBox('执行了', mbConfirmation, MB_OK);
//  end;

// 安装前强制杀掉程序
function InitializeSetup(): Boolean;
  begin
    ShellExec('open','taskkill.exe','/f /im {#MyAppExeName}','',SW_HIDE,ewNoWait,ErrorCode);
    ShellExec('open','tskill.exe',' {#MyAppName}','',SW_HIDE,ewNoWait,ErrorCode);
    result := True;
  end;

// 卸载钱强制杀掉程序
function InitializeUninstall(): Boolean;
  begin
    ShellExec('open','taskkill.exe','/f /im {#MyAppExeName}','',SW_HIDE,ewNoWait,ErrorCode);
    ShellExec('open','tskill.exe',' {#MyAppName}','',SW_HIDE,ewNoWait,ErrorCode);
    result := True;
  end;


//var
//IsRunning: Integer;
//
//// 安装时判断客户端是否正在运行
//function InitializeSetup(): Boolean;
//begin
//Result :=true; //安装程序继续
//IsRunning:=FindWindowByWindowName('{#EnglishName}');
//while IsRunning<>0 do
//begin
//    if Msgbox('安装程序检测到客户端正在运行。' #13#13 '您必须先关闭它然后单击“是”继续安装，或按“否”退出！', mbConfirmation, MB_YESNO) = idNO then
//    begin
//      Result :=false; //安装程序退出
//      IsRunning :=0;
//    end else begin
//      Result :=true; //安装程序继续
//      IsRunning:=FindWindowByWindowName('{#EnglishName}');
//    end;
//end;
//
//end;
//
//// 卸载时判断客户端是否正在运行
//function InitializeUninstall(): Boolean;
//begin
//Result :=true; //安装程序继续
//IsRunning:=FindWindowByWindowName('{#EnglishName}');
//while IsRunning<>0 do
//begin
//    if Msgbox('安装程序检测到客户端正在运行。' #13#13 '您必须先关闭它然后单击“是”继续安装，或按“否”退出！', mbConfirmation, MB_YESNO) = idNO then
//    begin
//      Result :=false; //安装程序退出
//      IsRunning :=0;
//    end else begin
//      Result :=true; //安装程序继续
//      IsRunning:=FindWindowByWindowName('{#EnglishName}');
//    end;
//end;
//end;

procedure  CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  case CurUninstallStep of
    usUninstall:
      begin // 开始卸载

      end;
    usPostUninstall:
      begin      // 卸载完成
        // MsgBox('CurUninstallStepChanged:' #13#13 'Uninstall just finished.', mbInformation, MB_OK);
        // ...insert code to perform post-uninstall tasks here...
        ShellExec('open', '{#MyAppURL}', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
      end;
  end;
end;


