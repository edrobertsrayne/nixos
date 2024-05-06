{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.desktops.addons.rofi;
in {
  options.custom.desktops.addons.rofi.enable = mkEnableOption "Whether to eneable rofi application launcher.";

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
    };
  };
}
