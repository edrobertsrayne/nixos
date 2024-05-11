{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.custom.desktops.addons.waybar;
in {
  config = mkIf cfg.enable {
    programs.waybar = with config.colorScheme.palette; let
      transition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
      base = "#${base00}";
      mantle = "#${base01}";
      surface = "#${base02}";
      accent = "#${base07}";
      text = "#${base05}";
    in {
      style = ''
        * {
          font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
          font-size: 14px;
        }
        window#waybar {
          background: ${base};
          color: ${text};
          opacity: 0.6;
        }
        #memory, #clock, #cpu, #disk, #battery, #bluetooth, #temperature, #network, #tray, #idle_inhibitor {
          margin: 4px;
          padding: 2px 8px;
        }
        #clock {
          border-radius: 10px;
          background: ${accent};
          color: ${base};
        }
        #workspaces button {
          padding: 0px 5px;
          margin: 4px 3px;
          border-radius: 10px;
          border: 0px;
          color: ${accent};
          background: ${mantle};
          opacity: 0.5;
          transition: ${transition};

        }
        #workspaces button.active {
          padding: 0px 5px;
          margin: 4px 3px;
          border-radius: 10px;
          border: 0px;
          color: ${base};
          background: ${accent};
          transition: ${transition};
          opacity: 1.0;
        }
        #workspaces button:hover {
          border-radius: 10px;
          color: ${text};
          background: ${surface};
          opacity: 0.8;
          transition: ${transition};
        }
        @keyframes swiping {
          0% {
            background-position: 0% 200%;
          }
          100% {
            background-position: 200% 200%;
          }
        }
      '';
    };
  };
}
