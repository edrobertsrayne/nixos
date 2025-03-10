{
  lib,
  config,
  ...
}: let
  cfg = config.homelab;
in {
  options.homelab = {
    enable = lib.mkEnableOption "Enable homelab core services";
    timeZone = lib.mkOption {
      default = "Europe/London";
      type = lib.types.str;
      description = ''
        Time zone to be used for homelab services
      '';
    };
    baseDomain = lib.mkOption {
      default = "greensroad.uk";
      type = lib.types.str;
      description = ''
        Base domain name to be used with homelab reverse proxy
      '';
    };
  };
  imports = [./grafana ./loki ./prometheus];
  config = lib.mkIf cfg.enable {
    services.nginx = {
      enable = true;
      recommendedTlsSettings = true;
      recommendedProxySettings = true;
    };

    # security.acme = {
    #   acceptTerms = true;
    #   defaults.email = "ed.rayne@gmail.com";
    # };
  };
}
