object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Free Batch Music Splitter'
  ClientHeight = 394
  ClientWidth = 957
  Color = clGradientActiveCaption
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressPanel: TPanel
    Left = 0
    Top = 0
    Width = 957
    Height = 394
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    ExplicitWidth = 948
    ExplicitHeight = 446
    DesignSize = (
      957
      394)
    object ProgressLabel: TLabel
      Left = 617
      Top = 13
      Width = 106
      Height = 13
      Alignment = taCenter
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = '0/0'
      ExplicitLeft = 608
    end
    object ProgressList: TListView
      Left = 8
      Top = 39
      Width = 941
      Height = 350
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = 'File Path'
        end
        item
          Alignment = taCenter
          Caption = 'Step'
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = 'State'
          Width = 100
        end>
      DoubleBuffered = True
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      ParentDoubleBuffered = False
      TabOrder = 0
      ViewStyle = vsReport
      ExplicitWidth = 932
      ExplicitHeight = 402
    end
    object StopBtn: TButton
      Left = 720
      Top = 8
      Width = 220
      Height = 25
      Caption = 'Stop'
      TabOrder = 1
      OnClick = StopBtnClick
    end
    object ProgressBar1: TProgressBar
      Left = 270
      Top = 8
      Width = 332
      Height = 25
      TabOrder = 2
    end
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 125
      Height = 25
      Caption = 'Program Logs'
      TabOrder = 3
      OnClick = LogsBtnClick
    end
    object Button2: TButton
      Left = 139
      Top = 8
      Width = 125
      Height = 25
      Caption = 'Open Output Folder'
      TabOrder = 4
      OnClick = OpenOutputBtnClick
    end
  end
  object NormalPanel: TPanel
    Left = 0
    Top = 0
    Width = 957
    Height = 394
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 948
    ExplicitHeight = 446
    DesignSize = (
      957
      394)
    object Label1: TLabel
      Left = 21
      Top = 351
      Width = 71
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Output Folder:'
      ExplicitLeft = 12
      ExplicitTop = 403
    end
    object AddBtn: TJvArrowButton
      Left = 8
      Top = 8
      Width = 118
      Height = 25
      DropDown = AddFileMenu
      DropOnButtonClick = True
      Caption = 'Add Files'
      FillFont.Charset = DEFAULT_CHARSET
      FillFont.Color = clWindowText
      FillFont.Height = -11
      FillFont.Name = 'Tahoma'
      FillFont.Style = []
    end
    object Bevel1: TBevel
      Left = 729
      Top = 263
      Width = 220
      Height = 2
      Anchors = [akRight, akBottom]
      Shape = bsBottomLine
      ExplicitLeft = 720
      ExplicitTop = 320
    end
    object Label6: TLabel
      Left = 729
      Top = 274
      Width = 105
      Height = 13
      Anchors = [akRight, akBottom]
      Caption = 'Number of processes:'
      ExplicitLeft = 720
      ExplicitTop = 331
    end
    object StartBtn: TButton
      Left = 729
      Top = 8
      Width = 220
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Start'
      TabOrder = 0
      OnClick = StartBtnClick
      ExplicitLeft = 720
    end
    object FileList: TListView
      Left = 8
      Top = 39
      Width = 715
      Height = 303
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = 'File Path'
          Width = 450
        end
        item
          Alignment = taCenter
          Caption = 'Duration'
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = 'Split Value'
          Width = 150
        end>
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
      OnClick = FileListClick
      ExplicitWidth = 706
      ExplicitHeight = 355
    end
    object OutputFolderEdit: TJvDirectoryEdit
      Left = 89
      Top = 348
      Width = 779
      Height = 21
      DialogKind = dkWin32
      Flat = False
      ParentFlat = False
      ButtonHint = 'Select'
      ButtonWidth = 32
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 2
      Text = 'C:\data'
      ExplicitTop = 400
      ExplicitWidth = 770
    end
    object RemoveSelectedBtn: TButton
      Left = 132
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Delete'
      TabOrder = 3
      OnClick = RemoveSelectedBtnClick
    end
    object ClearBtn: TButton
      Left = 213
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 4
      OnClick = ClearBtnClick
    end
    object SplitTypePages: TPageControl
      Left = 729
      Top = 39
      Width = 220
      Height = 156
      ActivePage = TabSheet2
      Anchors = [akTop, akRight, akBottom]
      TabOrder = 5
      ExplicitLeft = 720
      ExplicitHeight = 213
      object TabSheet1: TTabSheet
        Caption = 'According to Parts'
        ExplicitHeight = 134
        DesignSize = (
          212
          128)
        object Label2: TLabel
          Left = 16
          Top = 19
          Width = 82
          Height = 13
          Caption = 'Number of Parts:'
        end
        object PartCountEdit: TJvSpinEdit
          Left = 104
          Top = 16
          Width = 72
          Height = 21
          CheckOptions = [coCheckOnChange, coCropBeyondLimit]
          CheckMaxValue = False
          Alignment = taCenter
          ButtonKind = bkClassic
          MinValue = 2.000000000000000000
          Value = 2.000000000000000000
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object DefaultPartBtn: TCheckBox
          Left = 16
          Top = 43
          Width = 193
          Height = 17
          Caption = 'Apply this to newly added files'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = DefaultPartBtnClick
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'According to Duration'
        ImageIndex = 1
        ExplicitHeight = 134
        DesignSize = (
          212
          128)
        object Label3: TLabel
          Left = 54
          Top = 46
          Width = 44
          Height = 13
          Caption = 'Seconds:'
        end
        object Label4: TLabel
          Left = 41
          Top = 73
          Width = 57
          Height = 13
          Caption = 'Miliseconds:'
        end
        object Label5: TLabel
          Left = 57
          Top = 19
          Width = 41
          Height = 13
          Caption = 'Minutes:'
        end
        object SecondsEdit: TJvSpinEdit
          Left = 104
          Top = 43
          Width = 72
          Height = 21
          CheckOptions = [coCheckOnChange, coCropBeyondLimit]
          CheckMinValue = True
          Alignment = taCenter
          ButtonKind = bkClassic
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
        object MiliSecondsEdit: TJvSpinEdit
          Left = 104
          Top = 70
          Width = 72
          Height = 21
          CheckOptions = [coCheckOnChange, coCropBeyondLimit]
          CheckMinValue = True
          Alignment = taCenter
          ButtonKind = bkClassic
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
        end
        object MinutesEdit: TJvSpinEdit
          Left = 104
          Top = 16
          Width = 72
          Height = 21
          CheckOptions = [coCheckOnChange, coCropBeyondLimit]
          CheckMinValue = True
          Alignment = taCenter
          ButtonKind = bkClassic
          Value = 3.000000000000000000
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object DefaultTimeBtn: TCheckBox
          Left = 16
          Top = 97
          Width = 161
          Height = 17
          Caption = 'Apply this to newly added files'
          TabOrder = 3
          OnClick = DefaultTimeBtnClick
        end
      end
    end
    object ApplyToFileBtn: TButton
      Left = 729
      Top = 201
      Width = 220
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Apply Selected Method to Selected Files'
      TabOrder = 6
      OnClick = ApplyToFileBtnClick
      ExplicitLeft = 720
      ExplicitTop = 258
    end
    object OpenOutputBtn: TButton
      Left = 874
      Top = 346
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Open'
      TabOrder = 7
      OnClick = OpenOutputBtnClick
      ExplicitLeft = 865
      ExplicitTop = 398
    end
    object StatusBar1: TStatusBar
      Left = 0
      Top = 375
      Width = 957
      Height = 19
      Panels = <
        item
          Text = 'Version 1.0'
          Width = 80
        end
        item
          Text = '0 files'
          Width = 50
        end>
      ExplicitTop = 427
      ExplicitWidth = 948
    end
    object NumberOfProcessList: TComboBox
      Left = 840
      Top = 271
      Width = 109
      Height = 21
      Style = csDropDownList
      Anchors = [akRight, akBottom]
      ItemIndex = 0
      TabOrder = 9
      Text = '1'
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16')
      ExplicitLeft = 831
      ExplicitTop = 328
    end
    object CheckUpdatesBtn: TCheckBox
      Left = 729
      Top = 298
      Width = 181
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = 'Check updates on startup'
      Checked = True
      State = cbChecked
      TabOrder = 10
      ExplicitLeft = 720
      ExplicitTop = 355
    end
    object ApplyToAllBtn: TButton
      Left = 729
      Top = 232
      Width = 220
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Apply Selected Method to All Files'
      TabOrder = 11
      OnClick = ApplyToAllBtnClick
      ExplicitLeft = 720
      ExplicitTop = 289
    end
    object LogsBtn: TButton
      Left = 623
      Top = 8
      Width = 100
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Program Logs'
      TabOrder = 12
      OnClick = LogsBtnClick
      ExplicitLeft = 614
    end
    object OutputFolderOptionsList: TComboBox
      Left = 729
      Top = 321
      Width = 220
      Height = 21
      Style = csDropDownList
      Anchors = [akRight, akBottom]
      ItemIndex = 0
      TabOrder = 13
      Text = 'Don'#39't create any folders in output'
      Items.Strings = (
        'Don'#39't create any folders in output'
        'Create one parent folder'
        'Create all folder structure')
      ExplicitLeft = 720
      ExplicitTop = 378
    end
    object DonateBtn: TButton
      Left = 542
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Donate'
      TabOrder = 14
      OnClick = DonateBtnClick
      ExplicitLeft = 533
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 
      'All supported|*.mp3;*.aac;*.ogg;*.opus;*.flac;*.alac;*.wv;*.wma;' +
      '*.ac3;*.spx;*.ofr;*.wav;*.m4a;*.m4b'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 120
    Top = 72
  end
  object ProgressTimer: TTimer
    Enabled = False
    Interval = 250
    OnTimer = ProgressTimerTimer
    Left = 40
    Top = 80
  end
  object MainMenu1: TMainMenu
    Left = 200
    Top = 72
    object F1: TMenuItem
      Caption = 'File'
      object A4: TMenuItem
        Caption = 'Add Files'
        OnClick = A1Click
      end
      object A5: TMenuItem
        Caption = 'Add Folder'
        OnClick = A2Click
      end
      object A6: TMenuItem
        Caption = 'Add Folder Tree'
        OnClick = A3Click
      end
    end
    object E1: TMenuItem
      Caption = 'Edit'
      object S1: TMenuItem
        Caption = 'Select All'
        ShortCut = 16449
        OnClick = S1Click
      end
    end
    object A7: TMenuItem
      Caption = 'Help'
      object A8: TMenuItem
        Caption = 'About'
        OnClick = A8Click
      end
      object C1: TMenuItem
        Caption = 'Change log'
        OnClick = C1Click
      end
    end
  end
  object AddFileMenu: TPopupMenu
    Left = 288
    Top = 80
    object A1: TMenuItem
      Caption = 'Add Files'
      OnClick = A1Click
    end
    object A2: TMenuItem
      Caption = 'Add Folder'
      OnClick = A2Click
    end
    object A3: TMenuItem
      Caption = 'Add Folder Tree'
      OnClick = A3Click
    end
  end
  object FileSearch: TJvSearchFiles
    DirParams.MinSize = 0
    DirParams.MaxSize = 0
    FileParams.SearchTypes = [stFileMask]
    FileParams.MinSize = 0
    FileParams.MaxSize = 0
    FileParams.FileMasks.Strings = (
      '*.mp3'
      '*.aac'
      '*.m4a'
      '*.m4b'
      '*.ogg'
      '*.opus'
      '*.flac'
      '*.alac'
      '*.wv'
      '*.wav'
      '*.m4a'
      '*.m4b')
    OnFindFile = FileSearchFindFile
    OnProgress = FileSearchProgress
    Left = 360
    Top = 72
  end
  object OpenFolderDlg: TJvBrowseForFolderDialog
    Left = 432
    Top = 80
  end
  object Taskbar: TTaskbar
    TaskBarButtons = <>
    TabProperties = []
    Left = 512
    Top = 80
  end
  object Info: TJvComputerInfoEx
    Left = 592
    Top = 104
  end
  object DragDrop1: TJvDragDrop
    DropTarget = Owner
    OnDrop = DragDrop1Drop
    Left = 648
    Top = 96
  end
  object UpdateCheckThread: TIdThreadComponent
    Active = True
    Loop = False
    Priority = tpNormal
    StopMode = smTerminate
    OnRun = UpdateCheckThreadRun
    Left = 480
    Top = 184
  end
  object UpdateDownloader: TJvHttpUrlGrabber
    FileName = 'output.txt'
    OutputMode = omStream
    Agent = 'JEDI-VCL'
    Port = 0
    ProxyAddresses = 'proxyserver'
    ProxyIgnoreList = '<local>'
    OnDoneStream = UpdateDownloaderDoneStream
    Left = 472
    Top = 256
  end
end
