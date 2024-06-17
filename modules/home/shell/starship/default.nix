{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.shell.starship;
in {
  options.shell.starship.enable = mkEnableOption "starship shell";

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        command_timeout = 1000;
      };
    };
  };
}
