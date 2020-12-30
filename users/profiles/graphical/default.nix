{ pkgs, ... }:
{
  imports = [ ./kanshi ./sway ./waybar ./wlsunset ];

  programs.alacritty.enable = true;
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
