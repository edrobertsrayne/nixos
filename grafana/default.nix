{
  pkgs,
  config,
  ...
}: {
  age.secrets.pve-exporter.file = ../secrets/pve-exporter.age;

  services = {
    grafana = {
      enable = true;
      settings = {
        server = {
          domain = "grafana.greensroad.uk";
          http_port = 3000;
          http_addr = "127.0.0.1";
        };
      };
    };

    nginx.virtualHosts."grafana.greensroad.uk" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true;
      };
    };

    prometheus = {
      enable = true;
      port = 9001;
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
              replacement = "prometheus.greensroad.uk:9221";
            }
          ];
        }
      ];
    };
    nginx.virtualHosts."prometheus.greensroad.uk" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:9001";
        proxyWebsockets = true;
      };
    };

    loki = {
      enable = true;
      configFile = ./loki.yml;
    };
  };

  systemd.services.promtail = {
    description = "Promtail service for loki";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.grafana-loki}/bin/promtail --config.file ${./promtail.yml}
      '';
    };
  };

  environment = {
    persistence."/nix/persist" = {
      directories = [
        "/var/lib/grafana"
        "/var/lib/prometheus2"
        "/var/lib/loki"
      ];
    };
  };
}
