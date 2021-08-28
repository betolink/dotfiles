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

