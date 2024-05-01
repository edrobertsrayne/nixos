{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.terminals.alacritty;
in {
  options.apps.terminals.alacritty = {
    enable = mkEnableOption "Whether to enable alacritty terminal emulator";
    fontSize = mkOption {
      type = types.int;
      default = 10;
      description = "Terminal font size.";
    };
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal.family = "JetBrainsMono Nerd Font";
          size = cfg.fontSize;
        };
        window = {
          decorations = "Buttonless";
          dynamic_padding = true;
          padding = {
            x = 5;
            y = 5;
          };
          opacity = 0.95;
        };
        import = [
          (pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/catppuccin/alacritty/main/catppuccin-macchiato.toml";
            hash = "sha256-jW+m/NubNPZmhBrkcFCMjlp2DDL7kFpm8ffktlLlVjo=";
          })
        ];
      };
    };
  };
}
