{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.nh;
in {
  options.apps.nh.enable = mkEnableOption "nh: nix helper";

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/${config.user.name}/.dotfiles";
    };
  };
}
