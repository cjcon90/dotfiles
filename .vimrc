" CALL PLUGINS:

source ~/.vim/plugins.vim

" BASIC SETUP:

set nocompatible
syntax enable
filetype plugin on
set relativenumber " show numbers as relative rather than absolute
set pastetoggle=<F8> " set paste mode to avoid indent when pasting multiple lines
set ttyfast " fast scroll with mouse
set hlsearch " highlight all search results
set incsearch " show incremental search results as you type
set ignorecase " do case insensitive search

" FINDING FILES:
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" Display all matching files when we tab complete
set wildmenu
" Set ranger key bindings
source ~/.vim/ranger.vim

"STYLE:
if exists('+termguicolors')
   let &t_8f =  "\<Esc>[38:2:%lu:%lu:%lum"
   let &t_8b =  "\<Esc>[48:2:%lu:%lu:%lum"
   " let &t_8f =  "\<Esc>[38:2;%lu;%lu;%lum" ( I have tried both ':' and ';' )
   " let &t_8b =  "\<Esc>[48:2;%lu;%lu;%lum"
   set t_Co=256
   set termguicolors
   set background=dark
   colorscheme iceberg
endif

"LIGHLINE:

source ~/.vim/lightline.vim

" AUTOSUGGESTION COC: 

source ~/.vim/coc.vim
