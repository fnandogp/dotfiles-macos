vim.cmd([[
command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' . fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gpsup execute 'Dispatch<bang> -dir=' .  fnameescape(FugitiveGitDir()) 'git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
command! -bang -bar -nargs=* Gfetch execute 'Dispatch<bang> -dir=' . fnameescape(FugitiveGitDir()) 'git fetch -v' <q-args>
command! -bang -bar -nargs=* Gpull execute 'Dispatch<bang> -dir=' .  fnameescape(FugitiveGitDir()) 'git pull' <q-args>
]])
