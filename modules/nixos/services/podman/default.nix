{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.services.podman;
in {
  options.custom.services.podman.enable = mkEnableOption "Whether to enable podman";

  config =
    mkIf cfg.enable
    {
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      environment.systemPackages = with pkgs; [
        dive
        podman-tui
        podman-compose
      ];
    };
}
