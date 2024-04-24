{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.custom.bluetooth;
in {
  options.hardware.custom.bluetooth.enable = mkEnableOption "Bluetooth";

  config = mkIf cfg.enable {
    services.blueman.enable = true;
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
  };
}
