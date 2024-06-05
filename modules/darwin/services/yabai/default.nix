{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.services.yabai;
in {
  options.custom.services.yabai.enable = mkEnableOption "Whether to enable yabai window manager";

  config = mkIf cfg.enable {
    services.yabai = {
      enable = true;
      enableScriptingAddition = true;
      config = {
        layout = "bsp";
        window_placement = "second_child";
        top_padding = 10;
        bottom_padding = 10;
        left_padding = 10;
        right_padding = 10;
        window_gap = 10;
        mouse_follows_focus = "on";
        mouse_modifier = "alt";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        mouse_drop_action = "swap";
      };
      extraConfig = ''
        yabai -m rule --add app="^System Settings$" manage=off
        yabai -m rule --add app="^Calculator$" manage=off
      '';
    };
  };
}
