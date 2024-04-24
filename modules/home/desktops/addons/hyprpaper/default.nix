{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.addons.hyprpaper;
  inherit (config.suites.desktop) wallpaper;
in {
  imports = [inputs.hyprpaper.homeManagerModules.default];

  options.desktops.addons.hyprpaper = {
    enable = mkEnableOption "hyprpaper wallpaper utility";
  };

  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      preloads = ["${wallpaper}"];
      wallpapers = [", ${wallpaper}"];
    };
  };
}
