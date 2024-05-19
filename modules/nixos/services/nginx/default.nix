{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.services.nginx;
in {
  options.custom.services.nginx = {
    enable = mkEnableOption "Whether to enable nginx";
  };
  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [80 443];
    };

    services.nginx.enable = true;
  };
}
