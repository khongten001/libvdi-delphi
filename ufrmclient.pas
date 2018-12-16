unit ufrmclient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    Button2: TButton;
    txtvdi: TEdit;
    Label1: TLabel;
    txtraw: TEdit;
    Label2: TLabel;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  function VDI2RAW(source,target:string):boolean;
  public
    { Public declarations }
  end;

type
Tlibvdihandleopen=function(filename : pansichar; read_only : integer) : integer; stdcall;
 Tlibvdihandleclose=function(handle : thandle) : integer; stdcall;
 Tlibvdihandlegetmediasize = function : int64; stdcall;
 Tlibvdihandlewritebufferatoffset = function(handle : thandle; buffer : pointer; size : cardinal; offset : int64) : integer; stdcall;
 Tlibvdihandlereadbufferatoffset = function(handle : thandle; buffer : pointer; size : cardinal; offset : int64) : integer; stdcall;

var
  Form1: TForm1;
  CancelFlag:boolean;
  fLibHandle:thandle;
lib_vdi_open:Tlibvdihandleopen ;
lib_vdi_close:Tlibvdihandleclose ;
lib_vdi_read_buffer_at_offset:Tlibvdihandlereadbufferatoffset;
lib_vdi_write_buffer_at_offset:Tlibvdihandlewritebufferatoffset;
lib_vdi_get_media_size:Tlibvdihandlegetmediasize;

implementation

{$R *.dfm}

function init:boolean;
var
libFileName : ansistring;
begin
libFileName:=ExtractFilePath(ParamStr(0))+'\libvdi.dll';
if fileExists(libFileName) then
        begin
                fLibHandle:=LoadLibraryA(PAnsiChar(libFileName));
                if fLibHandle<>0 then
                begin
                        @lib_vdi_open:=GetProcAddress(fLibHandle,'vdi_open');
                        @lib_vdi_close:=GetProcAddress(fLibHandle,'vdi_close');
                        @lib_vdi_read_buffer_at_offset:=GetProcAddress(fLibHandle,'vdi_read_buffer_at_offset');
                        @lib_vdi_write_buffer_at_offset:=GetProcAddress(fLibHandle,'vdi_write_buffer_at_offset');
                        @lib_vdi_get_media_size:=GetProcAddress(fLibHandle,'vdi_get_media_size');
                 end;
        end
        else raise exception.Create ('could not find libvhdi.dll');
end;

function TForm1.VDI2RAW(source,target:string):boolean;
var
handle,dst:thandle;
size,offset:int64;
blocksize,bytesread,byteswritten:cardinal;
buffer:pointer;
begin
CancelFlag :=false;
//
handle:=lib_vdi_open(pansichar(ansistring(source)),1);
if handle<>dword(-1) then
  begin
  size:=lib_vdi_get_media_size;
  ProgressBar1.Max := size;
  blocksize:=1024*1024;
  getmem(buffer,blocksize );
  offset:=0;
  dst:=CreateFile(pchar(target), GENERIC_write, FILE_SHARE_write, nil, CREATE_ALWAYS , FILE_ATTRIBUTE_NORMAL, 0);
  bytesread:=1;
  while (CancelFlag =false) and (bytesread>0)  do
    begin
    ProgressBar1.Position :=offset;
    bytesread:=lib_vdi_read_buffer_at_offset(handle,buffer,blocksize,offset);
    //if bytesread<>0 then
      //begin
      writefile(dst,buffer^,bytesread,byteswritten,nil);
      //memo1.lines.Add(inttostr(offset)+'/'+inttostr(size)+ ' read '+inttostr(bytesread)+' write '+inttostr(byteswritten));
      //end;
    offset:=offset+blocksize;
    end;
  lib_vdi_close(handle);
  closehandle(dst);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
//if OpenTextFileDialog1.Execute=false then exit;
init;
vdi2raw(txtvdi.Text  ,txtraw.Text );
end;

end.
