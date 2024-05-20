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
      location = "center";
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
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
        with config.colorScheme.palette; {
          "*" = {
            margin = mkLiteral "0px";
            padding = mkLiteral "0px";
            spacing = mkLiteral "0px";
          };
          window = {
            width = 480;
            border-radius = mkLiteral "24px";
          };
          mainbox = {
            padding = mkLiteral "12px";
          };
          inputbar = {
            border = mkLiteral "2px";
            border-radius = mkLiteral "16px";
            padding = mkLiteral "8px 16px";
            spacing = mkLiteral "8px";
            children = map mkLiteral ["prompt" "entry"];
          };
          entry = {
            placeholder = "Search";
            placeholder-color = mkLiteral "#${base03}";
          };
          message = {
            margin = mkLiteral "12px 0 0 ";
            border-radius = mkLiteral "16px";
          };
          textbox = {padding = mkLiteral "8px 24px";};
          listview = {
            background-color = mkLiteral "transparent";
            margin = mkLiteral "12px 0 0";
            lines = 8;
            columns = 1;
            fixed-height = mkLiteral "false";
          };
          element = {
            padding = mkLiteral "8px 16px";
            spacing = mkLiteral "8px";
            border-radius = mkLiteral "16px";
          };
          "element normal active" = {text-color = mkLiteral "#${base07}F2";};
          "element selected" = {text-color = mkLiteral "#${base01}";};
          "element selected normal, element selected active" = {
            background-color = mkLiteral "#${base07}F2";
          };
          element-icon = {
            size = mkLiteral "1em";
            vertical-align = mkLiteral "0.5";
          };
          element-text = {
            text-color = mkLiteral "inherit";
          };
        };
    };
  };
}
