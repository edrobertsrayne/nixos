{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.shell.bottom;
in {
  options.custom.shell.bottom.enable = mkEnableOption "Whether to enable bottom, a cross-platform graphical process/system monitor with a customizable interface.";

  config = mkIf cfg.enable {
    programs.bottom.enable = true;
  };
}
