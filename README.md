# Delphi-Garbage-Collector


# Description

An attempt at automating the process of releasing objects in Delphi without the need to use Try Finally blocks to free objects after their usage.

It utilizes a main class to collect objects created during usage and release them upon the destruction of the main object (for example, a TForm).
It also allows using TAutoCollect, which is an interfaced class that enables the creation of simple to complex classes to be freed upon exiting the execution scope, similar to how interfaces work.

The idea behind this project is not to require the programmer to migrate their classes to an interface and to improve memory management. 
With the TAutoCollect class, it's possible to turn a simple class into something like a interface without implementing anything new.

## Pending features

-> Allow the TGargabeCollector to create objects for a specific 'owner' and enable releasing only the objects created for that owner

## Instalation

Add the folder where uGarbageCollector.pas is located to the Delphi library path or to your project's search path.

## Contribution

If you believe you can help improve this repository, please submit a PR, and I will review it. Any assistance is welcome.

## Delphi versions 
  - Tested in Delphi 11.0
  > I recommend using Delphi XE or better.

## Usage

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

LTest will be released when Garbage is destroyed
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

With input parameters in the create of the class to be collected

```pascal
begin
  FTestClass:= Garbage.Add<TMyClass>(TMyClass.Create('with input params'));
end;
```

Example of how to use the TAutoCollect class

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

In the 'sample' folder, there are more usage examples