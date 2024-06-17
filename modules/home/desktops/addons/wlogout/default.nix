{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktops.addons.wlogout;

  bgImageSection = name: ''
    #${name} {
      border-radius: 20px;
      margin: 10px;
      background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/${name}.png"));
    }
  '';

  colorize = "40";
  fill = "black";
  blur = "0x8";

  wallpaper = pkgs.runCommand "blurred.png" {} ''
    ${pkgs.imagemagick}/bin/convert "${config.stylix.image}" \
    -fill ${fill} \
    -colorize "${colorize}%" \
    -blur ${blur} \
    $out
  '';
in {
  options.desktops.addons.wlogout.enable = mkEnableOption "Whether to enable wlogout";

  config = mkIf cfg.enable {
    programs.wlogout = with config.lib.stylix.colors; {
      enable = true;

      layout = [
        {
          label = "lock";
          action = "sleep 1; hyprlock";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "hibernate";
          action = "sleep 1; systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
        }
        {
          label = "logout";
          action = "sleep 1; pkill Hyprland";
          text = "Exit";
          keybind = "e";
        }
        {
          label = "shutdown";
          action = "sleep 1; systemctl poweroff";
          text = "Shutdown";
          keybind = "s";
        }
        {
          label = "suspend";
          action = "sleep 1; systemctl suspend";
          text = "Suspend";
          keybind = "u";
        }
        {
          label = "reboot";
          action = "sleep 1; systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
      ];

      style = with config.stylix.fonts; ''
        * {
          font-family: ${emoji.name}, ${sansSerif.name};
        }

        window {
          background-image: url("${wallpaper}");
        }

        button {
          background: rgba(0, 0, 0, .4);
          border: 2px solid #${base04};
          border-radius: 8px;
          box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .1), 0 0 rgba(0, 0, 0, .5);
          margin: 1rem;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
          font-size: 20px;
        }

        button:focus, button:active, button:hover {
          background-color: rgba(255, 255, 255, 0.1);
          border: 3px solid #${base0D};
          outline-style: none;
        }

        ${lib.concatMapStringsSep "\n" bgImageSection [
          "lock"
          "logout"
          "suspend"
          "hibernate"
          "shutdown"
          "reboot"
        ]}
      '';
    };
  };
}
