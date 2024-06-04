{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.darwin;
in {
  options.suites.darwin.enable = mkEnableOption "Whether to enable the darwin home suite.";

  config = mkIf cfg.enable {
    suites.development.enable = true;

    home = {
      stateVersion = "23.11";
      enableNixpkgsReleaseCheck = false;
    };

    apps.terminals.alacritty = {
      enable = true;
    };
  };
}
