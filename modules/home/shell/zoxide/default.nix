{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.shell.zoxide;
in {
  options.shell.zoxide.enable = mkEnableOption "Whether to enable zoxide";

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
    };
  };
}
