{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.lazygit;
in {
  options.apps.lazygit.enable = mkEnableOption "Whether to enable lazygit";

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          nerdFontsVersion = 3;
        };
        os.editPreset = "nvim";
      };
    };
  };
}
