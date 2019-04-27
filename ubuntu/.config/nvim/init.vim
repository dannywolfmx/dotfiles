" VIM-PLUG
call plug#begin('~/.local/share/nvim/plugged')
" Lit-html y polymer 3
"Plug 'jonsmithers/vim-html-template-literals'
" Resaltar javascript en general
"Plug 'othree/javascript-libraries-syntax.vim'
"Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
"Plug 'mxw/vim-jsx'
Plug 'dikiaap/minimalist'
"Theme subletext
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'hzchirs/vim-material'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'prettier/vim-prettier', { 'do' : 'npm install' }
Plug 'vim-airline/vim-airline-themes'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdtree'
Plug 'zchee/deoplete-jedi'
Plug 'bling/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'w0rp/ale'
"FLutter and dart pluggins
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

" call PlugInstall to install new plugins

call plug#end()
"basics
filetype plugin indent on
syntax on set number
set relativenumber
set incsearch
set ignorecase
set smartcase
set nohlsearch
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set nobackup
set noswapfile
set nowrap

" preferences
inoremap jk <ESC>
let mapleader = "\<Space>"
set pastetoggle=<F2>
" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" Stay in visual mode when indenting. You will never have to run gv after
" performing an indentation.
vnoremap < <gv
vnoremap > >gv
" Make Y yank everything from the cursor to the end of the line. This makes Y
" act more like C or D because by default, Y yanks the current line (i.e. the
" same as yy).
noremap Y y$
" navigate split screens easily
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
" change spacing for language specific
"autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

set autoread

" plugin setting

" deoplete
let g:deoplete#enable_at_startup = 1
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

set t_Co=256
" Theme
let g:airline_theme='material'
let g:material_style='palenight'
syntax enable 
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set background=dark
"colorscheme sublimemonokai 
let g:nord_italic_comments = 1
let g:sublimemonokai_term_italic = 1
colorscheme vim-material 
"NERDTree
" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', 'node_modules']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

" jsx
let g:jsx_ext_required = 0

let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}

let g:ale_completion_enabled = 1 
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_eslint_executable = 'prettier-eslint'

let g:ale_javascript_prettier_eslint_use_global = 1
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Prettier configuracion de autoguardado
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

set colorcolumn=80
set nocursorline

" [ ]
hi jsBrackets  guifg=#77dce8 guibg=NONE gui=bold
" ( )
hi javascript     guifg=#77dce8 guibg=NONE gui=bold
" { } - for object definitions only
hi def link jsObjectProp Identifier
hi jsDestructuringBlock  guifg=#ffd866 guibg=NONE gui=bold
" { } - for function definitions only
hi javascriptMethod guifg=#ffd866 guibg=NONE gui=italic
"
"

let g:vim_jsx_pretty_colorful_config = 1
let g:vim_jsx_pretty_highlight_close_tag = 0 
