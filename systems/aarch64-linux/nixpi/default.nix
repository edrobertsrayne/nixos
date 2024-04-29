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

  hardware = {
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    deviceTree = {
      enable = true;
      filter = "*rpi-4-*.dtb";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  networking.hostName = "nixpi";

  networking.wireless = {
    enable = true;
    networks = {
      "Wifibobs" = {
        pskRaw = "55d9313be47fb001bb4e14c6e5a7c3f882aca03fa469441a9b5602a9dfc25371";
      };
    };
  };

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
    libraspberrypi
    raspberrypi-eeprom
    git
    wget
    vim
  ];

  system.stateVersion = "23.11";
}
