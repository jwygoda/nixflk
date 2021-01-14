{ config, options, pkgs, ... }:
let
  inherit (config.hardware) pulseaudio;
in
{
  sound.enable = true;

  fonts.fonts = with pkgs; [ fira-code font-awesome ];

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      blueberry
      celluloid
      imv
      gnome3.adwaita-icon-theme
      gnome3.nautilus
      slurp
      spotify
      swaybg
      swaylock
      swayidle
      webtorrent_desktop
      wf-recorder
      wl-clipboard
    ];
  };
}
