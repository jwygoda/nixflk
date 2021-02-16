{ pkgs, ... }: {
  imports = [ ./python ./virt ];

  environment.systemPackages = with pkgs; [
    git-crypt
    gopass
    pre-commit
  ];

  documentation.dev.enable = true;

  programs.thefuck.enable = true;
}
