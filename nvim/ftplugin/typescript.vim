""""""""""""""
" Typescript "
""""""""""""""
let b:ale_fixers = ['prettier', 'eslint']

augroup addUltiSnips
  autocmd BufEnter *.ts :exec ':UltiSnipsAddFiletypes javascript'
augroup end
