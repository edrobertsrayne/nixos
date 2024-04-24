{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.addons.anyrun;
in {
  imports = [inputs.anyrun.homeManagerModules.default];

  options.desktops.addons.anyrun.enable = mkEnableOption "Whether to enable anyrun launcher";

  config = mkIf cfg.enable {
    programs.anyrun = {
      enable = true;
      config = {
        plugins = with inputs.anyrun.packages.${pkgs.system}; [
          applications
          shell
          symbols
          rink
          randr
          websearch
        ];
        width.fraction = 0.3;
        y.fraction = 0.3;
        x.fraction = 0.5;
        hidePluginInfo = true;
        closeOnClick = true;
      };
      extraCss = builtins.readFile ./theme.css;
      extraConfigFiles."applications.ron".text = ''
        Config(
          desktop_actions: false,
          max_entries: 5,
          terminal: Some("alacritty"),
        )
      '';
    };
  };
}
