{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.raspberrypi4;
in {
  options.hardware.raspberrypi4.enable = mkEnableOption "Whether to enable the Raspberry Pi 4 default hardware configuration";

  config = mkIf cfg.enable {
    hardware = {
      raspberry-pi."4".apply-overlays-dtmerge.enable = true;
      deviceTree = {
        enable = true;
        filter = "*rpi-4-*.dtb";
      };
    };

    # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
    boot.loader.grub.enable = false;
    boot.loader.generic-extlinux-compatible.enable = true;

    networking.wireless.enable = true;
    networking.wireless.networks.Wifibobs.pskRaw = "55d9313be47fb001bb4e14c6e5a7c3f882aca03fa469441a9b5602a9dfc25371";

    zramSwap.enable = true;
    swapDevices = [
      {
        device = "/swapfile";
        size = 1024;
      }
    ];

    environment.systemPackages = with pkgs; [
      libraspberrypi
    ];

    systemd.watchdog = {
      runtimeTime = "15s";
      rebootTime = "2m";
    };

    hardware.enableRedistributableFirmware = true;
  };
}
