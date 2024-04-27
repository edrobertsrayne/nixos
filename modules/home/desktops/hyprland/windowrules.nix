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
    };
  };
}
