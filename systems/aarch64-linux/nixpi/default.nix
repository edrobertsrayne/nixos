{
  pkgs,
  config,
  lib,
  modulesPath,
  inputs,
  ...
}:
with lib;
with lib.custom; {
  imports = [
    inputs.hardware.nixosModules.raspberry-pi-4
    (modulesPath + /installer/scan/not-detected.nix)
    (modulesPath + /installer/sd-card/sd-image-aarch64.nix)
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
