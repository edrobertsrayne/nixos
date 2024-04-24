{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.xkb;
in {
  options.system.xkb.enable = mkEnableOption "Whether to enable XKB configuration";

  config = mkIf cfg.enable {
    services.xserver = {
      xkb = {
        layout = "gb";
        variant = "";
        options = "caps:escape";
      };
    };
    console.useXkbConfig = true;
  };
}
