{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    viAlias = true;
    extraConfig = ''
      let mapleader = ";"
      " Use spaces instead of tabs
      set expandtab
      " Be smart when using tabs ;)
      set smarttab
      " display line numbers
      set number relativenumber
      " set to auto read when a file is changed from the outside
      set autoread
      " search will be case sensitive if it contains an uppercase letter
      set smartcase
      " :W sudo saves the file
      " (useful for handling the permission-denied error)
      command W w !sudo tee % > /dev/null
      " Finding files
      nnoremap <silent> <C-f> :Files<CR>
      " Finding in files
      nnoremap <silent> <Leader>f :Rg<CR>
    '';
    plugins = with pkgs.vimPlugins; [
      fzf-vim
      vim-flake8
      vim-fugitive
      vim-obsession
    ];
    extraPackages = with pkgs.python3Packages; [ black flake8 ];
  };
}
