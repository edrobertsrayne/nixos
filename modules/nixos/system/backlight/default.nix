{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.backlight;
in {
  options.system.backlight.enable = mkEnableOption "Whether to enable backlight control";

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.brightnessctl];
  };
}
