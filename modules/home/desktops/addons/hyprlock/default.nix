{
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.addons.hyprlock;
  font_family = "Roboto";
  inherit (config.suites.desktop) wallpaper;
in {
  imports = [inputs.hyprlock.homeManagerModules.default];

  options.desktops.addons.hyprlock.enable = mkEnableOption "hyprlock";

  config = mkIf cfg.enable {
    programs.hyprlock = with config.colorScheme.palette; {
      enable = true;

      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = false;
        no_fade_out = false;
        ignore_empty_input = true;
      };

      backgrounds = [
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

      input-fields = [
        {
          monitor = "eDP-1";
          size = {
            width = 300;
            height = 50;
          };
          outline_thickness = 2;
          outer_color = "rgb(${base0D})";
          inner_color = "rgb(${base01})";
          font_color = "rgb(${base05})";
          fade_on_empty = true;
          hide_input = true;
          dots_spacing = 0.3;
          dots_center = true;
          position = {
            x = 0;
            y = 0;
          };
          fail_color = "rgb(${base09})";
          check_color = "rgb(${base09})";
        }
      ];

      labels = [
        {
          monitor = "";
          text = "$USER";
          font_size = 24;
          inherit font_family;
          color = "rgb(${base05})";
          position = {
            x = -40;
            y = -80;
          };
          valign = "bottom";
          halign = "right";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$TIME"'';
          font_size = 48;
          inherit font_family;
          color = "rgb(${base05})";
          position = {
            x = -40;
            y = -40;
          };
          valign = "bottom";
          halign = "right";
        }
      ];
    };
  };
}
