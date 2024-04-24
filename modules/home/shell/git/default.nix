{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.shell.git;
in {
  options.shell.git.enable = mkEnableOption "Whether to enable git";

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Ed Roberts Rayne";
      userEmail = "ed.rayne@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };
  };
}
