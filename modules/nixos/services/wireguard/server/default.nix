{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.services.wireguard.server;
in {
  options.custom.services.wireguard.server = {
    enable = mkEnableOption "Whether to enable the wireguard host";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.wireguard-tools];

    sops.secrets = {
      "wireguard/server/private-key" = {};
    };

    networking.firewall.interfaces."wg0" = {
      allowedTCPPorts = [53];
      allowedUDPPorts = [53];
    };
    networking.firewall = {
      allowedUDPPorts = [51820];
    };
    networking.useNetworkd = true;

    services.resolved.extraConfig = ''
      DNSStubListener=no
    '';

    boot.kernel.sysctl = {
      "net.ipv4.conf.all.forwarding" = true;
    };

    services.dnsmasq =
      if config.custom.services.blocky.enable
      then {enable = false;}
      else {
        enable = true;
        settings.interface = "wg0";
      };

    systemd.network = {
      netdevs = {
        "90-wg0" = {
          netdevConfig = {
            Kind = "wireguard";
            Name = "wg0";
          };
          wireguardConfig = {
            PrivateKeyFile = config.sops.secrets."wireguard/server/private-key".path;
            ListenPort = 51820;
          };
          wireguardPeers = [
            # client 1
            {
              wireguardPeerConfig = {
                PublicKey = "6uh1CPUJscxuTfrhiKj76741tsmp/cJYp7VqaIDzigo=";
                AllowedIPs = ["10.100.0.2"];
                PersistentKeepalive = 15;
              };
            }
          ];
        };
      };
      networks.wg0 = {
        matchConfig = {Name = "wg0";};
        address = ["10.100.0.1/24"];
        networkConfig = {
          IPForward = true;
          IPMasquerade = "ipv4";
        };
      };
    };
  };
}
