{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.services.gdrive;
in {
  options.services.gdrive.enable = mkEnableOption "Whether to enable rclone Google Drive sync.";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [rclone];

    systemd.user.services.rclone-gdrive-mount = {
      Unit = {
        Description = "Service that connects to Google Drive";
        #After = ["network-online.target"];
        #Requires = ["network-online.target"];
      };
      Install = {
        WantedBy = ["default.target"];
      };
      Service = let
        # TODO: Get the username from home manager
        username = "ed";
        gdriveDir = "/home/${username}/gdrive";
      in {
        Type = "simple";
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${gdriveDir}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full gdrive: ${gdriveDir}";
        ExecStop = "/run/current-system/sw/bin/fusermount -u ${gdriveDir}";
        Restart = "on-failure";
        RestartSec = "10s";
        Environment = ["PATH=/run/wrappers/bin:$PATH"];
      };
    };
  };
}
