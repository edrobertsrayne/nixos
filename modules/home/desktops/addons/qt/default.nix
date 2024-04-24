{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.addons.qt;
in {
  options.desktops.addons.qt.enable = mkEnableOption "QT theming";

  config = mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };
  };
}
