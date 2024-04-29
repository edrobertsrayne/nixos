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
      "Wifibobs" = {
pskRaw = "55d9313be47fb001bb4e14c6e5a7c3f882aca03fa469441a9b5602a9dfc25371";
      };
    };
  };

  system.stateVersion = "23.11";
}
