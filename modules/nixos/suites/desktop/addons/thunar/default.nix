{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.desktop.addons.thunar;
in {
  options.suites.desktop.addons.thunar.enable = mkEnableOption "Whether to enable thunar file manager";

  config = mkIf cfg.enable {
    programs.thunar.enable = true;
    programs.xfconf.enable = true; # all preferences to be saved
    services.tumbler.enable = true; # support for thumbnails
  };
}
