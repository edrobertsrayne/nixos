{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.addons.dunst;
in {
  options.desktops.addons.dunst.enable = mkEnableOption "Whether to enable dunst notifications";

  config = mkIf cfg.enable {
    services.dunst = with config.colorScheme.palette; {
      enable = true;
      iconTheme = {
        name = "adwaita-icon-theme";
        package = pkgs.gnome.adwaita-icon-theme;
        size = "32x32";
      };
      settings = {
        global = {
          width = 400;
          height = 200;
          origin = "top-right";
          transparency = 60;
          offset = "20x20";
          font = "Noto 12";
          background = "#${base01}";
          foreground = "#${base05}";
          frame_color = "#${base07}";
          frame_width = 1;
          corner_radius = 10;
        };

        urgency_critical = {
          frame_color = "#${base08}";
        };
      };
    };
  };
}
