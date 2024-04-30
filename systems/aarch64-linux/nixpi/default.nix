{
  lib,
  inputs,
  pkgs,
  ...
}:
with lib;
with lib.custom; {
  imports = [
    inputs.hardware.nixosModules.raspberry-pi-4
    ./hardware-configuration.nix
  ];

hardware.raspberrypi4.enable = true;

  security.sudo.wheelNeedsPassword = false;

  networking.hostName = "nixpi";

  system = {
    nix.enable = true;
    locale.enable = true;
  };

  services = {
    custom.avahi.enable = true;
    ssh.enable = true;
    udisks2.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    vim
  ];

  system.stateVersion = "23.11";
}
