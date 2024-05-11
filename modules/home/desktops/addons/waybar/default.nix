{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.desktops.addons.waybar;
in {
  imports = [./style.nix ./settings.nix];

  options.custom.desktops.addons.waybar.enable = mkEnableOption "waybar";

  config = mkIf cfg.enable {
    programs.waybar = with config.colorScheme.palette; {
      enable = true;
      systemd.enable = false;
    };
  };
}
