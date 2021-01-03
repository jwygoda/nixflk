{ pkgs, ... }: {
  imports = [ ./python ];

  environment.systemPackages = with pkgs; [
    git-crypt
    gopass
  ];

  documentation.dev.enable = true;

  programs.thefuck.enable = true;
}
