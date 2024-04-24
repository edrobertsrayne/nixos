{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.shell.zsh;
in {
  options.shell.zsh.enable = mkEnableOption "zsh shell";

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
