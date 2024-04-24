{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.desktop.addons.greetd;
in {
  options.suites.desktop.addons.greetd.enable = mkEnableOption "greetd login daemon";

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.greetd.tuigreet} --cmd Hyprland";
          user = "${config.user.name}";
        };
      };
    };
    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
