{lib, ...}: {
  options.homelab = {
    timeZone = lib.mkOption {
      default = "Europe/London";
      type = lib.types.string;
      description = ''
        Time zone to be used for homelab services
      '';
    };
    baseDomain = lib.mkOption {
      default = "greensroad.uk";
      type = lib.types.string;
      description = ''
        Base domain name to be used with homelab reverse proxy
      '';
    };
  };
  imports = [./grafana ./loki ./prometheus];
}
