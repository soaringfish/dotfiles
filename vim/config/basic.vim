"""""""""""""""""""""""""""""
"  basic.vim: VIM Settings  "
"""""""""""""""""""""""""""""


if has('vim_starting')
  set nocompatible               " Be iMproved
endif

" Environment {{{1 "

" Identify platform {{{2
silent function! OSX()
    return has('macunix') || has('mac')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win32') || has('win64'))
endfunction
" }}}2

if has('nvim')
  let g:python_host_prog=systemlist('which python2.7')[0]
  let g:python3_host_prog=systemlist('which python3')[0]
  if !executable(g:python_host_prog) | unlet g:python_host_prog | endif
  if !executable(g:python3_host_prog) | unlet g:python3_host_prog | endif
  if executable('nvr')
    let $VISUAL = 'nvr -cc split --remote-wait'
  endif
endif

" }}}1 "

" General {{{1 "
" --------------

" Loading features {{{2 "
let g:loaded_2html_plugin     = 1
let g:loaded_getscriptPlugin  = 1
let g:loaded_gzip             = 1
let g:loaded_logipat          = 1
" let g:loaded_matchparen       = 1
let g:loaded_rrhelper         = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tarPlugin        = 1
let g:loaded_vimballPlugin    = 1
let g:loaded_zipPlugin        = 1

" language {{{2 "
let $LANG='en' " Avoid garbled characters in Windows
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set encoding=utf8
set fileformats=unix,dos,mac

set history=500 " Sets how many lines of history VIM has to remember

" Enable filetype plugins
" Move to plugins.vim
" filetype plugin on
" filetype indent on

" Map(Local)Leaders {{{1 "
let mapleader = ' '
let g:mapleader =' '
" Transfer `,` funciton
let g:usecommaleader = 1
noremap <M-,> ,
let maplocalleader = ';'
let g:maplocalleader = ';'
noremap <m-;> ;
" nmap <space> <leader>
" nmap <space><space> <leader><leader>
" }}}1 "

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=7 " Set 7 lines to the cursor
set tw=78

if !has('nvim')
  if empty($TMUX)
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    if v:version >= 800
      let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    endif
  else
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    if v:version >= 800
      let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    endif
  endif
endif

" Turn on the WiLd menu
set wildmenu
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

" Ignore compiled files
" set wildignore=*.o,*~,*.pyc
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
if WINDOWS()
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

set diffopt+=vertical

" FIXEDME: Caused to crash "set shell=bash\ -i "
"Always show current position
" set ruler
if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
                                " Selected characters/lines in visual mode
endif

" set cmdheight=2 " Height of the command bar
" set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

" Set to auto read when a file is changed from the outside
set autoread

set whichwrap+=<,>,h,l
set hid                        " A buffer becomes hidden when it is abandoned
set backspace=eol,start,indent " Configure backspace so it acts as it should act
set ignorecase                 " Ignore case when searching
set smartcase                  " When searching try to be smart about cases
set hlsearch                   " Highlight search results
set incsearch                  " Makes search act like search in modern browsers
set lazyredraw                 " Don't redraw while executing macros (good performance config)
set magic                      " For regular expressions turn magic on
set showmatch                  " Show matching brackets when text indicator is over them
set mat=2                      " How many tenths of a second to blink when matching brackets
set noerrorbells               " No annoying sound on errors
set novisualbell
set t_vb=
set tm=500                     " Timeoutlen
set ttimeoutlen=10
set foldcolumn=1               " Add a bit extra margin to the left
set number                     " Show line numbers
set relativenumber             " Show releative line numbers
set modeline
set modelines=3
set ttyfast
set complete     -=i
if has('nvim') || v:version >= 800
  set completeopt+=noselect
endif

" => Colors and Fonts {{{1 "
" Move to plugins.vim
" syntax enable " Enable syntax highlighting

" set background=dark
" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif
if has("gui_mac") || has("gui_macvim")
    " make Mac's Option key behave as the Meta key
    set invmmta
    try
      set transparency=5
    catch
    endtry
endif

" => Files, backups and undo {{{1 "
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup  nowb  noswapfile

" Status line {{{1 "
" Format the status line
if has('statusline') && 1
    set laststatus=2
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-10.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" Text, tab and indent related {{{1
" ---------------------------------
set smarttab expandtab shiftwidth=4 tabstop=4
set wrap linebreak
set autoindent smartindent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list
set listchars=tab:▸\ ,trail:•,extends:#,nbsp:.,eol:¬ " Highlight problematic whitespace
set formatoptions+=1
set formatoptions+=j " Add 'j' flag to 'formatoptions': Remove comment leader when joining lines.
let &showbreak = '↳ '
set breakindent
set breakindentopt=sbr

" if has('multi_byte') && &encoding ==# 'utf-8'
    let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
    let &fillchars = 'diff: '  " ▚
    let &showbreak = '↪ '
    highlight VertSplit ctermfg=242
    augroup vimrc
        autocmd InsertEnter * set listchars-=trail:⣿
        autocmd InsertLeave * set listchars+=trail:⣿
    augroup END
" endif

" set tabpagemax=15               " Only show 15 tabs
" set showmode                    " Display the current mode

set cursorline                  " Highlight current line
" set cursorcolumn

"highlight clear SignColumn      " SignColumn should match background
"highlight clear LineNr          " Current line number row will have same background color in relative mode
"highlight clear CursorLineNr    " Remove highlight color from current line number


set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing

" Always switch to the current file directory
" autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
set autochdir

" set autowrite                       " Automatically write a file when leaving a modified buffer
" set spell                           " Spell checking on
set shortmess+=filmnrxoOtT                      " Abbrev. of messages (avoids 'hit enter')
set virtualedit=onemore,block                   " Allow for cursor beyond last character
set iskeyword-=.                                " '.' is an end of word designator
set iskeyword-=#                                " '#' is an end of word designator
set iskeyword-=-
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility


" Make VIM remember position in file after reopen
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if !has('nvim') && !has('gui_running')
  " for i in range(48, 57) + range(65, 90) + range(97, 122)
  for i in range(32,126)
    " echo i
    if index([32,34,44, 60, 62, 92,124], i)>=0 | continue| endif
    " echo 'good'
    execute 'set <A-' . nr2char(i) . '>=^[' . nr2char(i)
  endfor
  set <A-space>=^[<space>
  set <A-/>=^[/
endif

if has('nvim')
  nnoremap <leader>t      :vsplit +terminal<cr>
  tnoremap <esc>          <c-\><c-n>
endif
" echom 'load basic finished!'
" ----------------------------

" vim: set ft=vim sw=2 ts=2 et foldmethod=marker:
