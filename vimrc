set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ajh17/VimCompletesMe'
Plugin 'alvan/vim-closetag'
"Plugin 'dense-analysis/ale'
Plugin 'benbusby/earthbound-themes', {'rtp': 'vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" Put your non-Plugin stuff after this line

set number
set ignorecase
set smartcase
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set undofile
set undodir=~/.vim/undodir
set hlsearch
set number
set ruler
set wrap linebreak nolist
set mouse=a
syntax on

" Custom Commands
cmap w!! w !sudo tee > /dev/null %
map <C-a> :Autoformat<CR>
nnoremap c "_c
nnoremap Q q
nnoremap Y y$
nnoremap q b
"nnoremap y *y
"nnoremap p *p
nnoremap <C-l> gt
nnoremap <C-h> gT
inoremap jj <esc>
inoremap jk <esc>

set clipboard=unnamedplus
inoremap <expr> <CR> InsertMapForEnter()
function! InsertMapForEnter()
    if strcharpart(getline('.'),getpos('.')[2]-1,2) == '</'
        return "\<CR>\<Esc>O"
    else
        return "\<CR>"
    endif
endfunction

set path=.,/usr/include,,**
:command NE NERDTreeToggle
:command NEK let NERDTreeQuitOnOpen=0 | let NERDTreeShowBookmarks=1 |NERDTreeToggle
:command NEN let NERDTreeQuitOnOpen=3 | NERDTreeToggle
:command NFIND NERDTreeFind

:command GG GitGutterLineHighlightsToggle

au BufWritePre * :let _s=@/|:%s/\s\+$//e|:let @/=_s

set hlsearch
noremap <ESC> :noh<CR><ESC>

set wildignore+=*.pyc,*.dex,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*
let NERDTreeRespectWildIgnore=1
let NERDTreeQuitOnOpen=3
let g:NERDTreeWinSize=40

nnoremap <esc> :noh<return><esc>

inoremap {<cr> {<cr>}<c-o>O
inoremap [<cr> [<cr>]<c-o>O
inoremap (<cr> (<cr>)<c-o>O

:nnoremap <PageDown> 10j
:nnoremap <PageUp> 10k
:nnoremap <C-Up> 10k
:nnoremap <C-Down> 10j
nnoremap J 10j
nnoremap K 10k
:nnoremap <C-Space> i
:inoremap <C-Space> <Esc>
:nnoremap <Space> :

if has('nvim') || has('termguicolors')
    set termguicolors
endif

syn match    cCustomParen    "(" contains=cParen,cCppParen
syn match    cCustomFunc     "\w\+\s*(" contains=cCustomParen
syn match    cCustomScope    "::"
syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
syn match    cCustomProp     "\.\w\+\s*."

au BufEnter * :source ~/extend-syntax.vim
colo fire-spring-darker

" airline
let g:airline_theme='raven'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = ''
"let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
