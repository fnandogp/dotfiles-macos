" Set the Leader key
let mapleader=','

" Set the directories used to find packages.
set packpath^=~/.vim

" Automatic installation of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC:
endif

call plug#begin('~/.vim/pack')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-surround' " Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more.
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-repeat' " Git wrapper
Plug 'airblade/vim-rooter' " Changes Vim working directory to project root
Plug 'tpope/vim-dispatch' " Asynchronous build and test dispatcher
Plug 'machakann/vim-highlightedyank' " Make the yanked region apparent!
"Plug 'vim-airline/vim-airline' " lean & mean status/tabline for vim that's light as air
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree' " A tree explorer plugin for vim.
Plug 'preservim/nerdcommenter' " Vim plugin for intensely orgasmic commenting
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Extra syntax and highlight for nerdtree files
"Plug 'ryanoasis/vim-devicons' " Adds file type icons to Vim plugins
Plug 'dense-analysis/ale' " Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'mhinz/vim-startify' " The fancy start screen for Vim.
Plug 'unblevable/quick-scope'
Plug 'kassio/neoterm' " Wrapper of some vim/neovim's :terminal functions.
Plug 'voldikss/vim-floaterm'

Plug 'epilande/vim-es2015-snippets' " ES2015 code snippets
Plug 'epilande/vim-react-snippets' " React code snippets
Plug 'SirVer/ultisnips' " The ultimate snippet solution for Vim.
Plug 'honza/vim-snippets' "

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
Plug 'neoclide/jsonc.vim'

" Plug 'janko/vim-test' " Run your tests at the speed of thought

Plug 'sheerun/vimrc' " Basic vim configuration for your .vimrc
Plug 'sheerun/vim-polyglot' "A collection of language packs for Vim.

Plug 'mattn/emmet-vim' " emmet for vim

" Initialize plugin system
call plug#end()

" Auto save files when focus is lost and on buffer switch
au FocusLost * silent! wa
set autowrite
set autowriteall

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
      \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


"Delete all buffers
nmap <Leader>bda :bufdo bd <cr>

"search for the next occurrence of a select text
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
nnoremap // yiw/\V<C-r>=escape(@",'/\')<CR><CR>
vnoremap <M-/> "hy:%s/<C-r>h//gc<left><left><left>

" Source current file
nnoremap  <silent> <Leader>vr :so ~/.nvimrc<CR>

" Save / Quit keymaps
noremap  <silent> <Leader>w :w<CR>
vnoremap <silent> <Leader>w <C-c>:w<CR>
inoremap <silent> <Leader>w <C-o>:w<CR>
noremap  <silent> <Leader>q :q<CR>
" Delete and Close the current buffer
noremap  <silent> <Leader>Q :bdelete!<CR>
"Reload the current buffer
nnoremap <silent> <Leader>R :edit!<CR>

" Window navigation keymaps
tnoremap <Esc> <C-\><C-n>
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l

nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap <M-S-h> <C-w>H
nnoremap <M-S-j> <C-w>J
nnoremap <M-S-k> <C-w>K
nnoremap <M-S-l> <C-w>L

" Copy selected text to system clipboard
vnoremap <C-c> "+y
map <C-v> "+P

" Paste without losing the yanked text
vnoremap p "0p
vnoremap P "0P

" Open terminal
nnoremap <Leader>tn :vert Tnew<CR>

" Stay in visual mode when indenting. You will never have to run gv after performing an indentation.
vnoremap < <gv
vnoremap > >gv

" Move selected line up (J) or down (K)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Quicky escape to normal mode
imap jj <esc>

" Easy insertion of a trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

"""""""""
" Theme "
"""""""""
colorscheme dracula


""""""""""""
" fugitive "
""""""""""""
nmap <silent> <Leader>gst :G<CR>
command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' . fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gpsup execute 'Dispatch<bang> -dir=' .  fnameescape(FugitiveGitDir()) 'git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
command! -bang -bar -nargs=* Gfetch execute 'Dispatch<bang> -dir=' . fnameescape(FugitiveGitDir()) 'git fetch -v' <q-args>
command! -bang -bar -nargs=* Gpull execute 'Dispatch<bang> -dir=' .  fnameescape(FugitiveGitDir()) 'git pull' <q-args>


"""""""""""""""""""""""
" scrooloose/nerdtree "
"""""""""""""""""""""""
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeWinSize = 40
"let g:NERDTreeChDirMode = 2
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
" Open nerdtree
map <silent> <Leader>e :NERDTreeToggle<CR>
map <silent> <Leader>E :NERDTreeFind %<CR>

""""""""""""
" floaterm "
""""""""""""
let g:floaterm_keymap_new    = '<Leader>TT'
let g:floaterm_keymap_next   = '<Leader>Tn'
let g:floaterm_keymap_prev   = '<Leader>Tp'
let g:floaterm_keymap_toggle = '<Leader>`'
let g:floaterm_keymap_toggle = '<C-t>'


""""""""""""""
" quickscope "
""""""""""""""
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']


"""""""""""""""""""""
" itchyny/lightline "
"""""""""""""""""""""
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

""""""""""""""""""""
" SirVer/ultisnips "
""""""""""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<Nul>'
let g:UltiSnipsJumpForwardTrigger='<C-l>'
let g:UltiSnipsJumpBackwardTrigger='<C-h>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'


"""""""""""""""""""""
" neoclide/coc.nvim "
"""""""""""""""""""""
let g:coc_global_extensions = [
    \ 'coc-actions',
    \ 'coc-css',
    \ 'coc-cssmodules',
    \ 'coc-floaterm',
    \ 'coc-highlight',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-lists',
    \ 'coc-marketplace',
    \ 'coc-phpls',
    \ 'coc-python',
    \ 'coc-snippets',
    \ 'coc-svg',
    \ 'coc-tailwindcss',
    \ 'coc-tsserver',
    \ 'coc-ultisnips',
    \ 'coc-vimlsp',
    \ 'coc-xml',
    \ 'coc-yaml',
    \ 'coc-yank',
    \ ]

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')


" Use <Tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <A-s> <Plug>(coc-range-select)
xmap <silent> <A-s> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
"command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Keymappings
"" Listing
nmap <silent><nowait> <Leader>p  :CocList files<CR>
nmap <silent><nowait> <Leader>P  :CocList mru<CR>
nmap <silent><nowait> <Leader>mb :CocList buffers<CR>
nmap <silent><nowait> <Leader>ma <Plug>(coc-codeaction-cursor)
xmap <silent><nowait> <leader>ma  <Plug>(coc-codeaction-selected)
nmap <silent><nowait> <leader>ma  <Plug>(coc-codeaction-selected)
nmap <silent><nowait> <Leader>mc :<C-u>CocList commands<cr>
nmap <silent><nowait> <Leader>md :CocList --auto-preview --normal diagnostics<CR>
nmap <silent><nowait> <Leader>mf :CocFix<CR>
nmap <silent><nowait> <Leader>mg :CocList --interactive --auto-preview grep<CR>
nmap <silent><nowait> <Leader>mG :exe 'CocList --auto-preview --input='.expand('<cword>').' grep'<CR>
nmap <silent><nowait> <Leader>ms :CocList --interactive --auto-preview symbols<CR>
nmap <silent><nowait> <Leader>ml :CocList --interactive --auto-preview lines<CR>
nmap <silent><nowait> <Leader>mo :CocList --auto-preview outline<CR>
nmap <silent><nowait> <Leader>my :CocList --auto-preview --normal yank<CR>
nmap <silent><nowait> <Leader>mO :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

"" Rename and Refactor
nmap <silent> <Leader>rn <Plug>(coc-rename)
nmap <silent> <Leader>rr <Plug>(coc-refactor)
"" Gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"" Coc LSP
nmap <silent> <Leader>mR :CocRestart<CR>


""""""""""""""""""""""
" dense-analysis/ale "
""""""""""""""""""""""
let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \   '*': ['trim_whitespace'],
      \}
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%][%severity%] %s'

nnoremap <silent> <Leader>f :ALEFix<CR>


""""""""""""""""""
" janko/vim-test "
""""""""""""""""""
"nmap <silent> tn :TestNearest<CR>
"nmap <silent> tf :TestFile<CR>
"nmap <silent> ts :TestSuite<CR>
"nmap <silent> tl :TestLast<CR>
"nmap <silent> tg :TestVisit<CR>

"let test#strategy = 'dispatch'

"" Close qf term on Esc key press
"augroup qf_term
  "autocmd!
  "autocmd FileType qf nnoremap <buffer> <silent> <Esc> :q!<CR>
"augroup END


"""""""""""""""""""""""""""
" Valloric/MatchTagAlways "
"""""""""""""""""""""""""""
let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'blade' : 1,
      \}


"""""""""""""""""""
" mattn/emmet-vim "
"""""""""""""""""""
let g:user_emmet_install_global=0
autocmd FileType html,css,javascript,javascriptreact,typescriptreact EmmetInstall

""""""""""""
" vim-json "
""""""""""""
let g:vim_json_syntax_conceal = 0


augroup filetypedetect
  au BufRead,BufNewFile *file set filetype=ruby
augroup END


""""""""""""
" startify "
""""""""""""

let g:startify_custom_header = [
      \'  ________ ________   ________  ________   ________  ________  ________  ________   ',
      \' |\  _____\\   ___  \|\   __  \|\   ___  \|\   ___ \|\   __  \|\   ____\|\   __  \  ',
      \' \ \  \__/\ \  \\ \  \ \  \|\  \ \  \\ \  \ \  \_|\ \ \  \|\  \ \  \___|\ \  \|\  \ ',
      \'  \ \   __\\ \  \\ \  \ \   __  \ \  \\ \  \ \  \ \\ \ \  \\\  \ \  \  __\ \   ____\',
      \'   \ \  \_| \ \  \\ \  \ \  \ \  \ \  \\ \  \ \  \_\\ \ \  \\\  \ \  \|\  \ \  \___|',
      \'    \ \__\   \ \__\\ \__\ \__\ \__\ \__\\ \__\ \_______\ \_______\ \_______\ \__\   ',
      \'     \|__|    \|__| \|__|\|__|\|__|\|__| \|__|\|_______|\|_______|\|_______|\|__|   ',
        \]

let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_lists = [
          \ { 'type': 'dir',       'header': ['Current Directory '. getcwd()] },
          \ { 'type': 'files',     'header': ['Files']                        },
          \ { 'type': 'sessions',  'header': ['Sessions']                     },
          \ { 'type': 'bookmarks', 'header': ['Bookmarks']                    },
          \ ]

let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1

let g:startify_bookmarks = [
            \ { 'd': '~/.dotfiles' },
            \ ]

let g:startify_enable_special = 0

