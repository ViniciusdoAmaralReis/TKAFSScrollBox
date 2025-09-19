unit uKAFSScrollBox;

interface

uses
  System.Classes, System.Types, System.UITypes,
  FMX.Layouts;

type
  TKAFSScrollBox = class(TScrollBox)

    constructor Create(AOwner: TComponent); override;
    procedure DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure DoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  end;

var
  _posicao: TPointF;
  _mover: Boolean;

implementation

constructor TKAFSScrollBox.Create(AOwner: TComponent);
begin
  inherited;

  Self.OnMouseDown := DoMouseDown;
  Self.OnMouseMove := DoMouseMove;
  Self.OnMouseUp := DoMouseUp;
end;

procedure TKAFSScrollBox.DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbLeft then
  begin
    _posicao := PointF(X, Y);
    _mover := True;
  end;
end;

procedure TKAFSScrollBox.DoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
  if _mover then
  begin
    var _delta := PointF(_posicao.X - X, _posicao.Y - Y);
    _posicao := PointF(X, Y);

    Self.ViewportPosition := PointF(
      Self.ViewportPosition.X + _delta.X,
      Self.ViewportPosition.Y + _delta.Y);
  end;
end;

procedure TKAFSScrollBox.DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbLeft then
    _mover := False;
end;

end.
