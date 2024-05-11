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
    programs.waybar = {
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          modules-left = [
            "tray"
          ];
          modules-center = [
            "hyprland/workspaces"
          ];
          modules-right = [
            "temperature"
            "cpu"
            "memory"
            "disk"
            "pulseaudio"
            "battery"
            "clock"
          ];

          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
            tooltip = "true";
          };

          "hyprland/workspaces" = {
            format = "{name}";
            #format = "{icon}";
            format-icons = {
              default = " ";
              active = " ";
              urgent = " ";
            };
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
          };

          "clock" = {
            format = ''{:%H:%M}'';
            format-alt = ''󰸘 {:%A %B %d, %Y}'';
          };

          "hyprland/window" = {
            max-length = 25;
            separate-outputs = false;
            rewrite = {"" = " 🙈 No Windows? ";};
          };

          "memory" = {
            interval = 5;
            format = " {}%";
            tooltip = true;
          };

          "cpu" = {
            interval = 5;
            format = " {usage:2}%";
            tooltip = true;
          };

          "disk" = {
            format = " {free}";
            tooltip = true;
          };

          "network" = {
            format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
            format-ethernet = " {bandwidthDownOctets}";
            format-wifi = "{icon} {signalStrength}%";
            format-disconnected = "󰤮";
            tooltip = true;
            tooltip-format = "{ifname}: {ipddr}";
            tooltip-format-wifi = "{essid}: {ipaddr}";
          };

          "tray" = {
            spacing = 12;
          };

          "pulseaudio" = {
            format = "{icon} {volume}% {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-scroll-up = "wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%+";
            on-scroll-down = "wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%-";
          };

          "temperature" = {
            critical-threshold = 90;
            interval = 30;
            format = "{icon} {temperatureC}°C";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            tooltip = true;
          };

          "backlight" = {
            #device = "intel_backlight";
            format = "{icon} {percent}%";
            format-icons = ["" "" "" "" "" "" "" "" ""];
            on-scroll-down = "brillo -u 3000 -U 1";
            on-scroll-up = "brillo -u 30000 -A 1";
          };

          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            #format-alt = "{icon} {time}";
            format-charging = "󰂄 {capacity}%";
            format-plugged = "󱘖 {capacity}%";
            format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            on-click = "";
            tooltip = true;
            tooltip-format = "{time}";
            interval = 30;
          };

          "bluetooth" = {
            format = " {status}";
            format-connected = " {device_alias}";
            format-connected-battery = " {device_alias} {device_battery_percentage}%";
            # format-device-preference = [ "device1", "device2" ];
            tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
            tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
            tooltip-format-enumerate-connected-battery = "{device_alias}\t{defice_address}\t{device_battery_percentage}%";
            on-click = "blueman-manager";
            on-click-right = "rfkill toggle bluetooth";
          };
        };
      };
    };
  };
}
