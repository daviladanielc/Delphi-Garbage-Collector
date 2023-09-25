unit uFrDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uGarbageCollector;

type
  TMyClass = class
  private
    FParam: String;
  public
    constructor Create; overload;
    constructor Create(AParam: string);overload;
    destructor Destroy;override;
  end;

  TfrDemo = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FTestClass: TMyClass;
  end;

var
  frDemo: TfrDemo;

implementation

{$R *.dfm}

procedure TfrDemo.Button1Click(Sender: TObject);
var
  LTest: TStringList;
begin
  LTest:= Garbage.Add<TStringList>(TStringList.Create);
  LTest.Add('This');
  LTest.Add('is a');
  Ltest.Add('test');
  Showmessage(LTest.Text);
  //Free when Garbage is destroyed
end;

procedure TfrDemo.Button2Click(Sender: TObject);
var
  LTest: TStringList;
begin
  LTest:= Garbage.Add<TStringList>(TStringList.Create);
  try
    LTest.Add('This');
    LTest.Add('is a');
    Ltest.Add('test with collect');
    Showmessage(LTest.Text);
  finally
    Garbage.Collect(LTest);
  end;
end;

procedure TfrDemo.Button3Click(Sender: TObject);
begin
  FTestClass:= Garbage.Add<TMyClass>(TMyClass.Create('with input params'));
end;

procedure TfrDemo.Button4Click(Sender: TObject);
var
  LLocal: TMyClass;
  LTest: TStringList;
begin
  LLocal:= TAutoCollect<TMyClass>.New(TMyClass.Create).GetInstance;

  LTest:= TAutoCollect<TStringList>.New(TStringList.Create).GetInstance;
  LTest.Add('1');
  LTest.Add('2');
  LTest.Add('3');
  LLocal.FParam:= 'test';
  Showmessage(LLocal.FParam);
  SHowMessage(LTest.Text);
  //LLocal its destroyed here
  //LTest its destroyed here
end;

procedure TfrDemo.FormCreate(Sender: TObject);
begin
  Garbage:= TGarbageCollector.Create(Self);
end;

{ TMyClass }

constructor TMyClass.Create(AParam: string);
begin
  FParam:= AParam;
end;

destructor TMyClass.Destroy;
begin
  Showmessage('TMyclass destroy');
  inherited;
end;

constructor TMyClass.Create;
begin

end;

initialization
  ReportMemoryLeaksOnShutdown:= True;

end.
