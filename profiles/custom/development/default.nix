{ pkgs, ... }: {
  imports = [ ./python ];

  environment.systemPackages = with pkgs; [
    git-crypt
  ];

  documentation.dev.enable = true;

  programs.thefuck.enable = true;
}
