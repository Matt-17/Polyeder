unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Math, StdCtrls, Buttons;

type
  TVektor = Object
    X, Y, Z : Double;
    Function Norm : Double;
    Function MakeUnit : TVektor;
  End;
  T2DPunkt = Object
    X, Y : Integer;
  End;

  TPolyType = (Tetraeder, Hexaeder, Oktaeder, Ikosaeder, Dodekaeder);

  
  TKnick = Record
    Anz : Byte;
    Who : Array[1..32] of Byte;
    Ger : Array[1..2] of Byte;
    Dir : ShortInt;
  End;

  TPolyRec = Record
     PolyederTyp    : TPolyType;
     NumberOfPoints : Byte;
     NumberOfDraws  : Byte;
     RotationAngle  : Extended;  
     Ecken          : Array[1..255] of TVektor;
     Draw           : Array[1..255] of Byte;
     Knicke         : Array[1..20] of TKnick;
  End;

  TPolyeder = Object
     PolyederTyp    : TPolyType;
     NumberOfPoints : Byte;
     NumberOfDraws  : Byte;
     RotationAngle  : Extended;
     Ecken          : Array[1..255]of TVektor;
     Punkte2D       : Array[1..255]of T2DPunkt;
     Draw           : Array[1..255] of Byte;      
     Knicke         : Array[1..20] of TKnick;
     Procedure Init (Side_Length : Double; PolyType : TPolyType);
     Procedure Calc_2D_Points (Dist : Double);
     Procedure RotObjX (Deg  : Integer);
     Procedure RotObjY (Deg  : Integer);
     Procedure RotObjZ (Deg  : Integer);
     Procedure Scale (ScaleVar : Double);
     Procedure Move (Dest : TVektor);

  End;
  TForm1 = class(TForm)
    T: TTimer;
    ZoomOut: TButton;
    ZoomIn: TButton;
    DrawPanel: TPanel;
    DrawImage: TImage;
    GroupBox1: TGroupBox;
    LX: TLabel;
    LY: TLabel;
    LZ: TLabel;
    SBX: TScrollBar;
    SBY: TScrollBar;
    SBZ: TScrollBar;
    Bar: TScrollBar;
    ShowPanel: TLabel;
    BuildSpeed: TRadioGroup;
    RotCheck: TSpeedButton;
    RandomRot: TSpeedButton;
    ResetBtn: TSpeedButton;
    TetraBtn: TSpeedButton;
    HexaBtn: TSpeedButton;
    OktaBtn: TSpeedButton;
    IkoBtn: TSpeedButton;
    KlappBtn: TSpeedButton;
    DodeBtn: TSpeedButton;
    Isometric: TSpeedButton;
    Perspective: TSpeedButton;
    DualChk: TSpeedButton;
    ZoomTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TTimer(Sender: TObject);
    procedure KlappBtnClick(Sender: TObject);
    procedure BarChange(Sender: TObject);
    procedure SBXChange(Sender: TObject);
    procedure SBYChange(Sender: TObject);
    procedure SBZChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure IkoBtnClick(Sender: TObject);
    procedure HexaBtnClick(Sender: TObject);
    procedure TetraBtnClick(Sender: TObject);
    procedure OktaBtnClick(Sender: TObject);
    procedure BuildSpeedClick(Sender: TObject);
    procedure RandomRotClick(Sender: TObject);
    procedure ResetBtnClick(Sender: TObject);
    procedure DodeBtnClick(Sender: TObject);
    procedure DrawImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ZoomInMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZoomTimerTimer(Sender: TObject);
    procedure ZoomOutMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZoomOutMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZoomInMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
    ScreenBuf : TBitmap;
    CX, CY : Word;
    Procedure Draw(Poly : TPolyeder);
    Procedure ResetAll;
  public
    { Public-Deklarationen }
  end;




  Function Sine(Deg : Double) : Double;

  Procedure RotX(Var Punkt : TVektor; Deg : Double);
  Procedure RotY(Var Punkt : TVektor; Deg : Double);
  Procedure RotZ(Var Punkt : TVektor; Deg : Double);
  Procedure RotG(Var Punkt : TVektor; P1, P2 : TVektor; Deg : Double);

  Function CrossP(V1, V2 : TVektor) : TVektor; 
  Function DotP(V1, V2 : TVektor) : Double;
  
  Function Calc_3D2D(P : TVektor; Dist : Double) : T2DPunkt;

  Procedure LoadFromFile(Var Polyeder : TPolyRec; PolyType : TPolyType);
  Procedure SaveToFile(Polyeder : TPolyRec);

  Function Make_Dual(P1 : TPolyeder) : TPolyeder;
  Function Get_Tri_Mid(V1, V2, V3 : TVektor) : TVektor;
  Function Get_Qua_Mid(V1, V2, V3, V4 : TVektor) : TVektor;
Function Get_Cin_Mid(V1, V2, V3, V4, V5 : TVektor) : TVektor;

Const
  Tetra_Draw : Array[1..10] of Byte = (1, 2, 3, 1, 6, 2, 4, 3, 5, 1);
  Okta_Draw : Array[1..20] of Byte = (7, 5, 8, 7, 1, 2, 3, 1, 5, 10, 3, 5, 1, 6, 2, 9, 4, 3, 4, 2);
  Hexa_Draw : Array[1..20] of Byte  = (7, 4, 1, 2, 3, 4, 13, 11, 1, 5, 6, 2, 12, 14, 3, 8, 10, 9, 7, 8);
  IKO_Draw : Array[1..42] of Byte  = (12, 18, 13, 12, 6, 1, 7, 6, 13, 19, 14, 13, 7, 2, 8, 7, 14, 20, 15,
                                      14, 8, 3, 9, 8, 15, 21, 16, 15, 9, 4, 10, 9, 16, 22, 17, 16, 10, 5, 11, 10, 17, 11);
  Dode_Draw : Array[1..51] of Byte  = (2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
                                      20, 16, 12, 8, 4, 20, 1, 2, 3, 35, 36, 37, 38, 39, 40,
                                      21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 28, 24, 40, 36, 32, 2);
  SCALE_FACTOR = 100;
var
  Form1: TForm1;
  Poly : TPolyeder;
  Dual : TPolyeder;
  SineTable : Array[0..359999] of Double;
  Count : LongInt;
  PolyFile : File of TPolyRec;
  Mx, My : Integer;
  MLB, MRB, MMB : Boolean;


implementation

{$R *.dfm}


Function Make_Dual(P1 : TPolyeder) : TPolyeder;
Var
  T : TPolyeder;
  TR : TPolyRec;
  I : Integer;
Begin
  Case P1.PolyederTyp of
    Tetraeder : LoadFromFile(TR, Tetraeder);
    Oktaeder  : LoadFromFile(TR, Hexaeder);
    Hexaeder  : LoadFromFile(TR, Oktaeder);
    Ikosaeder  : LoadFromFile(TR, Dodekaeder);
    Dodekaeder  : LoadFromFile(TR, Ikosaeder);
  End;
  With T do begin
    PolyederTyp := TR.PolyederTyp;
    NumberOfPoints := TR.NumberOfPoints;
    NumberOfDraws := TR.NumberOfDraws;
    RotationAngle := TR.RotationAngle;
    For I := 1 to 255 do
    Begin
      Draw[I] := TR.Draw[I];
      Ecken[I] := TR.Ecken[I];
    End;
  End;

  If T.PolyederTyp = Tetraeder then
  Begin
    T.Ecken[1] := Get_Tri_Mid(P1.Ecken[2], P1.Ecken[3], P1.Ecken[4]);
    T.Ecken[2] := Get_Tri_Mid(P1.Ecken[1], P1.Ecken[2], P1.Ecken[4]);
    T.Ecken[3] := Get_Tri_Mid(P1.Ecken[1], P1.Ecken[3], P1.Ecken[4]);
    T.Ecken[4] := Get_Tri_Mid(P1.Ecken[1], P1.Ecken[2], P1.Ecken[3]);
    T.Ecken[5] := Get_Tri_Mid(P1.Ecken[1], P1.Ecken[2], P1.Ecken[3]);
    T.Ecken[6] := Get_Tri_Mid(P1.Ecken[1], P1.Ecken[2], P1.Ecken[3]);
  End else
  
  If T.PolyederTyp = Hexaeder then
  Begin
    T.Ecken[1] := Get_Tri_Mid(P1.Ecken[1], P1.Ecken[2], P1.Ecken[6]);
    T.Ecken[2] := Get_Tri_Mid(P1.Ecken[2], P1.Ecken[4], P1.Ecken[9]);
    T.Ecken[3] := Get_Tri_Mid(P1.Ecken[2], P1.Ecken[3], P1.Ecken[4]);
    T.Ecken[4] := Get_Tri_Mid(P1.Ecken[1], P1.Ecken[2], P1.Ecken[3]);

    T.Ecken[5] := Get_Tri_Mid(P1.Ecken[7], P1.Ecken[5], P1.Ecken[1]);
    T.Ecken[9] := T.Ecken[5];
    T.Ecken[11] := T.Ecken[5];
    T.Ecken[6] := Get_Tri_Mid(P1.Ecken[5], P1.Ecken[7], P1.Ecken[4]);
    T.Ecken[10] := T.Ecken[6];
    T.Ecken[12] := T.Ecken[6];
    T.Ecken[7] := Get_Tri_Mid(P1.Ecken[1], P1.Ecken[3], P1.Ecken[5]);
    T.Ecken[13] := T.Ecken[7];
    T.Ecken[8] := Get_Tri_Mid(P1.Ecken[3], P1.Ecken[4], P1.Ecken[5]);
    T.Ecken[14] := T.Ecken[8];
  End else
  
  If T.PolyederTyp = Oktaeder then
  Begin
    T.Ecken[1] := Get_Qua_Mid(P1.Ecken[1], P1.Ecken[2], P1.Ecken[3], P1.Ecken[4]);
    T.Ecken[2] := Get_Qua_Mid(P1.Ecken[1], P1.Ecken[2], P1.Ecken[5], P1.Ecken[6]);
    T.Ecken[3] := Get_Qua_Mid(P1.Ecken[2], P1.Ecken[12], P1.Ecken[3], P1.Ecken[14]);
    T.Ecken[4] := Get_Qua_Mid(P1.Ecken[7], P1.Ecken[8], P1.Ecken[9], P1.Ecken[10]);
    T.Ecken[5] := Get_Qua_Mid(P1.Ecken[3], P1.Ecken[4], P1.Ecken[7], P1.Ecken[8]);
    T.Ecken[6] := Get_Qua_Mid(P1.Ecken[1], P1.Ecken[4], P1.Ecken[11], P1.Ecken[13]);
    T.Ecken[7] := Get_Qua_Mid(P1.Ecken[1], P1.Ecken[4], P1.Ecken[11], P1.Ecken[13]);
    T.Ecken[8] := Get_Qua_Mid(P1.Ecken[7], P1.Ecken[8], P1.Ecken[9], P1.Ecken[10]);
    T.Ecken[9] := Get_Qua_Mid(P1.Ecken[1], P1.Ecken[4], P1.Ecken[11], P1.Ecken[13]);
    T.Ecken[10] := Get_Qua_Mid(P1.Ecken[7], P1.Ecken[8], P1.Ecken[9], P1.Ecken[10]);
  End else

  If T.PolyederTyp = Ikosaeder then
  Begin
    T.Ecken[1] := Get_Cin_Mid(P1.Ecken[4], P1.Ecken[8], P1.Ecken[12], P1.Ecken[16], P1.Ecken[20]);
    T.Ecken[2] := Get_Cin_Mid(P1.Ecken[4], P1.Ecken[8], P1.Ecken[12], P1.Ecken[16], P1.Ecken[20]);
    T.Ecken[3] := Get_Cin_Mid(P1.Ecken[4], P1.Ecken[8], P1.Ecken[12], P1.Ecken[16], P1.Ecken[20]);
    T.Ecken[4] := Get_Cin_Mid(P1.Ecken[4], P1.Ecken[8], P1.Ecken[12], P1.Ecken[16], P1.Ecken[20]);
    T.Ecken[5] := Get_Cin_Mid(P1.Ecken[4], P1.Ecken[8], P1.Ecken[12], P1.Ecken[16], P1.Ecken[20]);

    T.Ecken[18] := Get_Cin_Mid(P1.Ecken[24], P1.Ecken[28], P1.Ecken[32], P1.Ecken[36], P1.Ecken[40]);
    T.Ecken[19] := Get_Cin_Mid(P1.Ecken[24], P1.Ecken[28], P1.Ecken[32], P1.Ecken[36], P1.Ecken[40]);
    T.Ecken[20] := Get_Cin_Mid(P1.Ecken[24], P1.Ecken[28], P1.Ecken[32], P1.Ecken[36], P1.Ecken[40]);
    T.Ecken[21] := Get_Cin_Mid(P1.Ecken[24], P1.Ecken[28], P1.Ecken[32], P1.Ecken[36], P1.Ecken[40]);
    T.Ecken[22] := Get_Cin_Mid(P1.Ecken[24], P1.Ecken[28], P1.Ecken[32], P1.Ecken[36], P1.Ecken[40]);

    T.Ecken[6] := Get_Cin_Mid(P1.Ecken[20], P1.Ecken[1], P1.Ecken[2], P1.Ecken[3], P1.Ecken[4]);
    T.Ecken[7] := Get_Cin_Mid(P1.Ecken[4], P1.Ecken[5], P1.Ecken[6], P1.Ecken[7], P1.Ecken[8]);
    T.Ecken[8] := Get_Cin_Mid(P1.Ecken[8], P1.Ecken[9], P1.Ecken[10], P1.Ecken[11], P1.Ecken[12]);
    T.Ecken[9] := Get_Cin_Mid(P1.Ecken[12], P1.Ecken[13], P1.Ecken[14], P1.Ecken[15], P1.Ecken[16]);
    T.Ecken[10] := Get_Cin_Mid(P1.Ecken[16], P1.Ecken[17], P1.Ecken[18], P1.Ecken[19], P1.Ecken[20]);
    T.Ecken[11] := Get_Cin_Mid(P1.Ecken[20], P1.Ecken[1], P1.Ecken[2], P1.Ecken[3], P1.Ecken[4]);
    T.Ecken[12] := Get_Cin_Mid(P1.Ecken[28], P1.Ecken[29], P1.Ecken[30], P1.Ecken[31], P1.Ecken[32]);
    T.Ecken[13] := Get_Cin_Mid(P1.Ecken[2], P1.Ecken[3], P1.Ecken[35], P1.Ecken[36], P1.Ecken[32]);
    T.Ecken[14] := Get_Cin_Mid(P1.Ecken[36], P1.Ecken[37], P1.Ecken[38], P1.Ecken[39], P1.Ecken[40]);
    T.Ecken[15] := Get_Cin_Mid(P1.Ecken[40], P1.Ecken[21], P1.Ecken[22], P1.Ecken[23], P1.Ecken[24]);
    T.Ecken[16] := Get_Cin_Mid(P1.Ecken[24], P1.Ecken[25], P1.Ecken[26], P1.Ecken[27], P1.Ecken[28]);
    T.Ecken[17] := Get_Cin_Mid(P1.Ecken[28], P1.Ecken[29], P1.Ecken[30], P1.Ecken[31], P1.Ecken[32])
  End else
  
  If T.PolyederTyp = Dodekaeder then
  Begin
    T.Ecken[1] := Get_Tri_Mid(P1.Ecken[1], P1.Ecken[6], P1.Ecken[7]);
    T.Ecken[2] := Get_Tri_Mid(P1.Ecken[2], P1.Ecken[7], P1.Ecken[8]);
    T.Ecken[3] := Get_Tri_Mid(P1.Ecken[7], P1.Ecken[8], P1.Ecken[14]);
    T.Ecken[4] := Get_Tri_Mid(P1.Ecken[7], P1.Ecken[13], P1.Ecken[14]);
    T.Ecken[5] := Get_Tri_Mid(P1.Ecken[7], P1.Ecken[8], P1.Ecken[14]);
    T.Ecken[6] := Get_Tri_Mid(P1.Ecken[8], P1.Ecken[14], P1.Ecken[15]);
    T.Ecken[7] := Get_Tri_Mid(P1.Ecken[14], P1.Ecken[15], P1.Ecken[20]);
    T.Ecken[8] := Get_Tri_Mid(P1.Ecken[13], P1.Ecken[14], P1.Ecken[19]);
    T.Ecken[9] := Get_Tri_Mid(P1.Ecken[14], P1.Ecken[15], P1.Ecken[20]);
    T.Ecken[10] := Get_Tri_Mid(P1.Ecken[15], P1.Ecken[16], P1.Ecken[21]);
    T.Ecken[11] := Get_Tri_Mid(P1.Ecken[16], P1.Ecken[17], P1.Ecken[22]);
    T.Ecken[12] := Get_Tri_Mid(P1.Ecken[12], P1.Ecken[13], P1.Ecken[18]);
    T.Ecken[13] := Get_Tri_Mid(P1.Ecken[16], P1.Ecken[17], P1.Ecken[22]);
    T.Ecken[14] := Get_Tri_Mid(P1.Ecken[10], P1.Ecken[16], P1.Ecken[17]);
    T.Ecken[15] := Get_Tri_Mid(P1.Ecken[10], P1.Ecken[11], P1.Ecken[17]);
    T.Ecken[16] := Get_Tri_Mid(P1.Ecken[6], P1.Ecken[12], P1.Ecken[13]);
    T.Ecken[17] := Get_Tri_Mid(P1.Ecken[10], P1.Ecken[11], P1.Ecken[17]);
    T.Ecken[18] := Get_Tri_Mid(P1.Ecken[5], P1.Ecken[10], P1.Ecken[11]);
    T.Ecken[19] := Get_Tri_Mid(P1.Ecken[1], P1.Ecken[6], P1.Ecken[7]);
    T.Ecken[20] := Get_Tri_Mid(P1.Ecken[6], P1.Ecken[7], P1.Ecken[13]);

    T.Ecken[21] := Get_Tri_Mid(P1.Ecken[15], P1.Ecken[16], P1.Ecken[21]);
    T.Ecken[22] := Get_Tri_Mid(P1.Ecken[16], P1.Ecken[17], P1.Ecken[22]);
    T.Ecken[23] := Get_Tri_Mid(P1.Ecken[10], P1.Ecken[16], P1.Ecken[17]);
    T.Ecken[24] := Get_Tri_Mid(P1.Ecken[9], P1.Ecken[10], P1.Ecken[16]);

    T.Ecken[25] := Get_Tri_Mid(P1.Ecken[10], P1.Ecken[16], P1.Ecken[17]);
    T.Ecken[26] := Get_Tri_Mid(P1.Ecken[10], P1.Ecken[11], P1.Ecken[17]);
    T.Ecken[27] := Get_Tri_Mid(P1.Ecken[5], P1.Ecken[10], P1.Ecken[11]);
    T.Ecken[28] := Get_Tri_Mid(P1.Ecken[4], P1.Ecken[9], P1.Ecken[10]);

    T.Ecken[29] := Get_Tri_Mid(P1.Ecken[5], P1.Ecken[10], P1.Ecken[11]);
    T.Ecken[30] := Get_Tri_Mid(P1.Ecken[1], P1.Ecken[6], P1.Ecken[7]);
    T.Ecken[31] := Get_Tri_Mid(P1.Ecken[2], P1.Ecken[7], P1.Ecken[8]);
    T.Ecken[32] := Get_Tri_Mid(P1.Ecken[3], P1.Ecken[8], P1.Ecken[9]);

    T.Ecken[33] := Get_Tri_Mid(P1.Ecken[7], P1.Ecken[8], P1.Ecken[14]);
    T.Ecken[34] := Get_Tri_Mid(P1.Ecken[2], P1.Ecken[7], P1.Ecken[8]);
    T.Ecken[35] := Get_Tri_Mid(P1.Ecken[8], P1.Ecken[14], P1.Ecken[15]);
    T.Ecken[36] := Get_Tri_Mid(P1.Ecken[8], P1.Ecken[9], P1.Ecken[15]);
  
    T.Ecken[37] := Get_Tri_Mid(P1.Ecken[8], P1.Ecken[14], P1.Ecken[15]);
    T.Ecken[38] := Get_Tri_Mid(P1.Ecken[14], P1.Ecken[15], P1.Ecken[20]);
    T.Ecken[39] := Get_Tri_Mid(P1.Ecken[15], P1.Ecken[16], P1.Ecken[21]);
    T.Ecken[40] := Get_Tri_Mid(P1.Ecken[9], P1.Ecken[15], P1.Ecken[16]);
  End;



  Result := T;
End;


Function Get_Tri_Mid(V1, V2, V3 : TVektor) : TVektor;
Var
  T : TVektor;
Begin
  T.X := (V1.X + V2.X + V3.X) / 3;
  T.Y := (V1.Y + V2.Y + V3.Y) / 3;
  T.Z := (V1.Z + V2.Z + V3.Z) / 3;
  Result := T;
End;
  
Function Get_Qua_Mid(V1, V2, V3, V4 : TVektor) : TVektor;
Var
  T : TVektor;
Begin
  T.X := (V1.X + V2.X + V3.X + V4.X) / 4;
  T.Y := (V1.Y + V2.Y + V3.Y + V4.Y) / 4;
  T.Z := (V1.Z + V2.Z + V3.Z + V4.Z) / 4;
  Result := T;
End;


Function Get_Cin_Mid(V1, V2, V3, V4, V5 : TVektor) : TVektor;
Var
  T : TVektor;
Begin
  T.X := (V1.X + V2.X + V3.X + V4.X + V5.X) / 5;
  T.Y := (V1.Y + V2.Y + V3.Y + V4.Y + V5.Y) / 5;
  T.Z := (V1.Z + V2.Z + V3.Z + V4.Z + V5.Z) / 5;
  Result := T;
End;




Procedure LoadFromFile(Var Polyeder : TPolyRec; PolyType : TPolyType);
Var
  T : TPolyRec;
Begin         
  AssignFile(PolyFile, 'Polyeder.dat');
  Reset(PolyFile);
  Repeat
    Read(PolyFile, T);
  Until (T.PolyederTyp = PolyType) or (EOF(PolyFile));
  Polyeder := T;   
  CloseFile(PolyFile);
End;

Procedure SaveToFile(Polyeder : TPolyRec);
Var
  T : TPolyRec;
  I : Byte;
Begin
  AssignFile(PolyFile, 'Polyeder.dat');
  If FileExists('Polyeder.dat') then Reset(PolyFile) else
   Rewrite(PolyFile);
  I := 0;
  If not EOF(PolyFile) then
  Repeat
    Read(PolyFile, T);
    If T.PolyederTyp <> Polyeder.PolyederTyp then Inc(I);
  Until (T.PolyederTyp = Polyeder.PolyederTyp) or (EOF(PolyFile));
  If Polyeder.PolyederTyp = T.PolyederTyp then
    Seek(PolyFile, I);
  Write(PolyFile, Polyeder);
  CloseFile(PolyFile);
End;



Function Sine(Deg : Double) : Double;
Var
  T : LongInt;
Begin
  While Deg < 0 do Deg := Deg + 360;
  T := Round(Deg*1000);
  T := T mod 360000;
  Result := SineTable[T];
End;

Function Cose(Deg : Double) : Double;
Begin
  Result := Sine(Deg + 90);
End;

Procedure RotX(Var Punkt : TVektor; Deg : Double);
Var
 Y, Z : Double;
Begin
  Y := Punkt.Y * Sine(Deg + 90) - Punkt.Z * Sine(Deg);
  Z := Punkt.Y * Sine(Deg)      + Punkt.Z * Sine(Deg + 90);
  Punkt.Y := Y;
  Punkt.Z := Z;
End;

Procedure RotY(Var Punkt : TVektor; Deg : Double);
Var
 X, Z : Double;
Begin
  X := Punkt.X * Sine(Deg + 90) + Punkt.Z * Sine(Deg);
  Z := Punkt.Z * Sine(Deg + 90) - Punkt.X * Sine(Deg );
  Punkt.X := X;
  Punkt.Z := Z;
End;

Procedure RotZ(Var Punkt : TVektor; Deg : Double);
Var
 X, Y : Double;
Begin
  X := Punkt.X * Sine(Deg + 90) - Punkt.Y * Sine(Deg);
  Y := Punkt.X * Sine(Deg)      + Punkt.Y * Sine(Deg + 90);
  Punkt.X := X;
  Punkt.Y := Y;
End;

Procedure RotG(Var Punkt : TVektor; P1, P2 : TVektor; Deg : Double);
Var
  P2P1, P2P, NOV, S : TVektor;
  L, H, LH : Double;
Begin
  P2P1.X := (P1.X - P2.X);
  P2P1.Y := (P1.Y - P2.Y);
  P2P1.Z := (P1.Z - P2.Z);

  P1.X := P1.X + 10 * P2P1.X;
  P1.Y := P1.Y + 10 * P2P1.Y;
  P1.Z := P1.Z + 10 * P2P1.Z;
  P2.X := P2.X - 10 * P2P1.X;
  P2.Y := P2.Y - 10 * P2P1.Y;
  P2.Z := P2.Z - 10 * P2P1.Z;
  P2P1.X := (P1.X - P2.X);
  P2P1.Y := (P1.Y - P2.Y);
  P2P1.Z := (P1.Z - P2.Z);

  P2P.X := (Punkt.X - P2.X);
  P2P.Y := (Punkt.Y - P2.Y);
  P2P.Z := (Punkt.Z - P2.Z);

  NOV := CrossP(P2P1, P2P);

  H := NOV.Norm/P2P1.Norm;
  If H < P2P.Norm then
    LH := Sqrt(Sqr(P2P.Norm)-Sqr(H))
  else  LH := 0;
  P2P1 := P2P1.MakeUnit;

  S.X := P2.X + P2P1.X * LH;
  S.Y := P2.Y + P2P1.Y * LH;
  S.Z := P2.Z + P2P1.Z * LH;

  P2P.X := (Punkt.X - S.X);
  P2P.Y := (Punkt.Y - S.Y);
  P2P.Z := (Punkt.Z - S.Z);

  H := Sine(Deg) * P2P.Norm;
  L := Sine(Deg + 90) * P2P.Norm;

  NOV := NOV.MakeUnit;
  P2P := P2P.MakeUnit;

  Punkt.X := S.X + (P2P.X * L) + (NOV.X * H);
  Punkt.Y := S.Y + (P2P.Y * L) + (NOV.Y * H);
  Punkt.Z := S.Z + (P2P.Z * L) + (NOV.Z * H);
End;

Function CrossP(V1, V2 : TVektor) : TVektor;
Var
  T : TVektor;
Begin
  T.X := V1.Y*V2.Z - V2.Y*V1.Z;
  T.Y := V1.Z*V2.X - V2.Z*V1.X;
  T.Z := V1.X*V2.Y - V2.X*V1.Y;
  Result := T;
End;

Function DotP(V1, V2 : TVektor) : Double;
Begin
  Result := V1.X*V2.X + V1.Y*V2.Y + V1.Z*V2.Z;
End;


Function TVektor.Norm : Double;
Begin
  Result := Sqrt(X*X + Y*Y + Z*Z);
End;

Function TVektor.MakeUnit : TVektor;
Var
  T : TVektor;
Begin
  T.X := X / Norm;
  T.Y := Y / Norm;
  T.Z := Z / Norm;
  Result := T;
End;

Procedure TPolyeder.Init(Side_Length : Double; PolyType : TPolyType);
Var
  I : Integer;
 // Side_Height : Double;
  PolyRec : TPolyRec;
Begin
  LoadFromFile(PolyRec, PolyType);
  PolyederTyp := PolyRec.PolyederTyp;
  NumberOfPoints := PolyRec.NumberOfPoints;
  NumberOfDraws := PolyRec.NumberOfDraws;
  RotationAngle := PolyRec.RotationAngle;
  For I := 1 to 255 do
  Begin
    Ecken[I] := PolyRec.Ecken[I];
    Draw[I] := PolyRec.Draw[I];
  End;
  For I := 1 to 20 do
    Knicke[I] := PolyRec.Knicke[I];
  Scale(Side_Length / 100);
End;
          {

Procedure TPolyeder.Init(Side_Length : Double; PolyType : TPolyType);
Var
  I : Integer;
  PolyRec : TPolyRec;
  Side_Height : Double;
  Side_K : Double;
  Side_S : Double;
Begin
  If PolyType = Tetraeder then
  Begin
  Side_Height := Side_Length / 2 * Sqrt(3);
  NumberOfDraws := 10;
  NumberOfPoints := 6;
  PolyederTyp := PolyType;
  RotationAngle := (180 - (ArcCos(1/3) * 180 / PI)) / 100;
  For I := 1 to NumberOfPoints do
  Begin
   Ecken[I].Z := -Side_Height / 3;
  End;
  Ecken[4].X := Side_Length;
  Ecken[4].Y := -Side_Height/3*2;
  Ecken[5].X := -Side_Length;
  Ecken[5].Y := -Side_Height/3*2;
  Ecken[6].X := 0;
  Ecken[6].Y := Side_Height/3*4;

  Ecken[1].X := (Ecken[5].X + Ecken[6].X) / 2;
  Ecken[1].Y := (Ecken[5].Y + Ecken[6].Y) / 2;
  Ecken[2].X := (Ecken[4].X + Ecken[6].X) / 2;
  Ecken[2].Y := (Ecken[4].Y + Ecken[6].Y) / 2;
  Ecken[3].X := (Ecken[4].X + Ecken[5].X) / 2;
  Ecken[3].Y := (Ecken[4].Y + Ecken[5].Y) / 2;

  For I := 1 to NumberOfDraws do
  Draw[I] := Tetra_Draw[I];
  
  For I := 1 to 20 do
   Knicke[I].Anz := 0;

  Knicke[1].Anz := 1;
  Knicke[1].Who[1] := 4;
  Knicke[1].Ger[1] := 2;
  Knicke[1].Ger[2] := 3;
  Knicke[1].Dir := -1;


    Knicke[2].Anz := 1;
    Knicke[2].Who[1] := 5;
    Knicke[2].Ger[1] := 1;
    Knicke[2].Ger[2] := 3;
    Knicke[2].Dir := 1;


    Knicke[3].Anz := 1;
    Knicke[3].Who[1] := 6;
    Knicke[3].Ger[1] := 1;
    Knicke[3].Ger[2] := 2;
    Knicke[3].Dir := -1;

  end else
  If PolyType = Hexaeder then
  Begin


  NumberOfDraws := 20;
  NumberOfPoints := 14;
  RotationAngle := 90 / 100;
  PolyederTyp := PolyType;
  For I := 1 to 14 do Ecken[I].Z := Side_Length / 2;
  Ecken[1].X := -Side_Length / 2;
  Ecken[1].Y := Side_Length / 2;
  Ecken[2].X := Side_Length / 2;
  Ecken[2].Y := Side_Length / 2;
  Ecken[3].X := Side_Length / 2;
  Ecken[3].Y := -Side_Length / 2;
  Ecken[4].X := -Side_Length / 2;
  Ecken[4].Y := -Side_Length / 2;

  Ecken[5].X := -Side_Length / 2;
  Ecken[5].Y := Side_Length / 2 * 3;
  Ecken[6].X := Side_Length / 2;
  Ecken[6].Y := Side_Length / 2 * 3;
  Ecken[7].X := -Side_Length / 2;
  Ecken[7].Y := -Side_Length / 2 * 3;
  Ecken[8].X := Side_Length / 2;
  Ecken[8].Y := -Side_Length / 2 * 3;
  Ecken[9].X := -Side_Length / 2;
  Ecken[9].Y := -Side_Length / 2 * 5;
  Ecken[10].X := Side_Length / 2;
  Ecken[10].Y := -Side_Length / 2 * 5;
  Ecken[11].X := -Side_Length / 2 * 3;
  Ecken[11].Y := Side_Length / 2;
  Ecken[12].X := Side_Length / 2 * 3;
  Ecken[12].Y := Side_Length / 2;
  Ecken[13].X := -Side_Length / 2 * 3;
  Ecken[13].Y := -Side_Length / 2;
  Ecken[14].X := Side_Length / 2 * 3;
  Ecken[14].Y := -Side_Length / 2;
  For I := 1 To NumberOfDraws do
  Draw[I] := Hexa_Draw[I];

  For I := 1 to 20 do
   Knicke[I].Anz := 0;

  Knicke[1].Anz := 2;
  Knicke[1].Who[1] := 5;
  Knicke[1].Who[2] := 6;
  Knicke[1].Ger[1] := 1;
  Knicke[1].Ger[2] := 2;
  Knicke[1].Dir := 1;


  Knicke[2].Anz := 2;
  Knicke[2].Who[1] := 11;
  Knicke[2].Who[2] := 13;
  Knicke[2].Ger[1] := 1;
  Knicke[2].Ger[2] := 4;
  Knicke[2].Dir := -1;


  Knicke[3].Anz := 2;
  Knicke[3].Who[1] := 12;
  Knicke[3].Who[2] := 14;
  Knicke[3].Ger[1] := 2;
  Knicke[3].Ger[2] := 3;
  Knicke[3].Dir := 1;

  Knicke[4].Anz := 4;
  Knicke[4].Who[1] := 7;
  Knicke[4].Who[2] := 8;
  Knicke[4].Who[3] := 9;
  Knicke[4].Who[4] := 10;
  Knicke[4].Ger[1] := 3;
  Knicke[4].Ger[2] := 4;
  Knicke[4].Dir := 1;
  
  Knicke[5].Anz := 2;
  Knicke[5].Who[1] := 9;
  Knicke[5].Who[2] := 10;
  Knicke[5].Ger[1] := 7;
  Knicke[5].Ger[2] := 8;
  Knicke[5].Dir := -1;

  End else




  If PolyType = Oktaeder then
  Begin


  Side_Height := Side_Length / 2 * Sqrt(3);
  NumberOfDraws := 20;
  NumberOfPoints := 10;
  PolyederTyp := PolyType;
  RotationAngle := (180 - ArcCos(Sqr(Side_Length)/(-2*Side_Height*Side_Length)) * 360 / PI) / 100;
  For I := 1 to NumberOfPoints do Ecken[I].Z := -Side_Height / 3;
  Ecken[4].X := Side_Length;
  Ecken[4].Y := -Side_Height/3*2;
  Ecken[5].X := -Side_Length;
  Ecken[5].Y := -Side_Height/3*2;
  Ecken[6].X := 0;
  Ecken[6].Y := Side_Height/3*4;

  Ecken[1].X := (Ecken[5].X + Ecken[6].X) / 2;
  Ecken[1].Y := (Ecken[5].Y + Ecken[6].Y) / 2;
  Ecken[2].X := (Ecken[4].X + Ecken[6].X) / 2;
  Ecken[2].Y := (Ecken[4].Y + Ecken[6].Y) / 2;
  Ecken[3].X := (Ecken[4].X + Ecken[5].X) / 2;
  Ecken[3].Y := (Ecken[4].Y + Ecken[5].Y) / 2;

  Ecken[7].X := -Side_Length / 2 * 3;
  Ecken[7].Y := Side_Height/3;
  Ecken[8].X := -Side_Length * 2;
  Ecken[8].Y := -Side_Height/3*2;
  Ecken[9].X := Side_Length /2 * 3;
  Ecken[9].Y := Side_Height/3;
  Ecken[10].X := -Side_Length / 2;
  Ecken[10].Y := -Side_Height/3*5;
  
  For I := 1 to 20 do
   Knicke[I].Anz := 0;

    Knicke[1].Anz := 1;
    Knicke[1].Who[1] := 8;
    Knicke[1].Ger[1] := 7;
    Knicke[1].Ger[2] := 5;
    Knicke[1].Dir := -1;
    Knicke[2].Anz := 1;
    Knicke[2].Who[1] := 9;
    Knicke[2].Ger[1] := 2;
    Knicke[2].Ger[2] := 4;
    Knicke[2].Dir := 1;
    Knicke[3].Anz := 1;
    Knicke[3].Who[1] := 6;
    Knicke[3].Ger[1] := 1;
    Knicke[3].Ger[2] := 2;
    Knicke[3].Dir := 1;
    Knicke[4].Anz := 1;
    Knicke[4].Who[1] := 10;
    Knicke[4].Ger[1] := 5;
    Knicke[4].Ger[2] := 3;
    Knicke[4].Dir := -1;
    Knicke[5].Anz := 2;
    Knicke[5].Who[1] := 7;
    Knicke[5].Who[2] := 8;
    Knicke[5].Ger[1] := 5;
    Knicke[5].Ger[2] := 1;
    Knicke[5].Dir := 1;
    Knicke[6].Anz := 2;
    Knicke[6].Who[1] := 9;
    Knicke[6].Who[2] := 4;
    Knicke[6].Ger[1] := 2;
    Knicke[6].Ger[2] := 3;
    Knicke[6].Dir := 1;
    Knicke[7].Anz := 4;
    Knicke[7].Who[1] := 7;
    Knicke[7].Who[2] := 8;
    Knicke[7].Who[3] := 5;
    Knicke[7].Who[4] := 10;
    Knicke[7].Ger[1] := 1;
    Knicke[7].Ger[2] := 3;
    Knicke[7].Dir := -1;
    For I := 1 to NumberOfDraws do
    Draw[I] := Okta_Draw[I];
  End else



  If PolyType = Ikosaeder then Begin
    Side_Height := Side_Length / 2 * Sqrt(3);
    NumberOfDraws := 42;
    NumberOfPoints := 22;
    PolyederTyp := PolyType;
    RotationAngle := (41.8) / 100;
    For I := 1 to NumberOfPoints do Ecken[I].Z := Side_Length / 4 * 3;
    Ecken[1].X := -Side_Length * 2;
    Ecken[1].Y := Side_Height/2*3;
    Ecken[2].X := -Side_Length;
    Ecken[2].Y := Side_Height/2*3;
    Ecken[3].X := 0;
    Ecken[3].Y := Side_Height/2*3;
    Ecken[4].X := Side_Length;
    Ecken[4].Y := Side_Height/2*3;
    Ecken[5].X := Side_Length * 2;
    Ecken[5].Y := Side_Height/2*3;

    Ecken[6].X := -Side_Length / 2 * 5;
    Ecken[6].Y := Side_Height/2;
    Ecken[7].X := -Side_Length / 2 * 3;
    Ecken[7].Y := Side_Height/2;
    Ecken[8].X := -Side_Length / 2;
    Ecken[8].Y := Side_Height/2;
    Ecken[9].X := Side_Length / 2;
    Ecken[9].Y := Side_Height/2;
    Ecken[10].X := Side_Length / 2 * 3;
    Ecken[10].Y := Side_Height/2;
    Ecken[11].X := Side_Length / 2 * 5;
    Ecken[11].Y := Side_Height/2;

    Ecken[12].X := -Side_Length * 3;
    Ecken[12].Y := -Side_Height/2;
    Ecken[13].X := -Side_Length * 2;
    Ecken[13].Y := -Side_Height/2;
    Ecken[14].X := -Side_Length;
    Ecken[14].Y := -Side_Height/2;
    Ecken[15].X := 0;
    Ecken[15].Y := -Side_Height/2;
    Ecken[16].X := Side_Length;
    Ecken[16].Y := -Side_Height/2;
    Ecken[17].X := Side_Length * 2;
    Ecken[17].Y := -Side_Height/2;

    Ecken[18].X := -Side_Length /2 * 5;
    Ecken[18].Y := -Side_Height/2 * 3;
    Ecken[19].X := -Side_Length /2 * 3;
    Ecken[19].Y := -Side_Height/2 * 3;
    Ecken[20].X := -Side_Length /2;
    Ecken[20].Y := -Side_Height/2 * 3;
    Ecken[21].X := Side_Length /2;
    Ecken[21].Y := -Side_Height/2 * 3;
    Ecken[22].X := Side_Length /2 * 3;
    Ecken[22].Y := -Side_Height/2 * 3;
    For I := 1 to NumberOfPoints do Ecken[I].Y := Ecken[I].Y - Side_Length / 8;


    For I := 1 to NumberOfDraws do
    Draw[I] := IKO_Draw[I];
  
    For I := 1 to 20 do
     Knicke[I].Anz := 0;
    Knicke[1].Anz := 2;
    Knicke[1].Who[1] := 12;
    Knicke[1].Who[2] := 18;
    Knicke[1].Ger[1] := 6;
    Knicke[1].Ger[2] := 13;
    Knicke[1].Dir := -1;

    Knicke[2].Anz := 2;
    Knicke[2].Who[1] := 5;
    Knicke[2].Who[2] := 11;
    Knicke[2].Ger[1] := 10;
    Knicke[2].Ger[2] := 17;
    Knicke[2].Dir := 1;

    Knicke[3].Anz := 4;
    Knicke[3].Who[1] := 1;
    Knicke[3].Who[2] := 6;
    Knicke[3].Who[3] := 12;
    Knicke[3].Who[4] := 18;
    Knicke[3].Ger[1] := 7;
    Knicke[3].Ger[2] := 13;
    Knicke[3].Dir := -1;

    Knicke[4].Anz := 4;
    Knicke[4].Who[1] := 11;
    Knicke[4].Who[2] := 17;
    Knicke[4].Who[3] := 22;
    Knicke[4].Who[4] := 5;
    Knicke[4].Ger[1] := 10;
    Knicke[4].Ger[2] := 16;
    Knicke[4].Dir := 1;

    Knicke[5].Anz := 6;
    Knicke[5].Who[1] := 6;
    Knicke[5].Who[2] := 13;
    Knicke[5].Who[3] := 19;
    Knicke[5].Who[4] := 12;
    Knicke[5].Who[5] := 18;
    Knicke[5].Who[6] := 1;
    Knicke[5].Ger[1] := 7;
    Knicke[5].Ger[2] := 14;
    Knicke[5].Dir := -1;

    Knicke[6].Anz := 6;
    Knicke[6].Who[1] := 4;
    Knicke[6].Who[2] := 10;
    Knicke[6].Who[3] := 17;
    Knicke[6].Who[4] := 5;
    Knicke[6].Who[5] := 11;
    Knicke[6].Who[6] := 22;
    Knicke[6].Ger[1] := 9;
    Knicke[6].Ger[2] := 16;
    Knicke[6].Dir := 1;

    Knicke[7].Anz := 8;
    Knicke[7].Who[1] := 1;
    Knicke[7].Who[2] := 6;
    Knicke[7].Who[3] := 12;
    Knicke[7].Who[4] := 7;
    Knicke[7].Who[5] := 13;
    Knicke[7].Who[6] := 18;
    Knicke[7].Who[7] := 2;       
    Knicke[7].Who[8] := 19;
    Knicke[7].Ger[1] := 8;
    Knicke[7].Ger[2] := 14;
    Knicke[7].Dir := -1;

    Knicke[8].Anz := 8;
    Knicke[8].Who[1] := 11;
    Knicke[8].Who[2] := 17;
    Knicke[8].Who[3] := 22;
    Knicke[8].Who[4] := 5;
    Knicke[8].Who[5] := 10;
    Knicke[8].Who[6] := 16;
    Knicke[8].Who[7] := 21;
    Knicke[8].Who[8] := 4;
    Knicke[8].Ger[1] := 9;
    Knicke[8].Ger[2] := 15;
    Knicke[8].Dir := 1;

    Knicke[9].Anz := 10;
    Knicke[9].Who[1] := 12;
    Knicke[9].Who[2] := 18;
    Knicke[9].Who[3] := 6;
    Knicke[9].Who[4] := 13;
    Knicke[9].Who[5] := 19;
    Knicke[9].Who[6] := 1;
    Knicke[9].Who[7] := 7;
    Knicke[9].Who[8] := 14;
    Knicke[9].Who[9] := 20;
    Knicke[9].Who[10] := 2;
    Knicke[9].Ger[1] := 8;
    Knicke[9].Ger[2] := 15;
    Knicke[9].Dir := -1;

    Knicke[10].Anz := 1;
    Knicke[10].Who[1] := 1;
    Knicke[10].Ger[1] := 6;
    Knicke[10].Ger[2] := 7;
    Knicke[10].Dir := 1;

    Knicke[11].Anz := 1;
    Knicke[11].Who[1] := 18;
    Knicke[11].Ger[1] := 12;
    Knicke[11].Ger[2] := 13;
    Knicke[11].Dir := -1;
    
    Knicke[12].Anz := 1;
    Knicke[12].Who[1] := 2;
    Knicke[12].Ger[1] := 7;
    Knicke[12].Ger[2] := 8;
    Knicke[12].Dir := 1;

    Knicke[13].Anz := 1;
    Knicke[13].Who[1] := 19;
    Knicke[13].Ger[1] := 13;
    Knicke[13].Ger[2] := 14;
    Knicke[13].Dir := -1;

    Knicke[14].Anz := 1;
    Knicke[14].Who[1] := 3;
    Knicke[14].Ger[1] := 8;
    Knicke[14].Ger[2] := 9;
    Knicke[14].Dir := 1;

    Knicke[15].Anz := 1;
    Knicke[15].Who[1] := 20;
    Knicke[15].Ger[1] := 14;
    Knicke[15].Ger[2] := 15;
    Knicke[15].Dir := -1;

    Knicke[16].Anz := 1;
    Knicke[16].Who[1] := 4;
    Knicke[16].Ger[1] := 9;
    Knicke[16].Ger[2] := 10;
    Knicke[16].Dir := 1;

    Knicke[17].Anz := 1;
    Knicke[17].Who[1] := 21;
    Knicke[17].Ger[1] := 15;
    Knicke[17].Ger[2] := 16;
    Knicke[17].Dir := -1;

    Knicke[18].Anz := 1;
    Knicke[18].Who[1] := 5;
    Knicke[18].Ger[1] := 10;
    Knicke[18].Ger[2] := 11;
    Knicke[18].Dir := 1;

    Knicke[19].Anz := 1;
    Knicke[19].Who[1] := 22;
    Knicke[19].Ger[1] := 16;
    Knicke[19].Ger[2] := 17;
    Knicke[19].Dir := -1;
  End else

  If PolyType = Dodekaeder then Begin
    Side_K := Side_Length / 2 * (1+ Sqrt(5));
    Side_S := Side_Length*2/Sqrt(10-sqrt(20));
    Side_Height := Sqrt(sqr(Side_S)-Sqr(Side_Length/2));
    NumberOfDraws := 51;
    NumberOfPoints := 40;
    PolyederTyp := PolyType;
    RotationAngle := (63.43) / 100;
    For I := 1 to NumberOfPoints do Ecken[I].Z := Side_K/16*11;

    For I := 1 to 20 do
    Begin
      Ecken[I].X := -3/4 * Side_K - 3/4 * Side_Length + Sine(((I-1) div 4 + 1)* 72) * Side_Height*2 + Sine(((I-1) div 4 + (I-1)mod 4) * 72) * Side_S;
      Ecken[I].Y := +21.6                              -Cose(((I-1) div 4 + 1)* 72) * Side_Height*2 - Cose(((I-1) div 4 + (I-1)mod 4) * 72) * Side_S;
    End;
    For I := 1 to 20 do
    Begin
      Ecken[I+20].X := 3/4 * Side_K + 3/4 * Side_Length + Sine(((I-1) div 4 + 1)* 72) * Side_Height*2 + Sine(((I-1) div 4 + (I-1)mod 4) * 72) * Side_S;
      Ecken[I+20].Y := -21                                 +Cose(((I-1) div 4 + 1)* 72) * Side_Height*2 + Cose(((I-1) div 4 + (I-1)mod 4) * 72) * Side_S;
    End;

    For I := 1 to NumberOfPoints do Ecken[I].Y := Ecken[I].Y - Side_Height / 32 * 9.5;
    For I := 1 to NumberOfPoints do Ecken[I].X := Ecken[I].X - Side_K / 32 * 13;


    For I := 1 to NumberOfDraws do
    Draw[I] := Dode_Draw[I];

    For I := 1 to 20 do
     Knicke[I].Anz := 0;

    Knicke[1].Anz := 3;
    Knicke[1].Who[1] := 5;
    Knicke[1].Who[2] := 6;
    Knicke[1].Who[3] := 7;
    Knicke[1].Ger[1] := 4;
    Knicke[1].Ger[2] := 8;
    Knicke[1].Dir := -1;

    Knicke[2].Anz := 3;
    Knicke[2].Who[1] := 9;
    Knicke[2].Who[2] := 10;
    Knicke[2].Who[3] := 11;
    Knicke[2].Ger[1] := 8;
    Knicke[2].Ger[2] := 12;
    Knicke[2].Dir := -1;

    Knicke[3].Anz := 3;
    Knicke[3].Who[1] := 13;
    Knicke[3].Who[2] := 14;
    Knicke[3].Who[3] := 15;
    Knicke[3].Ger[1] := 12;
    Knicke[3].Ger[2] := 16;
    Knicke[3].Dir := -1;

    Knicke[4].Anz := 3;
    Knicke[4].Who[1] := 17;
    Knicke[4].Who[2] := 18;
    Knicke[4].Who[3] := 19;
    Knicke[4].Ger[1] := 16;
    Knicke[4].Ger[2] := 20;
    Knicke[4].Dir := -1;
    

    Knicke[5].Anz := 3;
    Knicke[5].Who[1] := 37;
    Knicke[5].Who[2] := 38;
    Knicke[5].Who[3] := 39;
    Knicke[5].Ger[1] := 36;
    Knicke[5].Ger[2] := 40;
    Knicke[5].Dir := 1;

    Knicke[6].Anz := 3;
    Knicke[6].Who[1] := 21;
    Knicke[6].Who[2] := 22;
    Knicke[6].Who[3] := 23;
    Knicke[6].Ger[1] := 40;
    Knicke[6].Ger[2] := 24;
    Knicke[6].Dir := 1;

    Knicke[7].Anz := 3;
    Knicke[7].Who[1] := 25;
    Knicke[7].Who[2] := 26;
    Knicke[7].Who[3] := 27;
    Knicke[7].Ger[1] := 24;
    Knicke[7].Ger[2] := 28;
    Knicke[7].Dir := 1;

    Knicke[8].Anz := 3;
    Knicke[8].Who[1] := 29;
    Knicke[8].Who[2] := 30;
    Knicke[8].Who[3] := 31;
    Knicke[8].Ger[1] := 28;
    Knicke[8].Ger[2] := 32;
    Knicke[8].Dir := 1;  

    Knicke[9].Anz := 15;
    Knicke[9].Who[1] := 5;
    Knicke[9].Who[2] := 6;
    Knicke[9].Who[3] := 7;
    Knicke[9].Who[4] := 8;
    Knicke[9].Who[5] := 9;
    Knicke[9].Who[6] := 10;
    Knicke[9].Who[7] := 11;
    Knicke[9].Who[8] := 12;
    Knicke[9].Who[9] := 13;
    Knicke[9].Who[10] := 14;
    Knicke[9].Who[11] := 15;
    Knicke[9].Who[12] := 16;
    Knicke[9].Who[13] := 17;
    Knicke[9].Who[14] := 18;
    Knicke[9].Who[15] := 19;
    Knicke[9].Ger[1] := 4;
    Knicke[9].Ger[2] := 20;
    Knicke[9].Dir := -1;

    Knicke[10].Anz := 15;
    Knicke[10].Who[1] := 30;
    Knicke[10].Who[2] := 31;
    Knicke[10].Who[3] := 37;
    Knicke[10].Who[4] := 38;
    Knicke[10].Who[5] := 39;
    Knicke[10].Who[6] := 40;
    Knicke[10].Who[7] := 21;
    Knicke[10].Who[8] := 22;
    Knicke[10].Who[9] := 23;
    Knicke[10].Who[10] := 24;
    Knicke[10].Who[11] := 25;
    Knicke[10].Who[12] := 26;
    Knicke[10].Who[13] := 27;
    Knicke[10].Who[14] := 28;
    Knicke[10].Who[15] := 29;
    Knicke[10].Ger[1] := 36;
    Knicke[10].Ger[2] := 32;
    Knicke[10].Dir := 1;

    Knicke[11].Anz := 18;
    Knicke[11].Who[1] := 4;
    Knicke[11].Who[2] := 5;
    Knicke[11].Who[3] := 6;
    Knicke[11].Who[4] := 7;
    Knicke[11].Who[5] := 8;
    Knicke[11].Who[6] := 9;
    Knicke[11].Who[7] := 10;
    Knicke[11].Who[8] := 11;
    Knicke[11].Who[9] := 12;
    Knicke[11].Who[10] := 13;
    Knicke[11].Who[11] := 14;
    Knicke[11].Who[12] := 15;
    Knicke[11].Who[13] := 16;
    Knicke[11].Who[14] := 17;
    Knicke[11].Who[15] := 18;
    Knicke[11].Who[16] := 19;
    Knicke[11].Who[17] := 20;
    Knicke[11].Who[18] :=  1;
    Knicke[11].Ger[1] := 3;
    Knicke[11].Ger[2] := 2;
    Knicke[11].Dir := -1;
  End;

  PolyRec.PolyederTyp := PolyederTyp;
  PolyRec.NumberOfPoints := NumberOfPoints;
  PolyRec.NumberOfDraws := NumberOfDraws;
  PolyRec.RotationAngle := RotationAngle;
  For I := 1 to 255 do
  Begin
    PolyRec.Ecken[I] := Ecken[I];
    PolyRec.Draw[I] := Draw[I];
  End;
  For I := 1 to 20 do
    PolyRec.Knicke[I] := Knicke[I];
  SaveToFile(PolyRec);
End;              {}

Function Calc_3D2D(P : TVektor; Dist : Double) : T2DPunkt;
Var
  ZB : Double;
  P2 : T2DPunkt;
Begin
  If Form1.Perspective.Down then ZB := P.Z / Dist + 1 else
      ZB := 1;
  P2.X := Round(P.X / ZB);
  P2.Y := Round(P.Y / ZB);
  Result := P2;
End;

Procedure TPolyEder.Calc_2D_Points(Dist : Double);
Var
  I : Integer;
Begin
  For I := 1 to NumberOfPoints do
    Punkte2D[I] := Calc_3D2D(Ecken[I], Dist);
End;

Procedure TPolyeder.RotObjX(Deg : Integer);
Var
  I : Integer;
Begin
  For I:= 1 to NumberOfPoints do
    RotX(Ecken[I], Deg);
End;

Procedure TPolyeder.RotObjY(Deg : Integer);
Var
  I : Integer;
Begin
  For I:= 1 to NumberOfPoints do
    RotY(Ecken[I], Deg);
End;

Procedure TPolyeder.RotObjZ(Deg : Integer);
Var
  I : Integer;
Begin
  For I:= 1 to NumberOfPoints do
    RotZ(Ecken[I], Deg);
End;

Procedure TPolyeder.Scale(ScaleVar : Double);
Var
  I : Integer;
Begin
  For I := 1 to NumberOfPoints do
  with Ecken[I] do Begin
    X := X * ScaleVar;
    Y := Y * ScaleVar;
    Z := Z * ScaleVar;
  End;
End;

Procedure TPolyeder.Move(Dest : TVektor);
Var
  I : Integer;
Begin
  For I := 1 to NumberOfPoints do
  with Ecken[I] do Begin
    X := X + Dest.X;
    Y := Y + Dest.Y;
    Z := Z + Dest.Z;
  End;
End;




procedure TForm1.FormCreate(Sender: TObject);
Var
  I : Integer;
begin
  Randomize;

  For I := 0 to 359999 do
    SineTable[I] := Sin((I * PI)/ 180000);

  ScreenBuf := TBitmap.Create;
  ScreenBuf.Canvas.Brush.Color := clWhite;

  CX := DrawImage.Width div 2;
  CY := DrawImage.Height div 2;
  ScreenBuf.Width := DrawImage.Width;
  ScreenBuf.Height := DrawImage.Height;

  Poly.Init(SCALE_FACTOR, Tetraeder);

  Bar.Position := T.Interval;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  ScreenBuf.Destroy;
end;

procedure TForm1.Draw(Poly : TPolyeder);
Var
  I : Integer;
begin
  Poly.Calc_2D_Points(Perspective.Tag);
  With ScreenBuf.Canvas do
  Begin
    FloodFill(1, 1, clYellow, fsBorder);
    MoveTo(Poly.Punkte2D[Poly.Draw[1]].X + CX,
           ScreenBuf.Height - (Poly.Punkte2D[Poly.Draw[1]].Y + CY));
    For I := 2 to Poly.NumberOfDraws do
      LineTo(Poly.Punkte2D[Poly.Draw[I]].X + CX,
             ScreenBuf.Height - (Poly.Punkte2D[Poly.Draw[I]].Y + CY));

    If DualChk.Down and (KlappBtn.Tag = 1) and KlappBtn.Enabled then
    Begin
      Pen.Color := clGreen;
      Dual := Make_Dual(Poly);
      Dual.Calc_2D_Points(Perspective.Tag);
      MoveTo(Dual.Punkte2D[Dual.Draw[1]].X + CX,
             ScreenBuf.Height - (Dual.Punkte2D[Dual.Draw[1]].Y + CY));
      For I := 2 to Dual.NumberOfDraws do
        LineTo(Dual.Punkte2D[Dual.Draw[I]].X + CX,
               ScreenBuf.Height - (Dual.Punkte2D[Dual.Draw[I]].Y + CY));
 {     For I := 1 to Dual.NumberOfPoints do
        TextOut(Dual.Punkte2D[I].X+CX,
                ScreenBuf.Height - (Dual.Punkte2D[I].Y + CY), IntToStr(I));
 }     Pen.Color := clBlack;
    End;

  end;
  DrawImage.Canvas.Draw(0, 0, ScreenBuf);
end;

procedure TForm1.TTimer(Sender: TObject);
Var
  Dir : ShortInt;
  J : Integer;
  Speed : Byte;
begin
  Dir := KlappBtn.Tag;
  Speed := BuildSpeed.Tag;
  Inc(Count, Speed);
  With Poly Do
  Begin
    If T.Tag > 0 then
     For J := 1 to Knicke[T.Tag].Anz do
      Begin
        RotG(Ecken[Knicke[T.Tag].Who[J]],
             Ecken[Knicke[T.Tag].Ger[1]],
             Ecken[Knicke[T.Tag].Ger[2]],
             Knicke[T.Tag].Dir * Dir * RotationAngle * Speed);
      End;
    If (T.Tag > 0) and (Count mod 100 = 0) then T.Tag := T.Tag + 1;

    If Knicke[T.Tag].Anz = 0 then
    Begin
      T.Tag := 0;
      KlappBtn.Enabled := True; 
      BuildSpeed.Enabled := True;
      If KlappBtn.Tag = 1 then KlappBtn.Caption := 'Auseinanderbauen' else
        KlappBtn.Caption := 'Zusammenbauen';
    End;

    If RotCheck.Down then
    Begin
      RotObjX(SBX.Position);
      RotObjY(SBY.Position);
      RotObjZ(SBZ.Position);
    End;
  End;
  Draw(Poly);

  If RandomRot.Down then
  Begin
    SBX.Position := SBX.Position + Random(3)-1;
    SBY.Position := SBY.Position + Random(3)-1;
    SBZ.Position := SBZ.Position + Random(3)-1;
  End;
end;

Procedure TForm1.ResetAll;
Begin
  KlappBtn.Enabled := True;   
  BuildSpeed.Enabled := True;
  KlappBtn.Tag := -1;
  KlappBtn.Caption := 'Zusammenbauen';
  T.Tag := 0;
  Count := 0;
End;

procedure TForm1.KlappBtnClick(Sender: TObject);
begin
  KlappBtn.Enabled := False;
  BuildSpeed.Enabled := False;
  KlappBtn.Tag := -KlappBtn.Tag;
  T.Tag := 1;
  Count := 0;
end;

procedure TForm1.BarChange(Sender: TObject);
begin
  T.Interval := Bar.Position;
  ShowPanel.Caption := 'Verzögerung: '+IntToStr(Bar.Position)+'ms   ';
end;

procedure TForm1.SBXChange(Sender: TObject);
Var
  S : String;
begin
  S := 'X: ';
  If SBX.Position > 0 then S := S + '+';
  LX.Caption := S + IntToStr(SBX.Position);
end;

procedure TForm1.SBYChange(Sender: TObject);
Var
  S : String;
begin
  S := 'Y: ';
  If SBY.Position > 0 then S := S + '+';
  LY.Caption := S + IntToStr(SBY.Position);
end;

procedure TForm1.SBZChange(Sender: TObject);
Var
  S : String;
begin
  S := 'Z: ';
  If SBZ.Position > 0 then S := S + '+';
  LZ.Caption := S + IntToStr(SBZ.Position);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  CX := DrawImage.Width div 2;
  CY := DrawImage.Height div 2;
  ScreenBuf.Width := DrawImage.Width;
  ScreenBuf.Height := DrawImage.Height;
end;

procedure TForm1.IkoBtnClick(Sender: TObject);
begin
  Poly.Init(SCALE_FACTOR, Ikosaeder);
  ResetAll;
end;

procedure TForm1.HexaBtnClick(Sender: TObject);
begin
  Poly.Init(SCALE_FACTOR, Hexaeder);
  ResetAll;
end;

procedure TForm1.TetraBtnClick(Sender: TObject);
begin
  Poly.Init(SCALE_FACTOR, Tetraeder);
  ResetAll;
end;

procedure TForm1.OktaBtnClick(Sender: TObject);
begin

  Poly.Init(SCALE_FACTOR, Oktaeder);
  ResetAll;
end;

procedure TForm1.BuildSpeedClick(Sender: TObject);
begin
  Case BuildSpeed.ItemIndex of
    0 : BuildSpeed.Tag := 1;
    1 : BuildSpeed.Tag := 2;
    2 : BuildSpeed.Tag := 5;
    3 : BuildSpeed.Tag := 10;
    4 : BuildSpeed.Tag := 100;
  End;
end;

procedure TForm1.RandomRotClick(Sender: TObject);
begin
  GroupBox1.Enabled := not RandomRot.Down;
end;

procedure TForm1.ResetBtnClick(Sender: TObject);
begin
  SBX.Position := 0;
  SBY.Position := 0;
  SBZ.Position := 0;
end;

procedure TForm1.DodeBtnClick(Sender: TObject);
begin
  Poly.Init(SCALE_FACTOR, Dodekaeder);
  ResetAll;
end;

procedure TForm1.DrawImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Mx := X;
  MY := Y;
  Case Button of
    mbLeft : MLB := True;
    mbRight : MRB := True;
    mbMiddle : MMB := True;
  End;
end;

procedure TForm1.DrawImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Case Button of
    mbLeft : MLB := False;
    mbRight : MRB := False; 
    mbMiddle : MMB := False;
  End;
end;

procedure TForm1.DrawImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  T : TVektor;
begin
  If MLB then
  Begin
    T.X := X - MX;
    T.Y := -Y + MY;
    T.Z := 0;
    Poly.Move(T);
  End;
  If MRB then
  Begin
    Poly.RotObjY(MX-X);
    Poly.RotObjX(MY-Y);
  End;
  If MMB then
  Begin        
    T.X := 0;
    T.Y := 0;
    T.Z := -Y+MY;
    Poly.RotObjZ(X-MX);
    Poly.Move(T);
  End;;
    MX := X;
    MY := Y;
end;

procedure TForm1.ZoomInMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ZoomTimer.Tag := 102;
  ZoomTimer.Enabled := True;
end;

procedure TForm1.ZoomTimerTimer(Sender: TObject);
begin
  Poly.Scale(ZoomTimer.Tag / 100);
end;

procedure TForm1.ZoomOutMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ZoomTimer.Tag := 98;
  ZoomTimer.Enabled := True;
end;

procedure TForm1.ZoomOutMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ZoomTimer.Tag := 100;
  ZoomTimer.Enabled := False;
end;

procedure TForm1.ZoomInMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin  
  ZoomTimer.Tag := 100;
  ZoomTimer.Enabled := False;
end;

end.



