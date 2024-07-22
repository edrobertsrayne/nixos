{inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.raspberry-pi-4
    ./hardware-configuration.nix
  ];

  hardware.raspberrypi4.enable = true;

  networking.hostName = "nixpi";

  suites.common.enable = true;

  custom.services = {
    blocky.enable = true;
    grafana.enable = true;
    prometheus.enable = true;
  };

  system.stateVersion = "23.11";
}
