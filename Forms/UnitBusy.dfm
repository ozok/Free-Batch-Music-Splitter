object BusyForm: TBusyForm
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Free Batch Music Splitter'
  ClientHeight = 41
  ClientWidth = 443
  Color = clGradientActiveCaption
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    443
    41)
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressLabel: TLabel
    Left = 8
    Top = 14
    Width = 66
    Height = 13
    Caption = 'Please wait...'
  end
  object AbortBtn: TButton
    Left = 360
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Stop'
    TabOrder = 0
    OnClick = AbortBtnClick
  end
end
