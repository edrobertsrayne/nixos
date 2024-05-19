{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.services.prometheus;
in {
  options.custom.services.prometheus = {
    enable = mkEnableOption "Whether to enable prometheus";
  };
  config = mkIf cfg.enable {
    services.prometheus = {
      enable = true;
      port = 9090;

      exporters = {
        node = {
          enable = true;
          enabledCollectors = ["systemd"];
          port = 9002;
        };
      };

      scrapeConfigs = [
        {
          job_name = "${toString config.networking.hostName}";
          static_configs = [
            {
              targets = ["127.0.0.1:${toString config.services.prometheus.exporters.node.port}"];
            }
          ];
        }
      ];
    };
  };
}
