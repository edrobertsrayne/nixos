{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.shell.eza;
in {
  options.shell.eza.enable = mkEnableOption "eza";

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      icons = true;
      git = true;
      enableZshIntegration = true;
    };

    programs.zsh = {
      shellAliases = {
        ls = "eza";
        ll = "eza -l";
        la = "eza -a";
        lla = "eza -la";
      };
      shellGlobalAliases.eza = "eza --icons --git";
    };
  };
}
