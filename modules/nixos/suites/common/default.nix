{
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; {
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
}
