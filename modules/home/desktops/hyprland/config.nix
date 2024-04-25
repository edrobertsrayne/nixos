{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = with config.colorScheme.palette; {
      enable = true;

      xwayland.enable = true;

      settings = {
        monitor = ",highres,auto,1";
        general = {
          gaps_out = 10;
          gaps_in = 5;
          "col.active_border" = "rgb(${base07})";
          "col.inactive_border" = "rgb(${base02})";
          resize_on_border = true;
        };

        env = ["QT_WAYLAND_DISABLE_WINDOWDECORATION,1"];
        input = {
          kb_layout = "gb";
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        misc = {
          disable_autoreload = true;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          force_default_wallpaper = 0;
          animate_mouse_windowdragging = false;
          no_direct_scanout = false;
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
        };

        windowrulev2 = "suppressevent maximise, class:.*";
        exec-once = [
          "blueman-applet"
          "waybar"
          "pypr"
          "hypridle"
        ];
      };
    };
  };
}
