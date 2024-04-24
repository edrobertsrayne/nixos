{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.services.sound;
in {
  options.services.sound.enable = mkEnableOption "sound";

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
