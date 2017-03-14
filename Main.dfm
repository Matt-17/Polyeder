object Form1: TForm1
  Left = 246
  Top = 186
  BorderStyle = bsSingle
  Caption = 'Belegarbeit zu Polyedern '#169' 2003 by Matthias Voigt'
  ClientHeight = 565
  ClientWidth = 871
  Color = clBtnFace
  TransparentColorValue = clBtnFace
  Constraints.MaxHeight = 599
  Constraints.MaxWidth = 879
  Constraints.MinHeight = 599
  Constraints.MinWidth = 879
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ShowPanel: TLabel
    Left = 8
    Top = 352
    Width = 54
    Height = 13
    Caption = 'ShowPanel'
  end
  object RotCheck: TSpeedButton
    Left = 8
    Top = 200
    Width = 185
    Height = 14
    AllowAllUp = True
    GroupIndex = 1
    Down = True
    Caption = 'Rotieren'
  end
  object RandomRot: TSpeedButton
    Left = 8
    Top = 184
    Width = 185
    Height = 14
    AllowAllUp = True
    GroupIndex = 2
    Caption = 'Zuf'#228'llige Bewegung'
    OnClick = RandomRotClick
  end
  object TetraBtn: TSpeedButton
    Left = 8
    Top = 8
    Width = 185
    Height = 22
    GroupIndex = 3
    Down = True
    Caption = 'Tetraeder'
    OnClick = TetraBtnClick
  end
  object HexaBtn: TSpeedButton
    Left = 8
    Top = 32
    Width = 185
    Height = 22
    GroupIndex = 3
    Caption = 'Hexaeder'
    OnClick = HexaBtnClick
  end
  object OktaBtn: TSpeedButton
    Left = 8
    Top = 56
    Width = 185
    Height = 22
    GroupIndex = 3
    Caption = 'Oktaeder'
    OnClick = OktaBtnClick
  end
  object IkoBtn: TSpeedButton
    Left = 8
    Top = 80
    Width = 185
    Height = 22
    GroupIndex = 3
    Caption = 'Ikosaeder'
    OnClick = IkoBtnClick
  end
  object KlappBtn: TSpeedButton
    Tag = -1
    Left = 8
    Top = 536
    Width = 185
    Height = 22
    OnClick = KlappBtnClick
  end
  object DodeBtn: TSpeedButton
    Left = 8
    Top = 104
    Width = 185
    Height = 22
    GroupIndex = 3
    Caption = 'Dodekaeder'
    OnClick = DodeBtnClick
  end
  object Isometric: TSpeedButton
    Left = 8
    Top = 160
    Width = 89
    Height = 17
    GroupIndex = 4
    Down = True
    Caption = 'Isometrisch'
  end
  object Perspective: TSpeedButton
    Tag = 300
    Left = 104
    Top = 160
    Width = 89
    Height = 17
    GroupIndex = 4
    Caption = 'Perpektivisch'
  end
  object DualChk: TSpeedButton
    Left = 8
    Top = 136
    Width = 185
    Height = 17
    AllowAllUp = True
    GroupIndex = 7
    Caption = 'Dualen K'#246'rper Zeichnen'
  end
  object ZoomOut: TButton
    Left = 104
    Top = 384
    Width = 89
    Height = 33
    Caption = 'Verkleinern'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TabStop = False
    OnMouseDown = ZoomOutMouseDown
    OnMouseUp = ZoomOutMouseUp
  end
  object ZoomIn: TButton
    Left = 8
    Top = 384
    Width = 89
    Height = 33
    Caption = 'Vergr'#246#223'ern'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TabStop = False
    OnMouseDown = ZoomInMouseDown
    OnMouseUp = ZoomInMouseUp
  end
  object DrawPanel: TPanel
    Left = 208
    Top = 8
    Width = 657
    Height = 553
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BevelWidth = 2
    TabOrder = 2
    object DrawImage: TImage
      Left = 4
      Top = 4
      Width = 649
      Height = 545
      Align = alClient
      OnMouseDown = DrawImageMouseDown
      OnMouseMove = DrawImageMouseMove
      OnMouseUp = DrawImageMouseUp
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 216
    Width = 185
    Height = 105
    Caption = 'Rotation'
    TabOrder = 3
    object LX: TLabel
      Left = 8
      Top = 16
      Width = 19
      Height = 13
      Caption = 'X: 0'
    end
    object LY: TLabel
      Left = 8
      Top = 40
      Width = 19
      Height = 13
      Caption = 'Y: 0'
    end
    object LZ: TLabel
      Left = 8
      Top = 64
      Width = 19
      Height = 13
      Caption = 'Z: 0'
    end
    object ResetBtn: TSpeedButton
      Left = 48
      Top = 88
      Width = 129
      Height = 14
      Caption = 'Reset'
      OnClick = ResetBtnClick
    end
    object SBX: TScrollBar
      Left = 48
      Top = 16
      Width = 129
      Height = 17
      Max = 10
      Min = -10
      PageSize = 0
      TabOrder = 0
      TabStop = False
      OnChange = SBXChange
    end
    object SBY: TScrollBar
      Left = 48
      Top = 40
      Width = 129
      Height = 17
      Max = 10
      Min = -10
      PageSize = 0
      TabOrder = 1
      TabStop = False
      OnChange = SBYChange
    end
    object SBZ: TScrollBar
      Left = 48
      Top = 64
      Width = 129
      Height = 17
      Max = 10
      Min = -10
      PageSize = 0
      TabOrder = 2
      TabStop = False
      OnChange = SBZChange
    end
  end
  object Bar: TScrollBar
    Left = 8
    Top = 328
    Width = 185
    Height = 17
    Max = 1000
    Min = 1
    PageSize = 0
    Position = 1
    TabOrder = 4
    OnChange = BarChange
  end
  object BuildSpeed: TRadioGroup
    Tag = 2
    Left = 8
    Top = 424
    Width = 185
    Height = 105
    Caption = 'Bau Geschwindigkeit'
    ItemIndex = 1
    Items.Strings = (
      'Langsam'
      'Normal'
      'Schnell'
      'Sehr Schnell'
      'Ohne Animation')
    TabOrder = 5
    OnClick = BuildSpeedClick
  end
  object T: TTimer
    Interval = 33
    OnTimer = TTimer
  end
  object ZoomTimer: TTimer
    Tag = 100
    Enabled = False
    Interval = 33
    OnTimer = ZoomTimerTimer
    Left = 88
    Top = 360
  end
end
