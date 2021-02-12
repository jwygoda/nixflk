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
      " Enable file type detection
      filetype on
      filetype plugin indent on
      let mapleader = ";"
      " Use spaces instead of tabs
      set expandtab
      " display line numbers
      set number relativenumber
      " set to auto read when a file is changed from the outside
      set autoread
      " search will be case sensitive if it contains an uppercase letter
      set smartcase
      " Stamping
      nnoremap S diw"0P
      " clear search by hitting return
      nnoremap <CR> :noh<CR><CR>
      " Finding files
      nnoremap <silent> <C-f> :Files<CR>
      " Finding in files
      nnoremap <silent> <Leader>a :Ag<CR>
      nnoremap <silent> <Leader>f :Rg<CR>
      " Toggle the Tagbar
      nnoremap <F11> :TagbarToggle<CR>
      " Use deoplete.
      let g:deoplete#enable_at_startup = 1
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
      " Enable solarized color scheme
      syntax enable
      set background=dark
      colorscheme solarized
    '';
    plugins = with pkgs.vimPlugins; [
      colors-solarized
      deoplete-nvim
      deoplete-jedi
      fzf-vim
      ranger-vim
      tagbar
      vim-flake8
      vim-fugitive
      vim-obsession
    ];
    extraPackages = [ pkgs.universal-ctags ];
    extraPython3Packages = ps: with ps; [ black flake8 jedi pynvim ];
  };
}
