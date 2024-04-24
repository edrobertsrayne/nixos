{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.shell.fzf;
in {
  options.shell.fzf.enable = mkEnableOption "Whether to enable fzf";

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
