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

    stylix = {
      targets.kde.enable = false;
      fonts = {
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };
        monospace = {
          package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
          name = "JetBrainsMono Nerd Font";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        sizes = {
          terminal = 11;
        };
      };
    };

    desktops.hyprland.enable = true;
    desktops.addons.xdg.enable = true;
    custom = {
      desktops.addons.rofi.enable = true;
      apps.zathura.enable = true;
      apps.vscode.enable = true;
    };

    services = {
      udiskie.enable = true;
    };

    programs = {
      feh.enable = true;

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

    xdg.desktopEntries = {
      arduino-ide = {
        name = "Arduino IDE";
        exec = "arduino-ide --enable-features=UseOzonePlatform --ozone-platform=wayland %U";
        categories = ["Development"];
        comment = "Arduino IDE";
        icon = "arduino-ide";
        settings = {
          StartupWMClass = "Arduino IDE";
          X-AppImage-Version = "2.3.2";
        };
      };
    };
  };
}
