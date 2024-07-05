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
    programs.waybar = let
      transition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
    in {
      style = ''
        * {
          font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
          font-size: 14px;
        }
        window#waybar {
          opacity: 0.6;
        }
        #memory, #clock, #cpu, #disk, #battery, #bluetooth, #temperature, #network, #tray, #idle_inhibitor {
          margin: 4px;
          padding: 2px 8px;
        }
        #clock {
          border-radius: 10px;
          color: @base00;
          background: @base07;
        }
        #workspaces button {
          padding: 0px 5px;
          margin: 4px 3px;
          border-radius: 10px;
          border: 0px;
          opacity: 0.5;
          transition: ${transition};
          color: @base07;
          background: @base01;

        }
        #workspaces button.active {
          padding: 0px 5px;
          margin: 4px 3px;
          border-radius: 10px;
          border: 0px;
          transition: ${transition};
          opacity: 1.0;
          color: @base00;
          background: @base07;
        }
        #workspaces button:hover {
          border-radius: 10px;
          opacity: 0.8;
          transition: ${transition};
          color: @base05;
          background: @base02;
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
