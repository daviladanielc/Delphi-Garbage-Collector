unit uFrDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uGarbageCollector, Uni;

type
  TMyClass = class
  private
    FParam: String;
  public
    procedure DoRaise;
     constructor Create; overload;
    constructor Create(AParam: string);overload;
    destructor Destroy;override;
  end;

  TfrDemo = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    procedure DoSomething(AObj: TMyClass);
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
  DoSomething(LLocal); //<-- You can change the scope of execution and use the object in another function/procedure, and the object will be released after that.
  LLocal.FParam:= ' Value after Do Something';
  Showmessage(LLocal.FParam);
  SHowMessage(LTest.Text);
  //LLocal its destroyed here
  //LTest its destroyed here
end;

procedure TfrDemo.Button5Click(Sender: TObject);
var
  LTest: TMyClass;
  LStr: TStringList;
begin

  LTest:= Garbage.Add<TMyClass>(TMyClass.Create);
  LStr:= Garbage.Add<TStringList>(TStringList.Create);

  Garbage.Clear; //clear everything
end;

procedure TfrDemo.DoSomething(AObj: TMyClass);
begin
  AObj.FParam:= 'Value of Do Something';
  ShowMessage(AObj.FParam);
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

procedure TMyClass.DoRaise;
begin
  raise Exception.Create('Ops, error');
end;

constructor TMyClass.Create;
begin

end;

initialization
  ReportMemoryLeaksOnShutdown:= True;

end.
