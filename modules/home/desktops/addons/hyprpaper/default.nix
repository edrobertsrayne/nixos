{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.addons.hyprpaper;
  inherit (config.suites.desktop) wallpaper;
in {
  options.desktops.addons.hyprpaper = {
    enable = mkEnableOption "hyprpaper wallpaper utility";
  };

  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preloads = ["${wallpaper}"];
        wallpapers = [", ${wallpaper}"];
      };
    };
  };
}
