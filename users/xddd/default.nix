{ lib, pkgs, ... }:
let
  inherit (builtins) toFile readFile;
  inherit (lib) fileContents mkForce;

  name = "Jarosław Wygoda";
in
{
  imports = [ ../../profiles/custom/development ../../profiles/custom/graphical ../../profiles/custom/laptop ];

  home-manager.users.xddd = {
    imports = [ ../profiles/development ../profiles/graphical ];

    home = {
      stateVersion = "21.03";

      packages = with pkgs; [
        amfora
        dropbox-cli.nautilusExtension
        gebaar-libinput
        ranger
        sidequest
        wofi
        ydotool
      ];
      # TODO: add this stuff to home-manager
      file = {
        ".config/gebaar" = {
          source = ./gebaar;
          recursive = true;
        };
        ".config/wofi" = {
          source = ./wofi;
          recursive = true;
        };
      };
    };

    programs.bash.enable = true;

    programs.git = {
      userName = name;
      userEmail = "jaroslaw@wygoda.me";
    };

    programs.gpg.enable = true;

    programs.ssh = {
      enable = true;
      hashKnownHosts = true;

      matchBlocks =
        let
          bitbucketKey = toFile "bitbucket" (readFile ../../secrets/bitbucket);

          githubKey = toFile "github" (readFile ../../secrets/github);

          gitlabKey = toFile "gitlab" (readFile ../../secrets/gitlab);

          netsomeGitlabKey = toFile "netsome_gitlab" (readFile ../../secrets/netsome_gitlab);
        in
        {
          github = {
            host = "github.com";
            identityFile = githubKey;
            extraOptions = { AddKeysToAgent = "yes"; };
          };

          gitlab = {
            host = "gitlab.com";
            identityFile = gitlabKey;
            extraOptions = { AddKeysToAgent = "yes"; };
          };

          netsome_gitlab = {
            host = "netsome.gitlab.com";
            hostname = "gitlab.com";
            identityFile = netsomeGitlabKey;
            extraOptions = { AddKeysToAgent = "yes"; };
          };

          bitbucket = {
            host = "bitbucket.org";
            identityFile = bitbucketKey;
            extraOptions = { AddKeysToAgent = "yes"; };
          };
        };
    };

    services.dropbox.enable = true;

    services.gpg-agent.enable = true;

    services.udiskie.enable = true;
  };

  boot.supportedFilesystems = [ "ntfs" ];

  # https://github.com/ReimuNotMoe/ydotool/issues/25#issuecomment-535842993
  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';

  programs.adb.enable = true;

  users.users.xddd = {
    uid = 1000;
    description = name;
    isNormalUser = true;
    hashedPassword = fileContents ../../secrets/xddd;
    extraGroups = [ "adbusers" "docker" "input" "networkmanager" "wheel" ];
  };
}
