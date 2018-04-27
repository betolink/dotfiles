set nocompatible
set encoding=utf8
set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides

let g:mapleader = ","

set foldmethod=syntax
set foldlevelstart=99
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Move lines up and down
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

call plug#begin('~/.local/share/nvim/plugged')
exe 'source ~/.config/nvim/plugins.vim'
exe 'source ~/.config/nvim/cyclecolors.vim'
" Initialize plugin system
call plug#end()

set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme OceanicNext
let base16colorspace=256
set termguicolors
" Tab settings
set tabstop=2
set shiftwidth=2
set expandtab
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop

" Python tabs
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  nnoremap K :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>
endif

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" No old-skool backups or swp files
set nobackup
set noswapfile

" Show trailing spaces
set list
set listchars=""
set listchars=tab:__
set listchars+=trail:.

""
"" Wild settings
""

set wildmode=list:longest,list:full
"
" " Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc
"
" " Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
"
" " Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,*/__pycache__/*
"
" " Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*
"
" " Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
"
" " Disable temp and backup files
set wildignore+=*.swp,*~,._*
" Ignore node modules
set wildignore+=*/node_modules/*

" NerdFonts for devicons
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11

if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
nnoremap <Leader>n :NERDTreeToggle<CR>
" Clear search highlight
nnoremap <Leader><space> :noh<CR>

let g:deoplete#enable_at_startup = 1

nmap ,bb :BuffergatorToggle<CR>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

" Vim movement keys only
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Syntax checkers
"  Javascript + ReactJS


let g:ale_sign_column_always = 1
" Saving files with C+S
noremap  <C-s> :w<CR>

" Syntax checkers
"  Javascript + ReactJS

"let g:jsx_ext_required = 0
"let g:syntastic_javascript_checkers = ['eslint']
"
"" Override eslint with local version where necessary.
"let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
"if matchstr(local_eslint, "^\/\\w") == ''
"  let local_eslint = getcwd() . "/" . local_eslint
"endif
"if executable(local_eslint)
"  let g:syntastic_javascript_eslint_exec = local_eslint
"endif

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python':['flake8'],
\}

" if executable(local_eslint)
  " let g:syntastic_javascript_eslint_exec = local_eslint
 " let g:ale_linters = {
"\   'javascript': [local_eslint],
"\ }
"endif

let NERDTreeIgnore = ['\.pyc$','\.class$']

" Vim Test Strategy
" make test commands execute using neovim
let test#strategy = "neovim"
