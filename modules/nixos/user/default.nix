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
    initialHashedPassword = mkOption {
      type = str;
      default = "$y$j9T$l/8vfi4405Pd6Rpu1BYbM0$eFcd8f7CEbwgkacXNAaU4YcghSoy5krFXZgVmzu47j9";
      description = "The initial password to use";
    };
    extraGroups = mkOption {
      type = listOf str;
      default = ["networkmanager" "adbusers"];
      description = "Groups for the user to join";
    };
  };

  config = {
    users.users.${cfg.name} = {
      isNormalUser = true;
      inherit (cfg) name initialHashedPassword;
      home = "/home/${cfg.name}";
      group = "users";
      extraGroups =
        [
          "users"
          "wheel"
          "tty"
          "audio"
          "video"
          "dialout"
          "input"
          "docker"
        ]
        ++ cfg.extraGroups;
      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;
  };
}
