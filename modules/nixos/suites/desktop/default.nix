{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.desktop;
in {
  options.suites.desktop.enable = mkEnableOption "desktop environment suite";

  config = mkIf cfg.enable {
    suites.common.enable = true;

    environment.systemPackages = with pkgs; [libnotify];

    system.fonts.enable = true;

    programs.nm-applet.enable = true;

    suites.desktop.addons = {
      hyprland.enable = true;
    };
  };
}
