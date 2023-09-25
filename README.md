# Delphi-Garbage-Collector


# Description

Uma tentativa de automatização no processo de liberação de objetos em Delphi sem a necessidade de utilizar blocos Try Finally para liberar objetos após o uso.

Utiliza uma classe principal para coletar objetos criados durante o uso e liberar os mesmos após a destruição do objeto principal (por exemplo um TForm)
Também permite utilizar a TAutoCollect que é uma classe interfaceada que permite criar classes simples a classes complexas para serem liberadas após a saída do escopo de execução, parecido com o funcionamento de interfaces. 

## Using

Adicione no library path do delphi ou no search path do seu projeto a pasta onde está o uGarbageCollector.pas

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