{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.addons.hyprlock;
  font_family = "Roboto";
  #inherit (config.suites.desktop) wallpaper;
  wallpaper = config.stylix.image;
in {
  options.desktops.addons.hyprlock.enable = mkEnableOption "hyprlock";

  config = mkIf cfg.enable {
    programs.hyprlock = with config.colorScheme.palette; {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = false;
          hide_cursor = false;
          no_fade_in = false;
          no_fade_out = false;
          ignore_empty_input = true;
        };

        background = [
          {
            monitor = "";
            path = "${wallpaper}";
            color = "rgb(${base00})";

            blur_passes = 1;
            blur_size = 7;
            noise = 0.0117;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];

        input-field = [
          {
            monitor = "eDP-1";
            size = "300, 50";
            outline_thickness = 2;
            outer_color = "rgb(${base0D})";
            inner_color = "rgb(${base01})";
            font_color = "rgb(${base05})";
            fade_on_empty = true;
            hide_input = false;
            dots_spacing = 0.3;
            dots_center = true;
            position = "0, 0";
            fail_color = "rgb(${base09})";
            check_color = "rgb(${base09})";
          }
        ];

        label = [
          {
            monitor = "";
            text = ''cmd[update:1000] echo "$TIME"'';
            font_size = 48;
            inherit font_family;
            color = "rgb(${base05})";
            position = "-40, -40";
            valign = "bottom";
            halign = "right";
          }
        ];
      };
    };
  };
}
