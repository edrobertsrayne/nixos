{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.desktop;
in {
  options.suites.desktop.enable = mkEnableOption "desktop environment suite";

  config = mkIf cfg.enable {
    suites.common.enable = true;

    environment.systemPackages = with pkgs; [
      libnotify
      networkmanagerapplet
      bottles
      quickemu
    ];

    services = {
      dbus.implementation = mkDefault "broker";
      sound.enable = mkDefault true;
    };

    system = {
      fonts.enable = mkDefault true;
      xkb.enable = mkDefault true;
    };

    programs = {
      nm-applet.enable = true;
      dconf.enable = true;
    };

    suites.desktop.addons = {
      hyprland.enable = true;
    };
  };
}
