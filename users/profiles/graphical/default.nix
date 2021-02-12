{ pkgs, ... }:
{
  imports = [ ./kanshi ./sway ./waybar ./wlsunset ];

  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = "#282828";
          foreground = "#ebdbb2";
        };
        normal = {
          black = "#282828";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
        };
        bright = {
          black = "#928374";
          red = "#fb4934";
          green = "#b8bb26";
          yellow = "#fabd2f";
          blue = "#83a598";
          magenta = "#d3869b";
          cyan = "#8ec07c";
          white = "#ebdbb2";
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
