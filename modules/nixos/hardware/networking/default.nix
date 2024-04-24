{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.networking;
in {
  options.hardware.networking = with types; {
    enable = mkEnableOption "Network manager";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
    # dns = "systemd-resolved";
    #wifi.powersave = true;

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [4382 57621];
      allowedUDPPorts = [4282 5353];
    };
  };
}
