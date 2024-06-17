{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.apps.vscode;
in {
  options.custom.apps.vscode.enable = mkEnableOption "Whether to enable Visual Studio Code.";

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      extensions = [];
      userSettings = {};
    };
  };
}
