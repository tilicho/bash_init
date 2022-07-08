inoremap jk <ESC>
nnoremap * *``
:tnoremap <Esc> <C-\><C-n>
noremap <F9> :vertical botright copen 80<cr>
noremap <F10> :copen 20<cr>

let mapleader = "'"

syntax on

colorscheme blue
hi clear CursorLine
augroup CLClear
    autocmd! ColorScheme * hi clear CursorLine
augroup END

hi CursorLineNR cterm=bold
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END

set cursorline

set enc=utf-8
set number
set mouse=a
set autoindent
set tabstop=4
set sw=4
set sts=4
set expandtab
set splitright
set ignorecase
set smartcase
set incsearch
set noswapfile
set hlsearch
set clipboard^=unnamed,unnamedplus
set termguicolors
set scrolloff=7

