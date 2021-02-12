{ config, pkgs, ... }:
let
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  waybar = pkgs.waybar.override { withMediaPlayer = true; };
in
{
  programs.waybar = {
    enable = true;
    package = waybar;
    settings = [
      {
        layer = "top";
        height = 30;
        modules-left = [ "sway/workspaces" "sway/mode" "custom/media" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "pulseaudio" "cpu" "memory" "temperature" "backlight" "battery" "clock" "tray" ];
        modules = {
          "sway/workspaces" = {
            disable-scroll = true;
            format = "{name} {icon}";
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              urgent = "";
              focused = "";
              default = "";
            };
          };
          "sway/mode" = {
            format = "<span style=\"italic\">{}</span>";
          };
          tray = {
            spacing = 10;
          };
          clock = {
            timezone = "Europe/Warsaw";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };
          cpu = {
            format = "{usage}% ";
            tooltip = false;
          };
          memory = {
            format = "{}% ";
          };
          temperature = {
            thermal-zone = 2;
            # "hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
            critical-threshold = 80;
            # "format-critical = "{temperatureC}°C ";
            format = "{temperatureC}°C ";
          };
          backlight = {
            format = "{percent}% {icon}";
            format-icons = [ "" "" ];
          };
          battery = {
            states = {
              good = 95;
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = [ "" "" "" "" "" ];
          };
          pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [ "" "" "" ];
            };
            on-click = pavucontrol;
          };
          "custom/media" = {
            format = "{icon} {}";
            return-type = "json";
            max-length = 40;
            format-icons = {
              spotify = "";
              default = "🎜";
            };
            escape = true;
            exec = "$(readlink $(which waybar))-mediaplayer.py --player spotify 2> /dev/null";
            # on-click = "swaymsg workspace 4";
          };
        };
      }
    ];
  };
}
