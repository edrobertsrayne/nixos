{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.shell.tmux;

  statusPill = with config.lib.stylix.colors.withHashtag;
    {
      content,
      symbol,
      leftSeparator ? "",
      rightSeparator ? "",
      color ? base06,
      invert ? false,
      shortcut ? false,
      shortcutColor ? base08,
    }:
      if invert
      then ''
        #[fg=${base02}, bg=default]${leftSeparator}\
        #[fg=${base05}, bg=${base02}]${content} \
        #[fg=${base00}, bg=${color}] ${symbol}#[fg=${color}, bg=default]${rightSeparator}\
        #[fg=default, bg=default]''
      else if shortcut
      then ''              
        #{?client_prefix,#[fg=${shortcutColor}],#[fg=${color}]}#[bg=default]${leftSeparator}\
        #{?client_prefix,#[bg=${shortcutColor}],#[bg=${color}]}#[fg=${base00}]${symbol} \
        #[fg=${base05}, bg=${base02}] ${content}\
        #[fg=${base02},bg=default]${rightSeparator}#[fg=default, bg=default]''
      else ''
        #[fg=${color}, bg=default]${leftSeparator}#[fg=${base00}, bg=${color}]${symbol} \
        #[fg=${base05}, bg=${base02}] ${content}\
        #[fg=${base02},bg=default]${rightSeparator}#[fg=default, bg=default]'';
in {
  options.custom.shell.tmux.enable = mkEnableOption "Whether to enable tmux.";

  config = mkIf cfg.enable {
    stylix.targets.tmux.enable = mkForce false;

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
      extraConfig = with config.lib.stylix.colors.withHashtag; ''
         set-option -sa terminal-features ',alacritty:RGB'

         bind | split-window -h -c "#{pane_current_path}"
         bind - split-window -v -c "#{pane_current_path}"

         set-option -g base-index 1
         set-option -g pane-base-index 0

         set-option -g status-position top
         set-option -g status-left-length 30
         set-option -g status-right-length 150

         set-option -g status-style bg=default,fg=default

         set-option -g status-left "";
         set-option -g status-right "\
         ${(statusPill {
          content = "#(whoami)";
          symbol = "󰀄";
          color = base0E;
        })} \
        ${(statusPill {
          content = "#H";
          symbol = "󰆼";
          color = base0C;
        })} \
        ${(statusPill {
          content = "%d-%b-%Y %R";
          symbol = "󰃰";
          color = base0D;
        })} \
        ${(statusPill {
          content = "#{session_name}";
          symbol = "󰆍";
          color = base0B;
          shortcutColor = base08;
          shortcut = true;
        })}"

         set-option -g window-status-format "${(statusPill {
          content = "#W";
          symbol = "#I";
          color = base0D;
          invert = true;
        })}"

         set-option -g window-status-current-format "${(statusPill {
          content = "#W";
          symbol = "#I";
          color = base09;
          invert = true;
        })}"
      '';
    };
  };
}
