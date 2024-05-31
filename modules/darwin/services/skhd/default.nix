{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.services.skhd;
in {
  options.custom.services.skhd.enable = mkEnableOption "Whether to enable skhd hotkey daemon";

  config = mkIf cfg.enable {
    services.skhd = {
      enable = true;
      skhdConfig = builtins.readFile ./skhdrc;
    };
  };
}
