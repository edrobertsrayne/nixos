{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.development;
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

    apps = {
      nixvim.enable = true;
      lazygit.enable = true;
    };

    programs.ripgrep.enable = true;
    programs.fd.enable = true;
  };
}
