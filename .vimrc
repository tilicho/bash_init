let mapleader = " "
let g:mapleader = " "
inoremap jk <ESC>
nnoremap * *``
:tnoremap <Esc> <C-\><C-n>
noremap <F9> :vertical botright copen 80<cr>
noremap <F10> :copen 20<cr>
noremap <F7> :cn<cr>
noremap <F8> :cp<cr>
nnoremap S "_diwP

nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d
nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

nnoremap <leader>f :Te<enter>

nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

syntax on

set quickfixtextfunc=QFTextOnly

func QFTextOnly(info) 
    if a:info.quickfix
        let qfl = getqflist(#{id: a:info.id, items: 0}).items
    else
        let qfl = getloclist(a:info.winid, #{id: a:info.id, items: 0}).items
    endif
    let l = []
    for idx in range(a:info.start_idx - 1, a:info.end_idx - 1)
        call add(l, substitute(qfl[idx].text, '^\s*','',''))
    endfor
    return l
endfunc

colorscheme industry 
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
set wrapscan!
set listchars=tab:>·,trail:~,extends:>,precedes:<
set list

