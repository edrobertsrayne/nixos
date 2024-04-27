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
  };

  config = {
    users.users.${cfg.name} = {
      name = "${cfg.name}";
      home = "/Users/${cfg.name}";
      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;
  };
}
