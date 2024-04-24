{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.module;
in {
  options.module.enable = mkEnableOption "Whether to enable module";

  config =
    mkIf cfg.enable {
    };
}
