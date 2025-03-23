set nocompatible
set encoding=utf-8
set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
set clipboard=unnamedplus


noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

let g:mapleader = ","


" ESC in terminal windows
tnoremap <Esc> <C-\><C-n>
" Sin city...use the mouse ...
set mouse=a
" split the windows below for split and right for vsiplit
set splitbelow
set splitright

set foldmethod=syntax
set foldlevelstart=99
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
noremap <F3> :Autoformat<CR>

" Move lines up and down
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Python stuff
autocmd FileType python exe 'source ~/dotfiles/neovim/languages/python.vim'
autocmd FileType typescript,json,javascript exe 'source ~/dotfiles/neovim/languages/javascript.vim'

call plug#begin('~/.local/share/nvim/plugged')
exe 'source ~/.config/nvim/plugins.vim'
exe 'source ~/.config/nvim/cyclecolors.vim'
" Initialize plugin system
call plug#end()

" lua require("mason").setup()
" lua require("mason-lspconfig").setup()
" lua require'lspconfig'.pyright.setup{}

set background=dark
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" colorscheme OceanicNext
colorscheme nordfox
" let base16colorspace=256
" Tab settings
set tabstop=2
set shiftwidth=2
set expandtab
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop



" This searches for the current word using ag and opens the quickfix window
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  nnoremap T :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>
endif


nnoremap <C-f> :Far <C-R><C-W><C-R>  **/*.<C-R>=expand("%:e")<CR><C-Left><C-Left>

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

"" Wild settings
set wildmode=list:longest,list:full
" " Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc
" " Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" " Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,*/__pycache__/*
" " Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*
" " Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
" " Disable temp and backup files
set wildignore+=*.swp,*~,._*
" Ignore node modules
set wildignore+=*/node_modules/*
" NerdFonts for devicon
" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
" set guifont=Droid\ Sans\ Mono\ Nerd\ 11
set guifont=JetBrains\ Mono\ Regular\ Nerd\ Font\ Complete\ 11

if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
nnoremap <Leader>m :NERDTreeToggle<CR>
" Clear search highlight
nnoremap <Leader>h :noh<CR>

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#server_timeout = 20
let g:deoplete#auto_complete=1
let g:deoplete#sources#jedi#show_docstring=1
" " disable autocomplete by default
" " let b:deoplete_disable_auto_complete=1
" " let g:deoplete_disable_auto_complete=1

" Or, you could use neovim's floating text feature.
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu

" " Disable the candidates in Comment/String syntaxes.
" call deoplete#custom#source('_',
"             \ 'disabled_syntaxes', ['Comment', 'String'])

" " let g:deoplete#auto_complete_start_length = 1
" " let g:jedi#force_py_version = 3.8.4

" Python for Neovim with pyenv.
" if exists("$VIRTUAL_ENV")
"     let g:python3_host_prog=substitute(system("which -a python | head -n2 | tail -n1"), "\n", '', 'g')
" else
"     let g:python3_host_prog=substitute(system("which python"), "\n", '', 'g')
" endif

let g:python3_host_prog = '/home/betolink/.pyenv/versions/mambaforge/envs/neovim/bin/python'

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

nmap ,bb :BuffergatorToggle<CR>

let g:ale_sign_column_always = 1
" Saving files with C+S
noremap  <C-s> :w<CR>

let g:ale_linters = {
\   'python':['flake8'],
\}

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = 1

let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['^node_modules$', '^tags$', '\.git$[[dir]]', '\.pyc$', '\.idea$[[dir]]', '\.sass-cache$']

" Vim Test Strategy
" make test commands execute using neovim
let test#strategy = "neovim"
let g:test#preserve_screen = 1
nmap <F5> :TestFile<CR>
nmap <F6> :TestSuite<CR>

let g:airline_powerline_fonts = 1

" this theme has a buildin lightline/airline theme
let g:airline_theme = 'equinusocio_material'
let g:lightline = {
  \ 'colorscheme': 'equinusocio_material',
  \ }


let g:rnvimr_ex_enable = 1

nmap <space>r :RnvimrToggle<CR>


if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'


let g:minimap_width = 12
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1
