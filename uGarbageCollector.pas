unit uGarbageCollector;

interface

uses
  System.Generics.Collections, Rtti, System.Defer, System.Classes,
  System.SysUtils;

type

  IAutoCollect<T> = interface
    function GetInstance:T;
  end;

  TAutoCollect<T: class> = class(TInterfacedObject, IAutoCollect<T>)
  private
    FInstance: T;
    constructor Create(AInstance: T);
    destructor Destroy; override;
  public
    property Instance: T read FInstance;
    class function New(AInstance: T):IAutoCollect<T>;
    function GetInstance:T;
  end;

  TGarbageCollector = class(TComponent)
  private
    FClassDictionary: TObjectDictionary<TObject, TClass>;
    function Add<T: class>(AClass: T; AClassType: TClass): T; overload;
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    function Add<T: class>(AClass: T): T; overload;
    procedure Collect(AObject: TObject);
  end;

var
  Garbage: TGarbageCollector;

implementation

uses
  System.Types;

constructor TGarbageCollector.Create(AOwner: TComponent);
begin
  inherited;
  FClassDictionary := TObjectDictionary<TObject, TClass>.Create([doOwnsKeys]);
end;

destructor TGarbageCollector.Destroy;
begin
  FClassDictionary.Free;
  inherited Destroy;
end;

function TGarbageCollector.Add<T>(AClass: T): T;
begin
  Result := Add<T>(AClass, T);
end;

function TGarbageCollector.Add<T>(AClass: T; AClassType: TClass): T;
var
  obj: TObject;
begin
  if not(AClass is AClassType) then
    raise Exception.Create('The added object is not an instance of ' + AClassType.ClassName);

  obj := AClass as TObject;

  if FClassDictionary.ContainsKey(obj) then
    raise Exception.Create('The object has already been added to the garbage collector');

  FClassDictionary.Add(obj, AClassType);
  Result := AClass;
end;

procedure TGarbageCollector.Collect(AObject: TObject);
var
  obj: TObject;
begin
  if FClassDictionary.ContainsKey(AObject) then
  begin
    FClassDictionary.Remove(AObject);
  end;
end;


{ TAutoFree<T> }

constructor TAutoCollect<T>.Create(AInstance: T);
begin
  inherited Create;
  FInstance := AInstance;
end;

destructor TAutoCollect<T>.Destroy;
begin
  FInstance.Free;
  inherited;
end;

function TAutoCollect<T>.GetInstance: T;
begin
  Result:= FInstance;
end;

class function TAutoCollect<T>.New(AInstance: T): IAutoCollect<T>;
begin
  Result:= TAutoCollect<T>.Create(AInstance);
end;

end.
