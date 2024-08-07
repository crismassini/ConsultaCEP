unit uAuxiliar;

interface
type
  TAcao = (tacIndefinido, tacIncluir, tacAlterar, tacExcluir);

function IsDigit(Texto : string): Boolean;
function SoNumero(AText: string): string;

implementation

uses
  System.SysUtils;

function SoNumero(AText: string): string;
var
Ind    : Integer;
TmpRet : String;
begin
  TmpRet := '';
  for Ind := 1 to Length(AText) do
  begin
    if IsDigit(Copy(AText,Ind,1)) then
    begin
      TmpRet := TmpRet + Copy(AText, Ind, 1);
    end;
  end;
  Result := TmpRet;
end;

function IsDigit(Texto : string): Boolean;
begin
  result := true;
  try
    StrToInt(Texto);
  except
    Result := false;
  end;
end;




end.
