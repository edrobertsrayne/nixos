{
  config,
  lib,
  ...
}: let
  service = "prometheus";
  inherit (config) homelab;
  cfg = config.homelab.services.${service};
in {
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    configDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/prometheus2";
    };
    url = lib.mkOption {
      type = lib.types.str;
      default = "${service}.${homelab.baseDomain}";
    };
    port = lib.mkOption {
      type = lib.types.int;
      default = 9001;
    };
  };
  config = lib.mkIf cfg.enable {
    age.secrets.pve-exporter.file = ../../secrets/pve-exporter.age;

    services.${service} = {
      enable = true;
      inherit (cfg) port;
      exporters = {
        pve = {
          enable = true;
          configFile = config.age.secrets.pve-exporter.path;
        };
      };
      scrapeConfigs = [
        {
          job_name = "thor";
          static_configs = [{targets = ["192.168.68.112:9100"];}];
        }
        {
          job_name = "pve";
          static_configs = [
            {
              targets = ["192.168.68.112"];
            }
          ];
          metrics_path = "/pve";
          params = {
            module = ["default"];
          };
          relabel_configs = [
            {
              source_labels = ["__address__"];
              target_label = "__param_target";
            }
            {
              source_labels = ["__param_target"];
              target_label = "instance";
            }
            {
              target_label = "__address__";
              replacement = "${cfg.url}:9221";
            }
          ];
        }
      ];
    };
    services.nginx.virtualHosts."${cfg.url}" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
        proxyWebsockets = true;
      };
    };
    environment.persistence."/nix/persist" = {
      directories = ["${cfg.configDir}"];
    };
  };
}
