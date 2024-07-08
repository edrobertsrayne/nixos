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
  options.custom.shell.tmux.enable = mkEnableOption "Whether to enable tmux.";

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      mouse = true;
      shortcut = "s";
      terminal = "tmux-256color";
      newSession = true;
      shell = "${pkgs.zsh}/bin/zsh";
      escapeTime = 0;
      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
      ];
      extraConfig = ''
        set-option -sa terminal-features ',alacritty:RGB'

        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        set-option -g status-position top
      '';
    };
  };
}
