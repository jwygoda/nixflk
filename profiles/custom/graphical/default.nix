{ pkgs, ... }:
{
  imports = [ ./sway ../network ];

  hardware.pulseaudio.enable = true;
}
