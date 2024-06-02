{
  inputs,
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.apps.nixvim;
in {
  options.custom.apps.nixvim.enable = mkEnableOption "Whether to enable nixvim";
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./opts.nix
    ./keymaps.nix
  ];
  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      enableMan = false;

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
