{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.common;
in {
  options.suites.common.enable = mkEnableOption "Whether to enable the default suite.";

  config = mkIf cfg.enable {
    system = {
      nix.enable = mkDefault true;
      locale.enable = mkDefault true;
      backlight.enable = mkDefault true;
    };

    security.sudo.wheelNeedsPassword = mkDefault false;

    hardware.custom.bluetooth.enable = mkDefault true;
    hardware.networking.enable = mkDefault true;

    services = {
      custom.avahi.enable = mkDefault true;
      ssh.enable = mkDefault true;
      udisks2.enable = mkDefault true;
    };

    apps.nh.enable = mkDefault true;

    environment.systemPackages = with pkgs; [git vim coreutils wget];
  };
}
