{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.addons.pyprland;

  inherit (config.suites.desktop) terminal browser;
in {
  options.desktops.addons.pyprland.enable = mkEnableOption "Whether to enable pyprland plugins for hyprland.";

  config = mkIf cfg.enable {
    home.packages = [inputs.pyprland.packages.${pkgs.system}.pyprland];

    xdg.configFile."hypr/pyprland.toml".text = ''
      [pyprland]
      plugins = ["scratchpads"]

      [scratchpads.term]
      animation = "fromTop"
      command = "${terminal} --class scratchpad"
      class = "scratchpad"
      size = "60% 60%"

      [scratchpads.lf]
      animation = "fromTop"
      command = "${terminal} --class scratchpad -e lf"
      class = "scratchpad"
      size = "60% 60%"

      [scratchpads.btm]
      animation = "fromTop"
      command = "${terminal} --class scratchpad -e btm"
      class = "scratchpad"
      size = "60% 60%"

      [scratchpads.todoist]
      animation = "fromTop"
      command = "${browser} --app=https://app.todoist.com/app"
      class = "chrome-app.todoist.com__app-Default"
      size = "50% 50%"
      process_tracking = false

      [scratchpads.keep]
      animation = "fromTop"
      command = "${browser} --app=https://keep.google.com"
      class = "chrome-keep.google.com__-Default"
      size = "60% 75%"
      process_tracking = false

      [scratchpads.chatgpt]
      animation = "fromTop"
      command = "${browser} --app=https://chat.openai.com"
      class = "chrome-chat.openai.com__-Default"
      size = "50% 50%"
      process_tracking = false
    '';
  };
}
