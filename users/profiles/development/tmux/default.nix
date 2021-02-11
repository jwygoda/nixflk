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

      bind-key | split-window -h -c '#{pane_current_path}'
      bind-key - split-window -v -c '#{pane_current_path}'

      # Disable waiting after escape
      set -s escape-time 0

      # https://github.com/neovim/neovim/wiki/FAQ#colors-arent-displayed-correctly
      # set-option -g default-terminal "screen-256color"
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          # https://github.com/tmux-plugins/tmux-resurrect/issues/108
          set -g @resurrect-processes '"~nvim->sh -c \"vi -S && exit\""'
        '';
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
