{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.desktops.addons.rofi;
in {
  options.custom.desktops.addons.rofi = {
    enable = mkEnableOption "Whether to eneable rofi application launcher.";
    package = mkPackageOption pkgs "rofi-wayland" {};
  };
  config = mkIf cfg.enable {
    programs.rofi = {
      inherit (cfg) package enable;
      font = "Noto 12";
      extraConfig = {
        modi = "run,drun,window";
        show-icons = true;
        disable-history = false;
        drun-display-format = "{icon} {name}";
        hide-scrollbar = true;
        display-drun = "   Apps ";
        display-run = "   Run ";
        display-window = " 﩯  Window";
        display-Network = " 󰤨  Network";
      };
    };
  };
}
