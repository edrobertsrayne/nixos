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
      fileWidgetOptions = [
        "--walker-skip .git,node_modules,target"
        "--preview 'bat -n --color=always {}'"
        "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
      ];
    };
  };
}
