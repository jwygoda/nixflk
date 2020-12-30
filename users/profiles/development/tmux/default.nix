{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # 0 is too far from ` ;)
      set -g base-index 1

      # Automatically set window title
      set-window-option -g automatic-rename on
      set-option -g set-titles on

      setw -g mode-keys vi
      setw -g monitor-activity on

      bind-key | split-window -h
      bind-key - split-window -v

      # Disable waiting after escape
      set -s escape-time 0
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      tmuxPlugins.copycat
      tmuxPlugins.open
      tmuxPlugins.pain-control
      tmuxPlugins.sessionist
      {
        plugin = tmuxPlugins.yank;
        extraConfig = ''
          set -g @custom_copy_command 'wl-copy'
        '';
      }
    ];
  };
}
