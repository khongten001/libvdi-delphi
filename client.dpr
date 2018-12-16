program client;

uses
  madExcept,
  madLinkDisAsm,
  madListModules,
  Forms,
  ufrmclient in 'ufrmclient.pas' {Form1};

//{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
