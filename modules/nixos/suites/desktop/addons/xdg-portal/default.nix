{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.desktop.addons.xdg-portal;
in {
  options.suites.desktop.addons.xdg-portal = with types; {
    enable = mkEnableOption "add support for xdg portal";
  };

  config = mkIf cfg.enable {
    xdg = {
      #autostart.enable = true;
      portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
        ];
      };
    };
  };
}
