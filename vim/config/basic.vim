" Identify platform {
silent function! OSX()
    return has('macunix') || has('mac')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win32') || has('win64'))
endfunction
" }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let $LANG='en' " Avoid garbled characters in Windows
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set encoding=utf8
set fileformats=unix,dos,mac

set history=500 " Sets how many lines of history VIM has to remember

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

let mapleader = ','
let g:mapleader = ','
" Transfer `,` funciton
noremap <M-;> ,

let maplocalleader = '\'
let g:maplocalleader = '\'
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

" Turn on the WiLd menu
set wildmenu
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
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
set tm=500
set foldcolumn=1               " Add a bit extra margin to the left
set number                     " Show line numbers
set relativenumber             " Show releative line numbers

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable " Enable syntax highlighting

" set background=dark
" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup  nowb  noswapfile

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

if has('statusline') && 0
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" set autowrite                       " Automatically write a file when leaving a modified buffer
" set spell                           " Spell checking on
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set virtualedit=onemore             " Allow for cursor beyond last character
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility


" echom 'load basic finished!'
" ----------------------------

" vim: set ft=vim sw=2 ts=2 et foldmethod=marker:
