{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.shell.lf;
in {
  options.shell.lf.enable = mkEnableOption "Whether to enable lf";

  config = mkIf cfg.enable {
    programs.lf = {
      enable = true;
    };
  };
}
