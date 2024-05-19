{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.services.wireguard.server;
in {
  options.custom.services.wireguard.server = {
    enable = mkEnableOption "Whether to enable the wireguard host";
    externalInterface = mkOption {
      type = types.str;
      default = "wlan0";
      description = "The external interface to use for the Wireguard host";
    };
  };

  config = mkIf cfg.enable {
    age.secrets.wireguard = {
      file = ../../../../../secrets/wireguard.age;
    };

    networking = {
      nat = {
        enable = true;
        inherit (cfg) externalInterface;
        internalInterfaces = ["wg0"];
      };
      firewall.allowedUDPPorts = [51820];

      wireguard.interfaces = {
        wg0 = {
          ips = ["10.100.0.1/24"]; # ip and subnet of server end of tunnel
          listenPort = 51820;
          postSetup = ''
            ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o wlan0 -j MASQUERADE
          '';
          postShutdown = ''
            ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o wlan0 -j MASQUERADE
          '';
          privateKeyFile = config.age.secrets.wireguard.path;
          peers = [
            {
              # phone
              publicKey = "9xqt8T9gTtLTX1MjNyKJsY0CGzLqqGekvG9WUqwkyzs=";
              allowedIPs = ["10.100.0.2/32"];
            }
            {
              # thinkpad
              publicKey = "9xqt8T9gTtLTX1MjNyKJsY0CGzLqqGekvG9WUqwkyzs=";
              allowedIPs = ["10.100.0.3/32"];
            }
          ];
        };
      };
    };
  };
}
