{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.shell.zellij;
in {
  options.custom.shell.zellij.enable = mkEnableOption "Whether to enable zellij";

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
