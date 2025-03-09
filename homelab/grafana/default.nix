{
  config,
  lib,
  ...
}: let
  service = "grafana";
  inherit (config) homelab;
  cfg = config.homelab.services.${service};
in {
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    configDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/grafana";
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "grafana.${homelab.baseDomain}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 3000;
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      settings = {
        server = {
          domain = "${cfg.url}";
          http_port = cfg.port;
          http_addr = "127.0.0.1";
        };
      };
    };

    services.nginx.virtualHosts."${cfg.url}" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
        proxyWebsockets = true;
      };
    };

    environment.persistence."/nix/persist" = {
      directories = [
        "${cfg.configDir}"
      ];
    };
  };
}
