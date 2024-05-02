{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.services.influxdb;
in {
  options.custom.services.influxdb.enable = mkEnableOption "Whether to enable influxdb database service.";

  config = mkIf cfg.enable {
    services.influxdb2 = {
      enable = true;

      provision = {
        enable = true;
        initialSetup = {
          organization = "main";
          bucket = "bucket";
        };
      };
    };
  };
}
