{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.shell.tmux;
in {
  options.custom.shell.tmux.enable = mkEnableOption "Whether tmux.";

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      mouse = true;
      shortcut = "s";
      newSession = true;
      plugins = with pkgs.tmuxPlugins; [
        catppuccin
        vim-tmux-navigator
      ];
      extraConfig = ''
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        set-option -g status-position top
      '';
    };
  };
}
