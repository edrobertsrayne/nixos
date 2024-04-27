{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.shell.direnv;
in {
  options.shell.direnv.enable = mkEnableOption "Whether to enable direnv.";

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      config.global.warn_timeout = "5m";
    };

    home.sessionVariables.DIRENV_LOG_FORMAT = "";
  };
}
