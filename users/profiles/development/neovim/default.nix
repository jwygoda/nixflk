{ pkgs, ... }:
let
  alacritty = "${pkgs.alacritty}/bin/alacritty";
in
{
  home.sessionVariables = {
    EDITOR = "vi";
  };

  programs.neovim = {
    enable = true;
    withPython3 = true;
    viAlias = true;
    vimdiffAlias = true;
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
      " clear search by hitting return
      nnoremap <CR> :noh<CR><CR>
      " Finding files
      nnoremap <silent> <C-f> :Files<CR>
      " Finding in files
      nnoremap <silent> <Leader>a :Ag<CR>
      nnoremap <silent> <Leader>f :Rg<CR>
      " https://github.com/rafaqz/ranger.vim/
      let g:ranger_terminal = '${alacritty} -e'
      nnoremap <Leader>rr :RangerEdit<cr>
      nnoremap <Leader>rv :RangerVSplit<cr>
      nnoremap <Leader>rs :RangerSplit<cr>
      nnoremap <Leader>rt :RangerTab<cr>
      nnoremap <Leader>ri :RangerInsert<cr>
      nnoremap <Leader>ra :RangerAppend<cr>
      nnoremap <Leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
      nnoremap <Leader>rd :RangerCD<cr>
      nnoremap <Leader>rld :RangerLCD<cr>
    '';
    plugins = with pkgs.vimPlugins; [
      fzf-vim
      ranger-vim
      vim-flake8
      vim-fugitive
      vim-obsession
    ];
    extraPackages = with pkgs.python3Packages; [ black flake8 ];
  };
}
