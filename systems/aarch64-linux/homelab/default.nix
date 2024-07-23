{
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.raspberry-pi-4
    ./hardware-configuration.nix
  ];

  hardware.raspberrypi4.enable = true;

  networking.hostName = "homelab";
  networking.firewall.enable = lib.mkForce false;
  virtualisation.docker.enable = true;

  suites.common.enable = true;

  system.stateVersion = "23.11";
}
