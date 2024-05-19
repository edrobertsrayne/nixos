{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.services.blocky;
in {
  options.custom.services.blocky.enable = mkEnableOption "Whether to enable blockly adblocking.";

  config = mkIf cfg.enable {
    networking.nameservers = ["127.0.0.1"];

    networking.firewall = {
      allowedTCPPorts = [53];
      allowedUDPPorts = [53];
    };

    services.blocky = {
      enable = true;
      settings = {
        port = 53; # Port for incoming DNS Queries.
        upstream.default = [
          "https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
        ];
        # For initially solving DoH/DoT Requests when no system Resolver is available.
        bootstrapDns = {
          upstream = "https://one.one.one.one/dns-query";
          ips = ["1.1.1.1" "1.0.0.1"];
        };
        #Enable Blocking of certian domains.
        blocking = {
          blackLists = {
            ads = ["https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"];
            adult = ["https://blocklistproject.github.io/Lists/porn.txt"];
          };
          #Configure what block categories are used
          clientGroupsBlock = {
            default = ["ads"];
          };
        };
      };
    };
  };
}
