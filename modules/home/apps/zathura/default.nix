{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.apps.zathura;
in {
  options.custom.apps.zathura.enable = mkEnableOption "Whether to enable zathura";

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
    };
  };
}
