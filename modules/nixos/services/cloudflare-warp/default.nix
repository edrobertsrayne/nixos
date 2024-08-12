{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.custom.services.cloudflare-warp;
in
  with lib;
  with lib.custom; {
    options.custom.services.cloudflare-warp.enable = mkEnableOption "Whether to enable Cloudflare Warp";

    config = mkIf cfg.enable {
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = with pkgs; [cloudflare-warp];
      systemd.services.cloudflare-warp = {
        wantedBy = ["multi-user.target"];
        after = ["pre-network.target"];
        description = "Cloudflare Warp";
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.cloudflare-warp}/bin/warp-svc";
          DynamicUser = "no";
          RuntimeDirectory = "cloudflare-warp";
          StateDirectory = "cloudflare-warp";
          LogsDirectory = "cloudflare-warp";
        };
      };
    };
  }
