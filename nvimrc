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

Plug 'dracula/vim' " A dark theme for Vim https://draculatheme.com/vim
Plug 'tpope/vim-surround' " Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more.
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'airblade/vim-gitgutter' " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes (partial) hunks.
Plug 'tpope/vim-dispatch' " Asynchronous build and test dispatcher
Plug 'machakann/vim-highlightedyank' " Make the yanked region apparent!
Plug 'vim-airline/vim-airline' " lean & mean status/tabline for vim that's light as air
Plug 'preservim/nerdtree' " A tree explorer plugin for vim.
Plug 'preservim/nerdcommenter' " Vim plugin for intensely orgasmic commenting
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Extra syntax and highlight for nerdtree files
Plug 'ryanoasis/vim-devicons' " Adds file type icons to Vim plugins
Plug 'kassio/neoterm' " Wrapper of some vim/neovim's :terminal functions.
Plug 'dense-analysis/ale' " Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support

Plug 'epilande/vim-es2015-snippets' " ES2015 code snippets
Plug 'epilande/vim-react-snippets' " React code snippets
Plug 'SirVer/ultisnips' " The ultimate snippet solution for Vim.
Plug 'honza/vim-snippets' "

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine for vim8 & neovim, full language server protocol support as VSCode

Plug 'janko/vim-test' " Run your tests at the speed of thought

Plug 'Valloric/MatchTagAlways' " A Vim plugin that always highlights the enclosing html/xml tags
Plug 'mattn/emmet-vim' " emmet for vim
Plug 'ap/vim-css-color' " Preview colours in source code while editing

Plug 'elzr/vim-json' " A better JSON for Vim
Plug 'yuezk/vim-js' " The most accurate syntax highlighting plugin for JavaScript and Flow.js
Plug 'HerringtonDarkholme/yats.vim' " Yet Another TypeScript Syntax: The most advanced TypeScript Syntax Highlighting in Vim
Plug 'maxmellon/vim-jsx-pretty' " JSX and TSX syntax pretty highlighting for vim
Plug 'styled-components/vim-styled-components', { 'branch': 'main' } " Vim bundle for http://styled-components.com based javascript files.

" Automatically executes `filetype plugin indent` on and `syntax enable`.
" Initialize plugin system
call plug#end()


""""""""""
" Basics "
""""""""""
set number " Precede each line with its line number.
set hidden
set mouse=a " Enables mouse support
set encoding=utf-8 " String-encoding used internally
set nobackup
set nowritebackup
set noswapfile
set autoread
set splitbelow splitright " Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set tabstop=2 " Show existing tab with 2 spaces width
set shiftwidth=2 " When indenting with '>', use 2 spaces width
set expandtab " On pressing tab, insert 2 spaces
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
"set cursorline " Highlight the screen line of the cursor
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set autoindent " always set autoindenting on
set incsearch " While typing a search command, show where the pattern, as it was typed so far, matches.
set scrolloff=5 " Minimal number of screen lines to keep above and below the cursor.
" handle long lines correctly
set wrap
set textwidth=80
set colorcolumn=80
set cmdheight=2 " Better display for messages
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
set shortmess+=c " don't give |ins-completion-menu| messages.
set signcolumn=yes " always show signcolumns
set noshowmode

" Auto save files when focus is lost and on buffer switch
au FocusLost * silent! wa
set autowriteall

" Reload window

"search for the next occurrence of a select text
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>
nnoremap // yiw/\V<C-r>=escape(@",'/\')<CR><CR>
vnoremap <M-/> "hy:%s/<C-r>h//gc<left><left><left>

" Toggle the search highlighting state on or off persistently
nnoremap <Leader><Space> :set hlsearch! hlsearch?<CR>

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

" Window resize
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" Copy selected text to system clipboard
vnoremap <C-c> "+y
map <C-v> "+P

" Open terminal
nnoremap <Leader>tn :vert Tnew<CR>

" Stay in visual mode when indenting. You will never have to run gv after performing an indentation.
vnoremap < <gv
vnoremap > >gv

autocmd VimEnter * setlocal nobuflisted


"""""""""""""""
" dracula/vim "
"""""""""""""""
color dracula


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
" Find and reveal the file for the active
"map <Leader>f :NERDTreeFind %<CR>

"augroup nerdtree_init
  "autocmd StdinReadPre * let s:std_in=1
  "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  "autocmd StdinReadPre * let s:std_in=1
  "autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | wincmd p | ene | exe 'NERDTree' argv()[0] | endif
"augroup END

"""""""""""""""""""
" airline/airline "
"""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_type = 0

let g:airline#extensions#ale#enabled = 1

let g:airline#extensions#capslock#enabled = 1

let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

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
" use <C-j> for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

"Use <Tab> and <S-Tab> to navigate the completion list:
imap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"Use <C-j> to confirm completion
inoremap <expr> <C-j> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"To make coc.nvim format your code on <C-j>, use keymap:
inoremap <silent><expr> <C-j> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

"" Start multiple cursors session
"nmap <silent> <C-c> <Plug>(coc-cursors-position)
"nmap <silent> <C-d> <Plug>(coc-cursors-word)
"xmap <silent> <C-d> <Plug>(coc-cursors-range)
"" use normal command like `<Leader>xi(`
"nmap <Leader>x  <Plug>(coc-cursors-operator)

nmap <silent> <C-n> <Plug>(coc-cursors-word)*
xmap <silent> <C-n> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn

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


" Remap for do codeAction of current line
"nmap <Leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
"nmap <Leader>af <Plug>(coc-fix-current)

"" Create mappings for function text object, requires document symbols feature of languageserver.

"xmap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap if <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)

" Use <Tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <Tab> <Plug>(coc-range-select)
xmap <silent> <Tab> <Plug>(coc-range-select)
xmap <silent> <S-Tab> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using snippets
inoremap <silent><expr> <C-j>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <C-j> for both expand and jump (make expand higher priority.)
"imap <C-l> <Plug>(coc-snippets-expand-jump)

" Keymappings
"" Listing
nnoremap <silent> <Leader>p :CocList files<CR>
nnoremap <silent> <Leader>P :CocList buffers<CR>
nnoremap <silent> <Leader>ma :CocList actions<CR>
nnoremap <silent> <Leader>md :CocList --auto-preview --normal diagnostics<CR>
nnoremap <silent> <Leader>mf :CocFix<CR>
nnoremap <silent> <Leader>mg :CocList --interactive --auto-preview grep<CR>
nnoremap <silent> <Leader>mG :exe 'CocList --auto-preview --input='.expand('<cword>').' grep'<CR>
nnoremap <silent> <Leader>ms :CocList --interactive --auto-preview symbols<CR>
nnoremap <silent> <Leader>ml :CocList --interactive --auto-preview lines<CR>
nnoremap <silent> <Leader>mo :CocList --auto-preview outline<CR>
nnoremap <silent> <Leader>my :CocList --auto-preview --normal yank<CR>
nnoremap <silent> <Leader>mO :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

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
autocmd FileType html,css,javascript.jsx,typescriptreact EmmetInstall


""""""""""""
" vim-json "
""""""""""""
let g:vim_json_syntax_conceal = 0

