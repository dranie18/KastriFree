unit DW.VirtualKeyboard.Helpers;

{*******************************************************}
{                                                       }
{                    Kastri Free                        }
{                                                       }
{          DelphiWorlds Cross-Platform Library          }
{                                                       }
{*******************************************************}

{$I DW.GlobalDefines.inc}

interface

uses
  // RTL
  System.Types,
  // FMX
  FMX.Types;

type
  TVirtualKeyboard = record
  public
    class procedure EnableToolbar(const AEnable: Boolean); static;
    class function GetBounds: TRect; static;
    class procedure Hide; static;
    class procedure Show(const AObject: TFmxObject); static;
  end;

implementation

uses
  {$IF Defined(ANDROID)}
  // DW
  DW.VirtualKeyboard.Android,
  {$ENDIF}
  // FMX
  FMX.Platform, FMX.VirtualKeyboard;

{ TVirtualKeyboard }

class function TVirtualKeyboard.GetBounds: TRect;
begin
  {$IF Defined(ANDROID)}
  Result := TPlatformVirtualKeyboard.GetBounds;
  {$ELSE}
  Result := TRect.Empty;
  {$ENDIF}
end;

class procedure TVirtualKeyboard.Hide;
var
  LService: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, LService) then
    LService.HideVirtualKeyboard;
end;

class procedure TVirtualKeyboard.Show(const AObject: TFmxObject);
var
  LService: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, LService) then
    LService.ShowVirtualKeyboard(AObject);
end;

class procedure TVirtualKeyboard.EnableToolbar(const AEnable: Boolean);
var
  LService: IFMXVirtualKeyboardToolbarService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardToolbarService, LService) then
    LService.SetToolbarEnabled(AEnable);
end;

end.
