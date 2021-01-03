" -------------------------------------------------------------------- "
"                               Plug ins                               "
" -------------------------------------------------------------------- "
let g:airline_theme='gruvbox'
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
let g:polyglot_disabled = ['graphql', 'tmux']

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
call plug#end()

" -------------------------------------------------------------------- "
"                                Visual                                "
" -------------------------------------------------------------------- "
set background=dark
silent! colorscheme gruvbox

syntax enable           " enable syntax highlighting
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]

" Wildmenu
set wildmenu
set wildmode=longest:full,full

" -------------------------------------------------------------------- "
"                              Interface                               "
" -------------------------------------------------------------------- "
inoremap jk <esc>|      " Rebind ESC
inoremap JK <esc>|      " Rebind ESC

" GUI Interaction - mouse support
set ttymouse=xterm2
set mouse=a
set mousehide

" Copy/paste
set pastetoggle=<Leader>p

" Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase          " ignore case when searching
noremap n nzz           " auto center on match
noremap N Nzz           " auto center on match

" History
set history=1024        " Lengthen history
set undolevels=1024     " Lengthen undo history

" Git commit messages
autocmd FileType gitcommit set textwidth=72

" Tabbing
set expandtab
set shiftwidth=2 softtabstop=2 tabstop=2

autocmd FileType make setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

"Automatic indentation
set autoindent

"Highlight whitespace at the EOL
highlight WhiteSpaceEOL ctermbg=red guibg=red
match WhiteSpaceEOL /\s\+\%#\@!$/

" Sessions
command SSS mksession! ~/.saved_session.vim
command LSS source ~/.saved_session.vim

" Syntax highlighting rules
autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
autocmd BufRead,BufNewFile *.jsx set filetype=javascript
