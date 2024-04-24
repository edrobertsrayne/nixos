{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.user;
in {
  options.user = with types; {
    name = mkOption {
      type = str;
      default = "ed";
      description = "The name of the user's account";
    };
    initialPassword = mkOption {
      type = str;
      default = "password";
      description = "The initial password to use";
    };
    extraGroups = mkOption {
      type = listOf str;
      default = [];
      description = "Groups for the user to join";
    };
  };

  config = {
    users.users.${cfg.name} = {
      isNormalUser = true;
      inherit (cfg) name initialPassword;
      home = "/home/${cfg.name}";
      group = "users";
      extraGroups = ["wheel" "audio" "sound" "video" "networkmanager" "input" "tty" "adbusers"] ++ cfg.extraGroups;
      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;
  };
}
