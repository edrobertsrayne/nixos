{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.addons.xdg;
in {
  options.desktops.addons.xdg = with types; {
    enable = mkEnableOption "Whether to manage XDG configuration.";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      HISTFILE = lib.mkForce "${config.xdg.stateHome}/bash/history";
      GTK2_RC_FILES = lib.mkForce "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };

    xdg = {
      enable = true;
      cacheHome = config.home.homeDirectory + "/.local/cache";

      userDirs = {
        enable = true;
        desktop = "${config.home.homeDirectory}";
        documents = "${config.home.homeDirectory}/documents";
        download = "${config.home.homeDirectory}/downloads";
        music = "${config.home.homeDirectory}/music";
        pictures = "${config.home.homeDirectory}/pictures";
        publicShare = "${config.home.homeDirectory}/public";
        templates = "${config.home.homeDirectory}/templates";
        videos = "${config.home.homeDirectory}/videos";

        createDirectories = true;

        extraConfig = {
          XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
        };
      };
    };
  };
}
