{ pkgs, ... }:
{
  services.kanshi = {
    enable = true;
    profiles = {
      nomad = {
        outputs = [{
          criteria = "Unknown 0x2336 0x00000000";
          scale = 1.5;
        }];
      };
      nomad2 = {
        outputs = [{
          criteria = "Unknown 0x313D 0x00000000";
        }];
      };
      desktop = {
        outputs = [
          {
            criteria = "Unknown 0x2336 0x00000000";
            position = "427,1440";
            scale = 1.5;
          }
          {
            criteria = "Iiyama North America PL3270Q 1155100321782";
          }
        ];
        exec = ''
          exec \${pkgs.sway}/bin/swaymsg workspace 2, move workspace to HDMI-A-1
          exec \${pkgs.sway}/bin/swaymsg workspace 3, move workspace to HDMI-A-1
        '';
      };
      desktop2 = {
        outputs = [
          {
            criteria = "Unknown 0x313D 0x00000000";
            position = "427,1440";
          }
          {
            criteria = "Iiyama North America PL3270Q 1155100321782";
          }
        ];
        exec = ''
          exec \${pkgs.sway}/bin/swaymsg workspace 2, move workspace to HDMI-A-1
          exec \${pkgs.sway}/bin/swaymsg workspace 3, move workspace to HDMI-A-1
        '';
      };
      projector = {
        outputs = [
          {
            criteria = "eDP-1";
            position = "0,1080";
            scale = 1.5;
          }
          {
            criteria = "Optoma Corporation Optoma 1080P Q7AF8310397";
          }
        ];
        exec = ''
          exec \${pkgs.sway}/bin/swaymsg workspace 2, move workspace to HDMI-A-1
          exec \${pkgs.sway}/bin/swaymsg workspace 3, move workspace to HDMI-A-1
        '';
      };
    };
  };
}
