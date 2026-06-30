" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set Dein base path (required) — ~ keeps it portable across machines/users
let s:dein_base = expand('~/.cache/dein')

" Set Dein source path (required)
let s:dein_src = expand('~/.cache/dein/repos/github.com/Shougo/dein.vim')

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
call dein#add('Shougo/vimshell.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/vimproc.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neossh.vim')
call dein#add('Shougo/vimfiler.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neoyank.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('tpope/vim-git')
call dein#add('tpope/vim-fugitive')
call dein#add('scrooloose/syntastic')
call dein#add('euclio/vim-markdown-composer', { 'build': 'cargo build --release' })
call dein#add('airblade/vim-gitgutter')
call dein#add('scrooloose/nerdtree')
call dein#add('c9s/perlomni.vim')
call dein#add('steelsojka/deoplete-flow')
call dein#add('vim-scripts/mojo.vim')
call dein#add('Chiel92/vim-autoformat')
call dein#add('ellisonleao/gruvbox.nvim')
call dein#add('maxmx03/solarized.nvim')

" Finish Dein initialization (required)
call dein#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Uncomment if you want to install not-installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

set laststatus=2
let g:airline#extensions#tabline#enabled = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_enable_perl_checker = 1
let g:syntastic_python_python_exec = 'python3'
" let g:syntastic_python_chekers = ['pylint']
let g:syntastic_python_checkers = ['python', 'pylint -E']

" Disable folding
let g:vim_markdown_folding_disabled=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='luna'
let g:airline_powerline_fonts = 1
set number
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NerdTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = '-'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GitGutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight clear SignColumn


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimShell
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
"let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'

let g:vimshell_prompt = $USER."% "

" Initialize execute file list.
let g:vimshell_execute_file_list = {}
call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
let g:vimshell_execute_file_list['rb'] = 'ruby'
let g:vimshell_execute_file_list['pl'] = 'perl'
let g:vimshell_execute_file_list['py'] = 'python3'
call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

autocmd FileType vimshell
      \ call vimshell#altercmd#define('g', 'git')
      \| call vimshell#altercmd#define('i', 'iexe')
      \| call vimshell#altercmd#define('l', 'll')
      \| call vimshell#altercmd#define('ll', 'ls -l')
      \| call vimshell#hook#add('chpwd', 'my_chpwd', 'MyChpwd')

function! MyChpwd(args, context)
  call vimshell#execute('ls')
endfunction

autocmd FileType int-* call s:interactive_settings()
function! s:interactive_settings()
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=eol,indent,start
set autoindent
set autoindent
set autoread
set autowrite       " Automatically save before commands like :next and :make
set backspace=2
if exists('+breakindent')
  set breakindent showbreak=\ +
endif
set cmdheight=2
setglobal commentstring=#\ %s
set complete-=i     " Searching includes can be slow
set history=900
set incsearch       " Incremental search
set laststatus=2    " Always show status line
"set lazyredraw
set linebreak
set vb
set visualbell
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set ruler           " enable information ruler
set showmode        " Tell you if you are in insert mode.
set showmatch       " Match parenthesis, i.e. ) with (  and } with {.
set ignorecase      " Ignore case when doing searches.
"set report=0       " Tell you how many lines have been changed.
set expandtab       " insert spaces instead of tabs
set nofoldenable    " disable folding

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Unite + Fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_source_menu_menus = {}

let g:unite_source_menu_menus.filters = {
      \'description' : 'Text filters',
      \'command_candidates' : [
      \  ["Remove empty lines"           , 'v/./d'],
      \  ["Remove empty lines  [v]"      , "'<,'>v/./d"],
      \  ['Condense empty lines'         , '%s/\n\{3,}/\r\r/e'],
      \  ['Remove trailing white space'  , '%s/\s\+$//' ],
      \  ['',''],
      \]}

let g:unite_source_menu_menus.git = {
      \ 'description' : 'Git commands (Fugitive)',
      \ 'command_candidates' : [
      \  ['git status       (Fugitive)                               '  , 'Gstatus'],
      \  ['git diff         (Fugitive)                               '  , 'Gdiff'],
      \  ['git commit       (Fugitive)                               '  , 'Gcommit -a'],
      \  ['git log          (Fugitive)                               '  , 'exe "silent Glog | Unite quickfix"'],
      \  ['git blame        (Fugitive)                               '  , 'Gblame'],
      \  ['git stage        (Fugitive)                               '  , 'Gwrite'],
      \  ['git checkout     (Fugitive)                               '  , 'Gread'],
      \  ['git rm           (Fugitive)                               '  , 'Gremove'],
      \  ['git mv           (Fugitive)                               '  , 'exe "Gmove " input("destino: ")'],
      \  ['git push         (Fugitive)                               '  , 'Git! push'],
      \  ['git pull         (Fugitive)                               '  , 'Git! pull'],
      \  ['git prompt       (Fugitive)                               '  , 'exe "Git! " input("comando git: ")'],
      \  ['git cd           (Fugitive)                               '  , 'Gcd'],
      \]
      \}
noremap  sm  :Unite -buffer-name=menu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Filer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:let g:vimfiler_as_default_explorer = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRL - k -> neosnippets (exec snippets)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Paste
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F10> :set paste!<CR>
inoremap <F10> <Esc>:set paste!<CR>a
set background=dark


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gruvbox
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
colorscheme solarized



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
"let g:deoplete#enable_smart_case = 1
let g:python_host_prog = '/usr/bin/python3'

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" uRe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:autoformat_autoindent = 1
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1
let g:formatter_yapf_style = 'pep8'
let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
let g:formatters_python = ['yapf', 'black', 'autopep8']
" CTRL-t reformats, checks, commits
nnoremap <C-t> :Autoformat<CR>:SyntasticCheck<CR>
" Autoformat on safe
:au BufWrite * :SyntasticCheck<CR>

" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
set t_ut=

" cursorline see where we are
set cursorline

" Speed up vim on big files
set synmaxcol=128
syntax sync minlines=256

" When editing a file jump to last position
if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
endif

" fix mouse bindings
set mouse=a

"set clipboard=unnamed

function! s:TmuxBufferName()
  let l:list = systemlist('tmux list-buffers -F"#{buffer_name}"')
  if len(l:list)==0
    return ""
  else
    return l:list[0]
  endif
endfunction

function! s:TmuxBuffer()
  return system('tmux show-buffer')
endfunction

function! s:Enable()

  if $TMUX==''
    " not in tmux session
    return
  endif

  let s:lastbname=""

  " if support TextYankPost
  if exists('##TextYankPost')==1
    " @"
    augroup vimtmuxclipboard
      autocmd!
      autocmd FocusLost * let s:lastbname=s:TmuxBufferName()
      autocmd FocusGained   * if s:lastbname!=s:TmuxBufferName() | let @" = s:TmuxBuffer() | endif
      autocmd TextYankPost * silent! call system('tmux loadb -',join(v:event["regcontents"],"\n"))
    augroup END
    let @" = s:TmuxBuffer()
  else
    " vim doesn't support TextYankPost event
    " This is a workaround for vim
    augroup vimtmuxclipboard
      autocmd!
      autocmd FocusLost     *  silent! call system('tmux loadb -',@")
      autocmd FocusGained   *  let @" = s:TmuxBuffer()
    augroup END
    let @" = s:TmuxBuffer()
  endif

endfunction

call s:Enable()

" " workaround for this bug
" if shellescape("\n")=="'\\\n'"
"   let l:s=substitute(l:s,'\\\n',"\n","g")
"   let g:tmp_s=substitute(l:s,'\\\n',"\n","g")
"   ");
"   let g:tmp_cmd='tmux set-buffer ' . l:s
" endif
" silent! call system('tmux loadb -',l:s)
