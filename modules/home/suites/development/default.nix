{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.development;

  hosts = ["nixpi" "thinkpad" "imac" "macbook-air"];
  sshConfigForHost = host: ''
    Host ${host}
      Hostname ${host}.local
      User ed
      RequestTTY yes
      RemoteCommand tmux -u new -A -s ssh
  '';
  sshConfig = builtins.concatStringsSep "\n" (map sshConfigForHost hosts);
in {
  options.suites.development.enable = mkEnableOption "development suite";

  config = mkIf cfg.enable {
    suites.common.enable = true;

    shell = {
      git.enable = true;
      eza.enable = true;
      fzf.enable = true;
      bat.enable = true;
      fuck.enable = true;
      zoxide.enable = true;
      lf.enable = true;
      direnv.enable = true;
    };

    custom.shell = {
      bottom.enable = true;
      tmux.enable = true;
    };

    apps = {
      lazygit.enable = true;
    };

    custom.apps.nixvim.enable = true;

    programs = {
      ripgrep.enable = true;
      fd.enable = true;
    };

    home.file.".ssh/config".text = sshConfig;
  };
}
