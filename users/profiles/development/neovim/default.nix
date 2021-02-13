{ pkgs, ... }:
let
  alacritty = "${pkgs.alacritty}/bin/alacritty";
  rnvimr = pkgs.vimUtils.buildVimPlugin {
    name = "rnvimr";
    passthru.python3Dependencies = ps: with ps; [ pynvim ];
    src = pkgs.fetchFromGitHub {
      owner = "kevinhwang91";
      repo = "rnvimr";
      rev = "0414b376d93ab81c6ae4e32d113e458d2b2ca46d";
      sha256 = "sha256-LK4NIFKFhc7PzD+MYNNR2YY46hJrD7uF2CZPbl5l4Z0=";
    };
  };
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
      " https://github.com/kevinhwang91/rnvimr
      tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
      nnoremap <silent> <M-o> :RnvimrToggle<CR>
      tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
      " Make Ranger replace Netrw and be the file explorer
      let g:rnvimr_enable_ex = 1
      " Make Ranger to be hidden after picking a file
      let g:rnvimr_enable_picker = 1
      " Map Rnvimr action
      let g:rnvimr_action = {
                  \ '<C-t>': 'NvimEdit tabedit',
                  \ '<C-x>': 'NvimEdit split',
                  \ '<C-v>': 'NvimEdit vsplit',
                  \ 'gw': 'JumpNvimCwd',
                  \ 'yw': 'EmitRangerCwd'
                  \ }
      " Enable solarized color scheme
      syntax enable
      set termguicolors
      set background=dark
      colorscheme gruvbox
      " flake8
      let g:flake8_show_in_gutter=1
      let g:flake8_show_quickfix=1
    '';
    plugins = with pkgs.vimPlugins; [
      gruvbox-community
      deoplete-nvim
      deoplete-jedi
      fzf-vim
      rnvimr
      tagbar
      vim-flake8
      vim-fugitive
      vim-obsession
    ];
    extraPackages = with pkgs; [ pkgs.python3Packages.flake8 universal-ctags ];
    extraPython3Packages = ps: with ps; [ black jedi pynvim ];
  };
}
