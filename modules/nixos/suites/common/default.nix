{
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.common;
in {
  options.suites.common.enable = mkEnableOption "Whether to enable the default suite.";

  config = mkIf cfg.enable {
    system = {
      nix.enable = true;
      locale.enable = true;
      fonts.enable = true;
      xkb.enable = true;
      backlight.enable = true;
    };

    security.sudo.wheelNeedsPassword = false;

    hardware.custom.bluetooth.enable = true;
    hardware.networking.enable = true;

    services = {
      custom.avahi.enable = true;
      ssh.enable = true;
      dbus.implementation = "broker";
      sound.enable = true;
      udisks2.enable = true;
    };

    apps.nh.enable = true;

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [git vim coreutils wget];
  };
}
