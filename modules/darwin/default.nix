{pkgs, ...}: {
  environment = {
    systemPath = ["/usr/local/bin"];
    pathsToLink = ["/Applications"];
    loginShell = pkgs.zsh;
  };

  fonts.packages = [(pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "Meslo"];})];

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    defaults = {
      finder.AppleShowAllExtensions = true;
      finder._FXShowPosixPathInTitle = true;
      dock.autohide = true;
    };

    stateVersion = 4;
  };

  services.nix-daemon.enable = true;

  nix.extraOptions = "experimental-features = nix-command flakes";

  documentation.enable = false;

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = {};
    casks = [
      "alacritty"
      "raycast"
      "processing"
      "github"
      "arduino-ide"
      "microsoft-edge"
      "kicad"
      "google-chrome"
      "google-drive"
      "steam"
      "visual-studio-code"
    ];
    taps = ["koekeishiya/formulae"];
    brews = ["yabai"];
  };
}
