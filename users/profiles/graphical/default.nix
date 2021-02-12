{ pkgs, ... }:
{
  imports = [ ./kanshi ./sway ./waybar ./wlsunset ];

  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = "#002b36";
          foreground = "#839496";
        };
        cursor = {
          text = "#002b36";
          cursor = "#839496";
        };
        normal = {
          black = "#073642";
          red = "#dc322f";
          green = "#859900";
          yellow = "#b58900";
          blue = "#268bd2";
          magenta = "#d33682";
          cyan = "#2aa198";
          white = "#eee8d5";
        };
        bright = {
          black = "#002b36";
          red = "#cb4b16";
          green = "#586e75";
          yellow = "#657b83";
          blue = "#839496";
          magenta = "#6c71c4";
          cyan = "#93a1a1";
          white = "#fdf6e3";
        };
      };
    };
  };
  programs.chromium.enable = true;
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin;
  };
  programs.google-chrome-dev.enable = true;
  programs.mako.enable = true;
  programs.vscode = {
    enable = true;
    extensions = [
      pkgs.vscode-extensions.ms-python.python
    ];
    userSettings = {
      "editor.fontFamily" = "Fira Code";
      "editor.fontLigatures" = true;
      "update.channel" = "none";
      "window.menuBarVisibility" = "toggle";
    };
  };
  services.network-manager-applet.enable = true;
}
