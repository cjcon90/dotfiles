" CALL PLUGINS:

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary' " Add comments with gc__
Plug 'tpope/vim-surround' " surroundings as nouns
Plug 'kana/vim-textobj-user' " Add custom objects
Plug 'kana/vim-textobj-indent' " Add indent as an object __i

Plug 'cocopon/iceberg.vim' " iceberg colorscheme
Plug 'tpope/vim-fugitive' " Git functionality
Plug 'itchyny/lightline.vim' " Lightline bar

Plug 'jiangmiao/auto-pairs' " Auto close brackets
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autosuggestion
Plug 'rafaqz/ranger.vim' " Use ranger as file browser
call plug#end() 
