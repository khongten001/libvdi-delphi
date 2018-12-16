object Form1: TForm1
  Left = 359
  Top = 142
  Width = 367
  Height = 234
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 18
    Height = 13
    Caption = 'VDI'
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 26
    Height = 13
    Caption = 'RAW'
  end
  object Memo1: TMemo
    Left = 8
    Top = 72
    Width = 337
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 176
    Width = 337
    Height = 17
    TabOrder = 1
  end
  object Button2: TButton
    Left = 256
    Top = 16
    Width = 75
    Height = 41
    Caption = 'VDI2RAW'
    TabOrder = 2
    OnClick = Button2Click
  end
  object txtvdi: TEdit
    Left = 80
    Top = 16
    Width = 169
    Height = 21
    TabOrder = 3
    Text = 'c:\temp\freedos.vdi'
  end
  object txtraw: TEdit
    Left = 80
    Top = 40
    Width = 169
    Height = 21
    TabOrder = 4
    Text = 'c:\temp\freedos.dd'
  end
end
