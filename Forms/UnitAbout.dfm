object AboutForm: TAboutForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'About'
  ClientHeight = 139
  ClientWidth = 370
  Color = clGradientActiveCaption
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    370
    139)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TsLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 364
    Height = 13
    Align = alTop
    Alignment = taCenter
    Caption = 'Free Batch Music Splitter'
    ExplicitWidth = 118
  end
  object Label2: TsLabel
    AlignWithMargins = True
    Left = 3
    Top = 22
    Width = 364
    Height = 13
    Align = alTop
    Alignment = taCenter
    Caption = 'Version 1.2'
    ExplicitWidth = 54
  end
  object Label3: TsLabel
    AlignWithMargins = True
    Left = 3
    Top = 41
    Width = 364
    Height = 13
    Align = alTop
    Alignment = taCenter
    Caption = '(c) 2015 - ozok26@gmail.com'
    ExplicitWidth = 141
  end
  object Label4: TsLabel
    AlignWithMargins = True
    Left = 3
    Top = 60
    Width = 364
    Height = 13
    Align = alTop
    Alignment = taCenter
    Caption = 'Apache License 2.0'
    ExplicitWidth = 93
  end
  object Label5: TsLabel
    AlignWithMargins = True
    Left = 3
    Top = 79
    Width = 364
    Height = 13
    Align = alTop
    Alignment = taCenter
    Caption = 'Uses ffmpeg, ffprobe, jvcl, madexcept'
    ExplicitWidth = 186
  end
  object Button1: TsButton
    Left = 8
    Top = 106
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Home'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TsButton
    Left = 89
    Top = 106
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Donate'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TsButton
    Left = 287
    Top = 106
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 2
    OnClick = Button3Click
  end
end
