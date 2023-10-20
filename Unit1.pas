unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, ComCtrls, StdCtrls;

type
 ThreadHTTP=class(TThread)
 private
  Stream:TMemoryStream;
  i:integer;
 public
  procedure Execute;override;
  procedure ShowResult;
end;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ProgressBar1: TProgressBar;
    IdHTTP1: TIdHTTP;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ ThreadHTTP }

procedure ThreadHTTP.Execute;
var
 j:integer;
begin
  inherited;
   i:=0;
   j:=0;
   Stream:=TMemoryStream.Create;
   Form1.IdHTTP1.Get('http://devdelphi.ru/files/VK_APImodul.rar',Stream);
   Form1.ProgressBar1.Max:=Stream.Size;
   while j<=Stream.Size do
    begin
     inc(i);
     Synchronize(ShowResult);
     inc(j);
     Form1.ProgressBar1.Position:=Form1.ProgressBar1.Position+1;
    end;
   Stream.SaveToFile('C:\1.rar');
   Stream.Free;
end;

procedure ThreadHTTP.ShowResult;
begin
   Form1.Caption:=IntToStr(i)+' kbs';
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 MyHTTP:ThreadHTTP;
begin
   ProgressBar1.Position:=0;
   MyHTTP:=ThreadHTTP.Create(False);
end;

end.
