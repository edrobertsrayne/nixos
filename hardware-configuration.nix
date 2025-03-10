# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = ["defaults" "size=2G" "mode=755"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/db9d22cf-46db-45df-ae06-4a8d50c43590";
    fsType = "ext4";
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/97656c6e-1d29-4124-8353-7558b9dc4c1c";
    fsType = "ext4";
  };

  #  fileSystems."/etc/nixos" =
  #    { device = "/nix/persist/etc/nixos";
  #      fsType = "none";
  #      options = [ "bind" ];
  #    };

  #  fileSystems."/var/log" =
  #    { device = "/nix/persist/var/log";
  #      fsType = "none";
  #      options = [ "bind" ];
  #    };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.ens18.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
