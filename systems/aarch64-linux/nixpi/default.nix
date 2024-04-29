{
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; {
  imports = [
    inputs.hardware.nixosModules.raspberry-pi-4
    ./hardware-configuration.nix
  ];

  hardware.networking.enable = mkForce false;

  networking.hostName = "nixpi";

  networking.wireless = {
    enable = true;
    networks = {
      "SSID" = {
        psk = "password";
      };
    };
  };

  suites.common.enable = true;

  system.stateVersion = "23.11";
}
