object frDemo: TfrDemo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Garbage Collector Demo'
  ClientHeight = 172
  ClientWidth = 211
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Button1: TButton
    Left = 13
    Top = 17
    Width = 185
    Height = 25
    Caption = 'Local Variable'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 13
    Top = 46
    Width = 185
    Height = 25
    Caption = 'Local variable with Collect'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 13
    Top = 75
    Width = 185
    Height = 25
    Caption = 'Global Variable'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 13
    Top = 104
    Width = 185
    Height = 25
    Caption = 'Local variable with TAutoFree'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 13
    Top = 133
    Width = 185
    Height = 25
    Caption = 'GarbageCollector Clear'
    TabOrder = 4
    OnClick = Button5Click
  end
end
