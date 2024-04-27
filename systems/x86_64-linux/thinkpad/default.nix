{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "thinkpad";

  suites.desktop.enable = true;
  suites.gaming.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  system.battery.enable = true;

  system.stateVersion = "23.11";
}
