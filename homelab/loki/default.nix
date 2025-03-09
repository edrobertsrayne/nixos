{
  pkgs,
  config,
  lib,
  ...
}: let
  service = "loki";
  cfg = config.homelab.services.${service};
in {
  options.homelab.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    configDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/loki";
    };
  };
  config = lib.mkIf cfg.enable {
    services.${service} = {
      enable = true;
      configFile = ./loki.yml;
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

    environment.persistence."/nix/persist" = {
      directories = [
        "${cfg.configDir}"
      ];
    };
  };
}
