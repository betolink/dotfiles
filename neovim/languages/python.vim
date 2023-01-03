set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
if executable('pytest')
  let g:test#python#runner = 'pytest'
  let g:test#python#pytest#options = ' -s '
else
   let g:test#python#runner = 'nose'
endif
let g:ale_fixers = {'python': ['black', 'isort']}
call matchadd('Error', '^.*ipdb.*$', -1)

let g:pymode_options_max_line_length = 80
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
let g:pymode_options_colorcolumn = 1


" nnoremap [[ ?^class\|^\s*def<CR>
" nnoremap ]] /^class\|^\s*def<CR>
