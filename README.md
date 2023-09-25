# Delphi-Garbage-Collector


# Description

An attempt at automating the process of releasing objects in Delphi without the need to use Try Finally blocks to free objects after their usage.

It utilizes a main class to collect objects created during usage and release them upon the destruction of the main object (for example, a TForm).
It also allows using TAutoCollect, which is an interfaced class that enables the creation of simple to complex classes to be freed upon exiting the execution scope, similar to how interfaces work.

## Using

Add the folder where uGarbageCollector.pas is located to the Delphi library path or to your project's search path.

## Contribution

If you believe you can help improve this repository, please submit a PR, and I will review it. Any assistance is welcome.

## Delphi vesions 
  - Tested in Delphi 11.0
  > I recommend using Delphi XE or better.

Object
```pascal

uses uGarbageCollector

...

var
  LTest: TStringList;
begin
 LTest:= Garbage.Add<TStringList>(TStringList.Create);
 ...
 ...
 ...
 ... 
end;

```

LTest será liberada quando Garbage for destruído. 
```pascal

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

```

Com parâmetros de input no create da classe a ser coletada

```pascal
begin
  FTestClass:= Garbage.Add<TMyClass>(TMyClass.Create('with input params'));
end;
```

Exemplo de uso da classe TAutoCollect

```pascal
var
  LLocal: TMyClass;
begin
  LLocal:= TAutoCollect<TMyClass>.New(TMyClass.Create).GetInstance;
  LLocal.FParam:= 'test'; 
  Showmessage(LLocal.FParam);  
  
 //LLocal its destroyed here
end;

```

Na pasta sample tem mais alguns exemplos de uso. 