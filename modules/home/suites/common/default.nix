{
  inputs,
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.common;
in {
  options.suites.common.enable = mkEnableOption "common suite";

  config = mkIf cfg.enable {
    shell.zsh.enable = true;
    shell.starship.enable = true;

    services.gdrive.enable = true;
  };
}
