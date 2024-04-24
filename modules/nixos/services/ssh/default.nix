{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.services.ssh;
in {
  options.services.ssh.enable = mkEnableOption "SSH daemon";

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings.UseDns = true;
    };
  };
}
