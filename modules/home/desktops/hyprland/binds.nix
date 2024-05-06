{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.hyprland;

  inherit (config.suites.desktop) browser terminal;
  filemanager = "thunar";
  lockCmd = "hyprlock";
  menuCmd = "rofi -show drun";
  logoutCmd = "wlogout";

  screenshotarea = "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copysave area; hyprctl keyword animation 'fadeOut,1,4,default'";

  scratchpad = name:
    builtins.concatStringsSep " && " [
      "pypr toggle ${name}"
      "hyprctl dispatch bringactivetotop"
    ];

  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "SUPER, ${ws}, workspace, ${toString (x + 1)}"
        "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        "SUPER SHIFT Control_L, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
      ]
    )
    10);
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind =
        [
          "SUPER, Return, exec, ${terminal}"
          "SUPER, B, exec, ${browser}"
          "SUPER SHIFT, F, exec, ${filemanager}"
          "SUPER SHIFT, Q, exec, ${logoutCmd}"
          "SUPER, Space, exec, ${menuCmd}"
          "SUPER SHIFT, L, exec, ${lockCmd}"

          # windows
          "SUPER, F, fullscreen"
          "SUPER, G, togglegroup"
          "SUPER SHIFT, N, changegroupactive, f"
          "SUPER SHIFT, P, changegroupactive, b"
          "SUPER, Q, killactive"
          "SUPER, T, togglefloating"
          "SUPER, P, pseudo"
          "SUPER, J, togglesplit"
          "SUPER ALT, , resizeactive"

          # resize windows
          "SUPER SHIFT, right, resizeactive, 100 0"
          "SUPER SHIFT, left, resizeactive, -100 0"
          "SUPER SHIFT, down, resizeactive, 0 100"
          "SUPER SHIFT, up, resizeactive, 0 -100"

          # move window focus arrows and vim style
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"
          "SUPER, H, movefocus, l"
          "SUPER, L, movefocus, r"
          "SUPER, K, movefocus, u"
          "SUPER, L, movefocus, d"

          # pyprland
          "SUPER SHIFT, Return, exec, ${scratchpad "term"}"
          "SUPER SHIFT, t, exec, ${scratchpad "todoist"}"
          "SUPER SHIFT, c, exec, ${scratchpad "chatgpt"}"
          "SUPER SHIFT, k, exec, ${scratchpad "keep"}"
          "SUPER SHIFT, b, exec, ${scratchpad "btm"}"
          "SUPER, l, exec, ${scratchpad "lf"}"

          # screenshot
          # stop animations while screenshotting; makes black border go away
          ", Print, exec, ${screenshotarea}"
          "SUPER SHIFT, R, exec, ${screenshotarea}"

          "CTRL, Print, exec, grimblast --notify --cursor copysave output"
          "SUPER SHIFT CTRL, R, exec, grimblast --notify --cursor copysave output"

          "ALT, Print, exec, grimblast --notify --cursor copysave screen"
          "SUPER SHIFT ALT, R, exec, grimblast --notify --cursor copysave screen"

          # workspaces
          "SUPER CTRL, down, workspace, empty"
        ]
        ++ workspaces;

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
        "SUPER ALT, mouse:272, resizewindow"
      ];

      bindl = [
        # media controls
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl prev"
        ", XF86AudioNext, exec, playerctl next"

        # volume
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      bindle = [
        # volume
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%-"

        # backlight
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
    };
  };
}
