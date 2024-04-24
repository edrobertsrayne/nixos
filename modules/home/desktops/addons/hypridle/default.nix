{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.addons.hypridle;
in {
  imports = [inputs.hypridle.homeManagerModules.default];

  options.desktops.addons.hypridle.enable = mkEnableOption "hypridle idle daemon";

  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
      lockCmd = lib.getExe config.programs.hyprlock.package;
      afterSleepCmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";

      listeners = [
        {
          timeout = 600;
          onTimeout = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          timeout = 660;
          onTimeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          onResume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          onTimeout = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
