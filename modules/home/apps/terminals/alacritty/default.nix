{
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
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          decorations = "Buttonless";
          dynamic_padding = true;
          padding = {
            x = 10;
            y = 10;
          };
        };
      };
    };
  };
}
