{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.nixvim;
in {
  options.apps.nixvim.enable = mkEnableOption "nixvim";

  config =
    mkIf cfg.enable
    {
home.packages = with pkgs; [
inputs.nixvim.packages.${system}.default
lazygit
stylua
ripgrep];
    };
}
