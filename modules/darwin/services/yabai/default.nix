{
  pkgs,
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
      package = builtins.path {
        path =
          if pkgs.stdenv.hostPlatform.isAarch64
          then /opt/homebrew
          else /usr/local;
        filter = path: type: type == "directory" || builtins.baseNameOf path == "yabai";
      };
      enableScriptingAddition = true;
      config = {
        auto_balance = "on";
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
