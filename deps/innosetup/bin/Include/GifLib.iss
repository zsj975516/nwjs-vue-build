[Files]
Source: compiler:GifLib.dll; DestDir: {tmp}; Flags: dontcopy noencryption

[Code]
//��ʼ������Gifͼ������ڸ����
function GifInit(HWD: HWND):Integer;
external 'GifInit@files:GifLib.dll stdcall';

//����Gifͼ�������С��λ��
Procedure GifSetBounds(Handle, Left, Top, Width, Height: Integer);
external 'GifSetBounds@files:GifLib.dll stdcall';

//����Gifͼ�����ͼƬ�ļ�
Procedure GifSetFile(Handle: Integer; FileName: AnsiString);
external 'GifSetFile@files:GifLib.dll stdcall';

//����Gifͼ����������
Procedure GifSetParentWindow(Handle: Integer; HWND: HWND);
external 'GifSetParentWindow@files:GifLib.dll stdcall';

//�ͷ�ָ�������Gifͼ�����
Procedure GifFree(Handle: Integer);
external 'GifFree@files:GifLib.dll stdcall';

//�ͷ�ȫ��Gifͼ�����
Procedure GifAllFree;
external 'GifAllFree@files:GifLib.dll stdcall';
