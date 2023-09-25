program GarbageCollectorDemo;

uses
  Vcl.Forms,
  uFrDemo in 'uFrDemo.pas' {frDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrDemo, frDemo);
  Application.Run;
end.


