{
  inputs,
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.common;
in {
  imports = [inputs.nix-colors.homeManagerModule];
  options.suites.common.enable = mkEnableOption "common suite";

  config = mkIf cfg.enable {
    colorscheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

    shell.zsh.enable = true;
    shell.starship.enable = true;
  };
}
