" Set the leader key to space
let mapleader = " "
let g:mapleader = " "

" Insert mode: Pressing 'jk' quickly exits to normal mode
inoremap jk <ESC>

" Normal mode: * (search for word under cursor) also returns to the original position
nnoremap * *``

" Terminal mode: Map <Esc> to exit terminal mode
:tnoremap <Esc> <C-\><C-n>

" Quickfix window mappings:
noremap <F9> :vertical botright copen 80<cr>  " Open quickfix in a vertical split
noremap <F10> :copen 20<cr>                   " Open quickfix window with height 20
noremap <F7> :cn<cr>                          " Jump to next quickfix item
noremap <F8> :cp<cr>                          " Jump to previous quickfix item

" 'Smart' replace:
nnoremap S "_diwP  " Delete a word and paste without overwriting the default register

" Delete and cut mappings without affecting the default register:
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

" Improved movement for wrapped lines:
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Explicitly delete into the default register with <leader>d/D
nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

" (Commented out) Map <leader>r to open a terminal in a split
nnoremap <leader>r :Te<enter>

" Toggle line wrapping with <leader>w
nnoremap <leader>w :set wrap!<enter>

" Highlight words with different colors using <leader>c1 - <leader>c4
nnoremap <Leader>c1 :highlight SpecialColor1 ctermbg=magenta guibg=purple<CR>:let m = matchadd("SpecialColor1", expand('<cword>'))<CR>

nnoremap <Leader>c2 :highlight SpecialColor2 ctermbg=green guibg=green<CR>:let m = matchadd("SpecialColor2", expand('<cword>'))<CR>

nnoremap <Leader>c3 :highlight SpecialColor3 ctermbg=blue guibg=blue<CR>:let m = matchadd("SpecialColor3", expand('<cword>'))<CR>

nnoremap <Leader>c4 :highlight SpecialColor4 ctermbg=brown guibg=brown<CR>:let m = matchadd("SpecialColor4", expand('<cword>'))<CR>

nnoremap <Leader>c0 :call clearmatches()<CR>

" Enable syntax highlighting
syntax on

" Custom function for quickfix text display (removes leading whitespace)
if has('quickfixtextfunc')
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
endif

" Colorscheme settings:
colorscheme industry 
hi clear CursorLine  " Clear cursor line highlight
augroup CLClear
    autocmd! ColorScheme * hi clear CursorLine
augroup END

hi CursorLineNR cterm=bold  " Make cursor line number bold
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END

set cursorline  " Highlight the cursor line

" General settings:
set enc=utf-8          " Set encoding to UTF-8
set number             " Show line numbers
set mouse=a            " Enable mouse support
set autoindent         " Auto-indent new lines
set tabstop=4          " Set tab width to 4 spaces
set sw=4               " Set shift width (auto-indent) to 4 spaces
set sts=4              " Set soft tab stop to 4 spaces
set expandtab          " Convert tabs to spaces
set splitright         " New vertical splits open to the right
set ignorecase         " Ignore case when searching
set smartcase          " Enable case-sensitive search when uppercase is used
set incsearch          " Incremental search (show matches while typing)
set noswapfile         " Disable swap files
set hlsearch           " Highlight search results
set clipboard^=unnamed,unnamedplus  " Use system clipboard
set termguicolors      " Enable true color support
set scrolloff=7        " Keep at least 7 lines visible above/below cursor
set wrapscan!          " Disable wrap-around for searches
set listchars=tab:>·,trail:~,extends:>,precedes:<  " Show hidden characters
set list               " Show invisible characters
set wildmenu           " Enable command-line autocompletion menu
set wildmode=longest:full,full  " Improve command-line tab completion
set formatoptions-=r   " Disable auto-comment continuation
set autoread

" Try sourcing an additional config file, if it exists
try
    source ~/.vimrc_plug
catch
    " just ignore it
    echo ".vimrc_plug source file was not found"
endtry
