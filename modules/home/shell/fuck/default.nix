{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.shell.fuck;
in {
  options.shell.fuck.enable = mkEnableOption "Whether to enable thefuck";

  config = mkIf cfg.enable {
    programs.thefuck = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
