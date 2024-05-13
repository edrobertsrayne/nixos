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
    wayland.windowManager.hyprland.settings = {
      windowrule = [
        "float,^(thunar)$"
        "float,^(nm-connection-editor)$"
        "float,^(.blueman-manager-wrapped)$"
      ];
      windowrulev2 = [
        # Set Spotify to workspace 9
        "workspace 9 silent, title:^(Spotify( Premium)?)$"

        # Keep YouTube windows fully opaque and prevent idle
        "opaque, class:^(google-chrome)$, title:(.*YouTube.*)$"
        "idleinhibit focus, class:^(google-chrome)$, title:(.*YouTube.*)$"
        "idleinhibit fullscreen, class:^(google-chrome)$"

        "suppressevent maximise, class:.*"
      ];
    };
  };
}
