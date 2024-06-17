{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.addons.hyprlock;
  font = config.stylix.fonts.sansSerif.name;

  colorize = "40";
  fill = "black";
  blur = "0x8";
  wallpaper = pkgs.runCommand "blurred.png" {} ''
    ${pkgs.imagemagick}/bin/convert "${config.stylix.image}" \
    -fill ${fill} \
    -colorize "${colorize}%" \
    -blur ${blur} \
    $out
  '';
in {
  options.desktops.addons.hyprlock.enable = mkEnableOption "hyprlock";

  config = mkIf cfg.enable {
    programs.hyprlock = with config.lib.stylix.colors; {
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
            font_family = "${font}";
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
