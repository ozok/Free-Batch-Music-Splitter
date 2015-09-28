object LogsForm: TLogsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Logs'
  ClientHeight = 300
  ClientWidth = 635
  Color = clGradientActiveCaption
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    635
    300)
  PixelsPerInch = 96
  TextHeight = 13
  object LogsList: TsMemo
    Left = 8
    Top = 8
    Width = 619
    Height = 257
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object LogIndexList: TsComboBox
    Left = 8
    Top = 271
    Width = 145
    Height = 21
    Anchors = [akLeft, akBottom]
    Alignment = taLeftJustify
    VerticalAlignment = taAlignTop
    Style = csDropDownList
    Color = clGradientActiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 1
    Text = 'Program Log'
    OnChange = LogIndexListChange
    Items.Strings = (
      'Program Log'
      'Process 1'
      'Process 2'
      'Process 3'
      'Process 4'
      'Process 5'
      'Process 6'
      'Process 7'
      'Process 8'
      'Process 9'
      'Process 10'
      'Process 11'
      'Process 12'
      'Process 13'
      'Process 14'
      'Process 15'
      'Process 16')
  end
  object Button1: TsButton
    Left = 552
    Top = 271
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 2
    OnClick = Button1Click
  end
  object RefreshBtn: TsButton
    Left = 159
    Top = 271
    Width = 75
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = 'Refresh'
    TabOrder = 3
    OnClick = RefreshBtnClick
  end
end
