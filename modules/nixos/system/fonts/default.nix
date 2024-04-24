{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.fonts;
in {
  options.system.fonts.enable = mkEnableOption "desktop fonts";

  config = mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        font-awesome
        material-symbols
        gnome.adwaita-icon-theme

        corefonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        roboto
        vistafonts
        jetbrains-mono
        meslo-lg

        (nerdfonts.override {fonts = ["Meslo" "JetBrainsMono"];})
      ];

      enableDefaultPackages = false;

      fontconfig.defaultFonts = {
        serif = ["Noto Serif" "Noto Color Emoji"];
        sansSerif = ["Noto" "Noto Color Emoji"];
        monospace = ["JetBrains Mono" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
