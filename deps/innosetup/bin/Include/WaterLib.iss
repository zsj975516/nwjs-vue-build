[Files]
Source: compiler:WaterLib.dll; DestDir: {tmp}; Flags: dontcopy noencryption

[Code]
//��ʼ������ˮ��ͼ������ڸ����
//HWD		����ˮ��Ч�����þ����
//DrawTextSize	��ʼ����ˮ��Ч���ϵ��ı�����, �粻ʹ����Ϊ0
//DrawBmpSize	��ʼ����ˮ��Ч���ϵ�λͼ����, �粻ʹ����Ϊ0
function WaterInit(HWD: HWND; DrawTextSize, DrawBmpSize: Integer):Integer;
external 'WaterInit@files:WaterLib.dll stdcall';

//����ˮ��ͼ�������С��λ��
Procedure WaterSetBounds(Handle, Left, Top, Width, Height: Integer);
external 'WaterSetBounds@files:WaterLib.dll stdcall';

//ClickBlob	�������ʱ������ˮ��Ч�����ȣ�0 ��ʾ����
//Damping	ˮ������ϵ��
//RandomBlob	���������ˮ�������ȣ�0 ��ʾ����
//RandomDelay	�������ˮ�ε���ʱ
//TrackBlob	����ƶ��켣��ˮ�εķ��ȣ�0 ��ʾ����
Procedure WaterSetType(Handle, ClickBlob, Damping, RandomBlob, RandomDelay, TrackBlob: Integer);
external 'WaterSetType@files:WaterLib.dll stdcall';

//����ˮ��ͼ�����ͼƬ�ļ�
Procedure WaterSetFile(Handle: Integer; FileName: AnsiString);
external 'WaterSetFile@files:WaterLib.dll stdcall';

//����ˮ��ͼ������Ƿ�����ˮ��Ч��
Procedure WaterSetActive(Handle: Integer; Active: Boolean);
external 'WaterSetActive@files:WaterLib.dll stdcall';

//����ˮ��ͼ����������
Procedure WaterSetParentWindow(Handle: Integer; HWND: HWND);
external 'WaterSetParentWindow@files:WaterLib.dll stdcall';

//��ջ����ϵ�ˮ��Ч��
Procedure WaterClear(Handle: Integer);
external 'WaterClear@files:WaterLib.dll stdcall';

//�ͷ�ָ�������ˮ��ͼ�����
Procedure WaterFree(Handle: Integer);
external 'WaterFree@files:WaterLib.dll stdcall';

//�ͷ�ȫ��ˮ��ͼ�����
Procedure WaterAllFree;
external 'WaterAllFree@files:WaterLib.dll stdcall';

//�����Ƿ�֧������, True֧������ʾSkyGz.Com��ʶ, False��֧����رձ�ʶ��ʾ
Procedure WaterSupportAuthor(SupportAuthor: Boolean);
external 'WaterSupportAuthor@files:WaterLib.dll stdcall';

//����API��Ҫ����֧�����ߵı�ʶ��ʾʱ�ſ�ʹ��
//��Ҫ������������ˮ��Ч��ͼ�ϻ��ı���λͼ
procedure WaterDrawTextBrush(Handle, Index: Integer; BrushColor: TColor; BrushStyle: TBrushStyle);
external 'WaterDrawTextBrush@files:WaterLib.dll stdcall';

Procedure WaterDrawTextFont(Handle, Index: Integer; FontName: AnsiString; FontSize: Integer; FontColor: TColor; FontCharset: Byte);
external 'WaterDrawTextFont@files:WaterLib.dll stdcall';

procedure WaterDrawBmpBrush(Handle, Index: Integer; BrushColor: TColor; BrushStyle: TBrushStyle);
external 'WaterDrawBmpBrush@files:WaterLib.dll stdcall';

Procedure WaterDrawBmpFont(Handle, Index: Integer; FontName: AnsiString; FontSize: Integer; FontColor: TColor; FontCharset: Byte);
external 'WaterDrawBmpFont@files:WaterLib.dll stdcall';

Procedure WaterDrawBitmap(Handle, Index: Integer; X, Y: Integer; HBitmap: LongWord; Transparent: Boolean; TransparentColor: TColor);
external 'WaterDrawBitmap@files:WaterLib.dll stdcall';

Procedure WaterDrawText(Handle, Index: Integer; X, Y: Integer; S: AnsiString);
external 'WaterDrawText@files:WaterLib.dll stdcall';