{ config, options, pkgs, ... }:
let
  inherit (config.hardware) pulseaudio;
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [ "FiraCode" ];
  };
in
{
  sound.enable = true;

  fonts.fonts = with pkgs; [ fira-code font-awesome nerdfonts ];

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      blueberry
      celluloid
      imv
      gnome3.adwaita-icon-theme
      gnome3.nautilus
      signal-desktop
      slurp
      spotify
      swaybg
      swaylock
      swayidle
      webtorrent_desktop
      wf-recorder
      wl-clipboard
      vlc
    ];
  };
}
