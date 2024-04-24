{pkgs, ...}: {
  suites.desktop = {
    enable = true;
    wallpaper = pkgs.custom.wallpapers.minimalsunrise;
  };

  home.stateVersion = "23.11";
}
