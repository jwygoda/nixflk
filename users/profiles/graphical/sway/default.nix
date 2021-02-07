{ lib, config, pkgs, ... }:
let
  alacritty = "${pkgs.alacritty}/bin/alacritty";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  clipman = "${pkgs.clipman}/bin/clipman";
  firefox = "${pkgs.firefox-devedition-bin}/bin/firefox-devedition";
  gebaard = "${pkgs.gebaar-libinput}/bin/gebaard";
  gopass = "${pkgs.gopass}/bin/gopass";
  grim = "${pkgs.grim}/bin/grim";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  spotify = "${pkgs.spotify}/bin/spotify";
  tmux = "${pkgs.tmux}/bin/tmux";
  waybar = "${pkgs.waybar}/bin/waybar";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
  wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
  wofi = "${pkgs.wofi}/bin/wofi";
  vscode = "${pkgs.vscode}/bin/code";
  xargs = "${pkgs.findutils}/bin/xargs";
in
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = {
      # Fixes GTK applications under Sway
      gtk = true;
      # To run Sway with dbus-run-session
      base = true;
    };
    extraSessionCommands = ''
      export MOZ_ENABLE_WAYLAND=1
    '';
    config = {
      assigns = {
        "1" = [{ app_id = "Alacritty"; }];
        "2" = [{ app_id = "firefox"; }];
        "3" = [{ title = "Visual Studio Code$"; }];
      };
      bars = [
        {
          command = waybar;
        }
      ];
      floating = {
        criteria = [
          { "app_id" = "org.gnome.Nautilus"; }
          { "app_id" = "blueberry.py"; }
          { "app_id" = "imv"; }
        ];
      };
      window = {
        commands = [
          {
            # https://github.com/i3/i3/issues/2060
            command = "move to workspace 4";
            criteria = { class = "Spotify"; };
          }
          {
            command = "move to workspace 5; workspace 5";
            criteria = { app_id = "celluloid"; };
          }
          {
            command = "move to workspace 5; workspace 5";
            criteria = { class = "WebTorrent"; };
          }
        ];
      };
      fonts = [ "Font Awesome" "Fira Code" ];
      gaps = {
        smartBorders = "on";
      };
      input = {
        "1:1:AT_Translated_Set_2_keyboard" = {
          xkb_layout = "pl,us";
          xkb_options = "caps:escape,grp:alt_shift_toggle";
        };
        "1739:0:Synaptics_TM3289-021" = {
          dwt = "enabled";
          tap = "enabled";
        };
      };
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute" = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle";
          "XF86MonBrightnessDown" = "exec ${brightnessctl} s 10%-";
          "XF86MonBrightnessUp" = "exec ${brightnessctl} s +10%";
          "Print" = "exec ${grim} Screenshots/$(date +'%Y-%m-%d-%H%M%S_grim.png')";
          "${modifier}+p" = "exec ${gopass} ls --flat | ${wofi} --show dmenu | ${xargs} --no-run-if-empty -- bash -c '${gopass} show -f $0 password' | head -n 1 | ${wl-copy}";
          "${modifier}+h" = "exec ${clipman} pick -t wofi";
        };
      menu = "${wofi} --show drun";
      modifier = "Mod4";
      startup = [
        {
          command = "systemctl --user restart kanshi.service";
          always = true;
        }
        { command = "${alacritty} -e ${tmux} new-session -As xddd"; }
        { command = firefox; }
        { command = vscode; }
        { command = spotify; }
        { command = "${gebaard} -b"; }
        { command = "${wl-paste} -t text --watch ${clipman} store"; }
      ];
      terminal = alacritty;
    };
    systemdIntegration = true;
  };
}
