{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.nix;
in {
  options.system.nix.enable = mkEnableOption "Manage nix configuration";

  config = mkIf cfg.enable {
    nix = {
      settings = {
        trusted-users = ["root" "@wheel"];
        #auto-optimise-store = lib.mkDefault true;
        use-xdg-base-directories = true;
        experimental-features = ["nix-command" "flakes"];
        warn-dirty = false;

        builders-use-substitutes = true;
        substituters = [
          "https://hyprland.cachix.org"
        ];

        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
      };
    };
  };
}
