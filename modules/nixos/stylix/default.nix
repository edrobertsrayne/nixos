{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  desktop = config.suites.desktop.enable;
in {
  config = {
    stylix = {
      enable = true;
      image = ./forest.png;
      polarity = "dark";
      #base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      cursor = mkIf desktop {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };
    };
  };
}
