{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.shell.bat;
in {
  options.shell.bat.enable = mkEnableOption "bat";

  config = mkIf cfg.enable {
    programs = {
      bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batwatch prettybat];
        config = {
          map-syntax = ["*.ino:C++"];
        };
      };
      /*
      zsh = {
        shellAliases = {
          man = "batman";
          diff = "batdiff";
          grep = "batgrep";
          cat = "bat";
        };
      };
      */
    };
  };
}
