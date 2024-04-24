{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.hyprland;
in {
  imports =
    [
      inputs.hyprland.homeManagerModules.default
    ]
    ++ lib.snowfall.fs.get-non-default-nix-files ./.;

  options.desktops.hyprland = {
    enable = mkEnableOption "Whether to enable hyprland window manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
      wlr-randr
      grim
      slurp
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    ];

    desktops.addons = {
      polkit.enable = true;
      gtk.enable = true;
      qt.enable = true;
      #kanshi.enable = true;
      #swaync.enable = true;
      waybar.enable = true;
      wlogout.enable = true;
      dunst.enable = true;
      anyrun.enable = true;

      hyprpaper.enable = true;
      hyprlock.enable = true;
      hypridle.enable = true;
    };

    apps.terminals.alacritty.enable = true;

    home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
