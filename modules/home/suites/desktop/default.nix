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
  options.suites.desktop = with types; {
    enable = mkEnableOption "Desktop environment suite";
    wallpaper = mkPackageOption pkgs.custom.wallpapers "default" {};
    terminal = mkOption {
      type = str;
      default = "alacritty";
    };
    browser = mkOption {
      type = str;
      default = "google-chrome-stable";
    };
  };

  config = mkIf cfg.enable {
    suites = {
      common.enable = true;
      development.enable = true;
    };

    desktops.hyprland.enable = true;
    desktops.addons.xdg.enable = true;
    custom.desktops.addons.rofi.enable = true;

    services = {
      udiskie.enable = true;
    };

    programs = {
      feh.enable = true;
      vscode.enable = true;

      chromium = {
        enable = true;
        package = pkgs.google-chrome;
        commandLineArgs = [
          "--enable-features=UseOzonePlatform"
          "--ozone-platform=wayland"
        ];
      };
    };

    home.packages = with pkgs; [
      blueman

      spotify
      vlc

      arduino-ide
      processing
      kicad

      discord
    ];
  };
}
