{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.services.wireguard.client;
in {
  options.custom.services.wireguard.client = {
    enable = mkEnableOption "Whether to enable the wireguard client service";
  };

  config = mkIf cfg.enable {
    networking = {
      firewall.allowedUDPPorts = [51820];

      wireguard.interfaces = {
        wg0 = {
          ips = ["10.100.0.3/24"]; # ip and subnet of server end of tunnel
          listenPort = 51820;
          generatePrivateKeyFile = enable;
          peers = [
            {
              publicKey = "9xqt8T9gTtLTX1MjNyKJsY0CGzLqqGekvG9WUqwkyzs=";
              allowedIPs = ["0.0.0.0/0"];
              endpoint = "greensroad.tplinkdns.com:51820";
              persistentKeepalive = 25;
            }
          ];
        };
      };
    };
  };
}
