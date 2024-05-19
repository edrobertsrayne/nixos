{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.services.grafana;
  http_port = 3000;
  http_addr = "127.0.0.1";
  domain = "${toString config.networking.hostName}.local";
in {
  options.custom.services.grafana = {
    enable = mkEnableOption "Whether to enable Grafana";
  };
  config = mkIf cfg.enable {
    custom.services.nginx.enable = true;

    services.grafana = {
      enable = true;
      settings.server = {
        inherit domain http_port http_addr;
        serve_from_sub_path = true;
        root_url = "http://${domain}/grafana/";
      };
    };

    services.nginx = {
      virtualHosts."${domain}" = {
        locations."/grafana/" = {
          proxyPass = "http://${toString http_addr}:${toString http_port}";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
    };
  };
}
