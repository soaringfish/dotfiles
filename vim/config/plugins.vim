" pre configuration before loading plugins {{{
" ============================================

" Plug packages manager core {{{
" ------------------

let s:path = exists('g:vimpath') ? g:vimpath : "~/.vim"
let s:bundlepath = (exists('g:bundlepath') ? g:bundlepath : s:path) . "/plug"
" let s:plugpath =  s:bundlepath . '/plug.vim'
let s:plugpath =  s:path

let g:bundlepath = s:bundlepath
let g:plugpath   = s:plugpath
let g:path       = s:path

exec 'set runtimepath+=' . s:plugpath

if empty(glob(s:plugpath . '/autoload/plug.vim'))
  execute 'silent !curl -fLo ' . s:plugpath . '/autoload/plug.vim --create-dirs ' .
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall  | execute 'source ' . g:vimrc . '/vimrc'
endif


" }}}

" }}}


" Loading plugins {{{
" ===================

" let g:use_ncm = 1
let g:use_deoplete = 0

silent! if plug#begin(s:bundlepath)
  ""  Installing packages

  " ==> UI {{{
  " ----------
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " if has('gui_running') | Plug 'jistr/vim-nerdtree-tabs' | endif " making NERDTree feel like a true panel, independent of tabs.
    Plug 'sheerun/vim-polyglot'  " A collection of language packs for Vim.
    let g:polyglot_disabled=['latex']
    " Plug 'vim-scripts/CSApprox'  " makes GVim-only colorschemes Just Work in terminal Vim
    Plug 'majutsushi/tagbar'
    Plug 'vim-scripts/taglist.vim'
    " if has('gui_running')
      " Plug 'luochen1990/rainbow'
    " else
      Plug 'kien/rainbow_parentheses.vim'
    " endif
    Plug 'Yggdroot/indentLine'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Plug 'kana/vim-narrow'
    " Plug 'junegunn/vim-peekaboo'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'vim-scripts/mru.vim'
    Plug 'vim-voom/VOoM'
    " Plug 'itchyny/lightline.vim'
  " ==> UI }}}

  " ==> Edit {{{
  " ------------
  Plug 'chrisbra/unicode.vim'
  " Plug 'tpope/vim-commentary'
  Plug 'scrooloose/nerdcommenter'
  Plug 'bronson/vim-trailing-whitespace'
  if has('nvim')
    Plug 'machakann/vim-highlightedyank'
    let g:highlightedyank_highlight_duration = 100
  endif
  " Plug 'maxbrunsfeld/vim-yankstack'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'terryma/vim-expand-region'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-rsi'
  Plug 'jiangmiao/auto-pairs'
  " Plug 'Raimondi/delimitMate'
  Plug 'Konfekt/FastFold'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'neomake/neomake'
  Plug 'Chiel92/vim-autoformat' " autoformat
  Plug 'w0rp/ale' " flying check
  let g:ale_enabled = 0
  let g:ale_emit_conflict_warnings = 0
  " Plug 'vim-scripts/grep.vim'
  " Plug 'scrooloose/syntastic'
  " ==> Edit }}}

  " ==> Navigating & Searching {{{
  " ------------------------------
  Plug 'rking/ag.vim'
  Plug 'mhinz/vim-grepper'
  Plug 'easymotion/vim-easymotion'
  Plug 'junegunn/vim-easy-align'
  Plug 'Shougo/denite.nvim'
  " Plug 'Shougo/unite.vim'
  " Plug 'tsukkee/unite-tag'
  " Plug 'Shougo/unite-outline'
  Plug 'Shougo/neomru.vim'
  Plug 'dyng/ctrlsf.vim'
  Plug 'tmhedberg/matchit'
  Plug 'haya14busa/incsearch.vim'
  " Plug 'junegunn/fzf',  {'build': './install --all', 'rtp': ''}
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " Plug 'ctrlpvim/ctrlp.vim'
  " CtrlP {{{
  " Plug 'FelikZ/ctrlp-py-matcher'
  " let g:airline#extensions#tabline#enabled = 1
  " let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
  " isi }}}
  " ==> Navigating & Searching }}}
  " => Git {{{
  " ----------
  Plug 'tpope/vim-fugitive'
  " Plug 'mhinz/vim-signify' " More pretty look, supports more VMs
  Plug 'airblade/vim-gitgutter' "Stage or Undo hunks
  " => Git }}}

  " => Auto Complete {{{
  " -------------------
  let s:use_deoplete = has('nvim') && get(g:, 'use_deoplete')
  let s:use_ncm = !s:use_deoplete && (has('nvim') || get(g:, 'use_ncm'))
  if s:use_deoplete
    Plug 'Shougo/deoplete.nvim'
    Plug 'zchee/deoplete-jedi'
  elseif s:use_ncm
    if !has('nvim')
      Plug 'roxma/vim-hug-neovim-rpc'  " neovim-rpc wrapper
    endif
    Plug 'roxma/nvim-completion-manager' " ac
    " Plug 'roxma/clang_complete'
  else
    Plug 'Shougo/neocomplete.vim'
  endif
  Plug 'Shougo/neco-vim'               " pyton
  " Plug 'davidhalter/jedi'              " Snippets
  Plug 'SirVer/ultisnips'              " UltiSnips
  Plug 'honza/vim-snippets'            " snipptes
  Plug 'davidhalter/jedi-vim'
  Plug 'wellle/tmux-complete.vim'
  let g:tmuxcomplete#trigger = ''
  " let g:tmuxcomplete#trigger = 'completefunc'
  " Plug 'neitanod/vim-clevertab'
  " let g:use_clevertab=1
  " Plug 'ervandew/supertab'
  " Plug 'valloric/youcompleteme'
  " => Autocomplete }}}

  "" Colors  {{{
  Plug 'tomasr/molokai'
  " Plug 'ifepillar/vim-wwdc17-theme'
  " Plug 'roosta/srcery'
  " Plug 'ajmwagar/vim-deus'
  " Plug 'kudabux/vim-srcery-drk'
  " Plug 'rakr/vim-one'
  " Plug 'lucy/term.vim'
  " Plug 'vim-scripts/Visual-Studio'
  " Plug 'cohlin/vim-colorschemes'
  Plug 'altercation/vim-colors-solarized'
  Plug 'vim-scripts/mayansmoke'
  Plug 'nightsense/seabird'
  Plug 'morhetz/gruvbox'
  Plug 'mhinz/vim-janah'
  Plug 'jonathanfilip/vim-lucius'
  " Plug 'gregsexton/Muon'
  " Plug 'joshdick/onedark.vim'
  "" Colors  }}}

  " ==> Languages {{{
  " -----------------
  "" Lua Bundle
  Plug 'xolox/vim-lua-ftplugin'
  Plug 'xolox/vim-lua-inspect'

  " C Language
  " Plug 'vim-scripts/c.vim'

  "" latex bundle
  " Plug 'vim-latex/vim-latex'
  Plug 'lervag/vimtex'

  "" Markdown
  "Bundle 'tpope/vim-markdown'
  Plug 'godlygeek/tabular' " Needed by vim-markdown
  " Plug 'plasticboy/vim-markdown'
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'suan/vim-instant-markdown'
  Plug 'mzlogin/vim-markdown-toc'
  Plug 'iamcco/mathjax-support-for-mkdp'
  Plug 'iamcco/markdown-preview.vim'

  " HTML
  " Plug 'vim-scripts/HTML-AutoCloseTag'
  " Plug 'hail2u/vim-css3-syntax'
  " Plug 'gorodinskiy/vim-coloresque'
  " Plug 'tpope/vim-haml'
  Plug 'mattn/emmet-vim'

  " ==> Languages }}}

  " "" Misc {{{
  " -----------
  "" Vim-Session
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-session'
  Plug 'mhinz/vim-sayonara'
  Plug 'beloglazov/vim-online-thesaurus'
  Plug 'myusuf3/numbers.vim'
  Plug 'hotoo/pangu.vim' " Auto spacing mixed inputs
  Plug 'vim-scripts/DrawIt'
  " "" Misc }}}

  call plug#end()
endif

" Required:
filetype plugin indent on
syntax enable

" Loading plugins }}}


" Plugins' configuration {{{
" ==========================

" Neocomplete {{{
" ---------------
" \ 'cm_refresh_patterns': g:vimtex#re#ncm,
if s:use_ncm
  " g:cm_refresh_length=[[1,4],[7,3]]
  let g:cm_refresh_length=[[1,3],[7,2]]
  " let g:cm_matcher={'module': 'cm_matchers.prefix_matcher',
        " \ 'case': 'smartcase'}
  let g:cm_matcher={'module': 'cm_matchers.fuzzy_matcher',
        \ 'case': 'smartcase'}
  autocmd User CmSetup call cm#register_source({
        \ 'name' : 'vimtex',
        \ 'priority': 8,
        \ 'scoping': 1,
        \ 'scopes': ['tex'],
        \ 'abbreviation': 'tex',
        \ 'cm_refresh_patterns': g:vimtex#re#ncm,
        \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
        \ })
elseif s:use_deoplete
  let g:deoplete#enable_at_startup = 1
  if !exists('g:deoplete#omni#input_patterns')
      let g:deoplete#omni#input_patterns = {}
  endif
  let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
else " use neocomplete
  let g:neocomplete#enable_at_startup = 1
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.tex =
        \ g:vimtex#re#neocomplete
endif

" " Clang-complete {{{ "
" let g:clang_library_path='/usr/local/opt/llvm/lib/libclang.dylib'
" let g:neomake_cpp_enabled_makers = ['clang']
" let g:neomake_c_enabled_makers = ['clang']
" " let g:clang_complete_auto = 1
" au FileType c,cpp  nmap gd <Plug>(clang_complete_goto_declaration)
" " }}} Clang-complete "
"
autocmd FileType python setlocal omnifunc=jedi#completions

let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" Neocomplete }}}
" " JEDI-VIM {{{
" --------------
let g:jedi#goto_command = "<leader>pc"
let g:jedi#goto_assignments_command = "<leader>pa"
let g:jedi#goto_definitions_command = "<leader>pd"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>pu"
" let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>pr"
" " JEDI-VIM }}}
"
let g:session_autoload=0
" Unite
" call unite#custom#source('codesearch', 'max_candidates', 30)
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#filters#sorter_default#use(['sorter_rank'])


" snippets
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" let g:UltiSnipsEditSplit="vertical"

" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
" inoremap <expr> <CR> pumvisible() ? "\<c-y>\<cr>" : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>
map <localleader>f :MRU<CR>

" => Denite {{{
" =============
map <leader>ff :Denite file_rec<cr>
map <leader>fd :Denite file<cr>
map <leader>fa :Denite
map <leader>fb :Denite buffer<cr>
map <leader>fm :Denite file_mru<cr>
map <leader>fo :Denite outline<cr>
map <leader>ft :Denite tag<cr>
map <leader>fj :Denite jump<cr>
map <leader>fl :Denite line<cr>
map <leader>fc :Denite command<cr>
map <leader>fr :Denite register<cr>

" Change mappings.
call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)
" => Denite }}}

""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
" nmap <c-p> <Plug>yankstack_substitute_older_paste
" nmap <c-P> <Plug>yankstack_substitute_newer_paste


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
" let g:ctrlp_working_path_mode = 0
"
" " let g:ctrlp_map = '<c-f>'
" map <leader>j :CtrlP<cr>
" map <c-b>b :CtrlPBuffer<cr>
" map <c-b>g :CtrlPBufTag<cr>
" map <c-b>t :CtrlPTag<cr>
" map <c-b>m :CtrlPMRUFiles<cr>
" map <c-b>f :CtrlPCurFile<cr>
"
" let g:ctrlp_max_height = 20
" " let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'
"

"" ctrlp.vim
"set wildmode=list:longest,list:full
"set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
"let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
"let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
"let g:ctrlp_use_caching = 1



" The Silver Searcher
if executable('ag')
  " set grepprg=ag\ --nogroup\ --nocolor
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " CtrlSF.vim
  let g:ctrlsf_ackprg = 'ag'
  let g:ctrlp_use_caching = 0
endif

" noremap <leader>b :CtrlPBuffer<CR>
" let g:ctrlp_map = '<leader>e'
" let g:ctrlp_open_new_file = 'r'
" let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'




" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" Disable visualbell
set visualbell t_vb=



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:multi_cursor_next_key="\<C-s>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'filetype' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimroom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
let g:syntastic_python_checkers=['pyflakes']

" Javascript
let g:syntastic_javascript_checkers = ['jshint']

" Go
let g:syntastic_auto_loc_list = 1
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

" Custom CoffeeScript SyntasticCheck
" func! SyntasticCheckCoffeescript()
"   let l:filename = substitute(expand("%:p"), '\(\w\+\)\.coffee', '.coffee.\1.js', '')
"   execute "tabedit " . l:filename
"   execute "SyntasticCheck"
"   execute "Errors"
" endfunc
" nnoremap <silent> <Leader>l :call SyntasticCheckCoffeescript()<cr>
"
" " syntastic
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_error_symbol='✗'
" let g:syntastic_warning_symbol='⚠'
" let g:syntastic_style_error_symbol = '✗'
" let g:syntastic_style_warning_symbol = '⚠'
" let g:syntastic_auto_loc_list=1
" let g:syntastic_aggregate_errors = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=1
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
nnoremap <silent> <Leader>tgg :GitGutterToggle<cr>


" session management
let g:session_directory = "~/.vim/tem/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1



" syntastic
" let g:syntastic_python_checkers=['python', 'flake8']


"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" airline
let g:airline_theme='sol'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
if !exists('g:airline_powerline_fonts') ||
      \ g:airline_powerline_fonts == 0
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif


" Tabularize "
if isdirectory(expand(s:bundlepath . "/tabular"))
  nmap <Leader>a& :Tabularize /&<CR>
  vmap <Leader>a& :Tabularize /&<CR>
  nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
  vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
  nmap <Leader>a=> :Tabularize /=><CR>
  vmap <Leader>a=> :Tabularize /=><CR>
  nmap <Leader>a: :Tabularize /:<CR>
  vmap <Leader>a: :Tabularize /:<CR>
  nmap <Leader>a:: :Tabularize /:\zs<CR>
  vmap <Leader>a:: :Tabularize /:\zs<CR>
  nmap <Leader>a, :Tabularize /,<CR>
  vmap <Leader>a, :Tabularize /,<CR>
  nmap <Leader>a,, :Tabularize /,\zs<CR>
  vmap <Leader>a,, :Tabularize /,\zs<CR>
  nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
  vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
endif

" ----------------------------------------------------------------------------
" <Enter> | vim-easy-align
" ----------------------------------------------------------------------------
let g:easy_align_delimiters = {
      \ '>': { 'pattern': '>>\|=>\|>' },
      \ '\': { 'pattern': '\\' },
      \ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
      \ ']': {
      \     'pattern':       '\]\zs',
      \     'left_margin':   0,
      \     'right_margin':  1,
      \     'stick_to_left': 0
      \   },
      \ ')': {
      \     'pattern':       ')\zs',
      \     'left_margin':   0,
      \     'right_margin':  1,
      \     'stick_to_left': 0
      \   },
      \ 'f': {
      \     'pattern': ' \(\S\+(\)\@=',
      \     'left_margin': 0,
      \     'right_margin': 0
      \   },
      \ 'd': {
      \     'pattern': ' \ze\S\+\s*[;=]',
      \     'left_margin': 0,
      \     'right_margin': 0
      \   },
      \ '%': { 'pattern': '%\+', 'delimiter_align': 'l', 'ignore_groups': ['!Comment']  },
      \ }

" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(EasyAlign)
nmap gaa ga_

xmap <Leader><Leader>a   <Plug>(LiveEasyAlign)
nmap <Leader><Leader>a <Plug>(LiveEasyAlign)

" inoremap <silent> => =><Esc>mzvip:EasyAlign/=>/<CR>`z$a<Space>
"
"
" VIM-TEX
let g:tex_flavor='latex'
set iskeyword+=:
if has('mac') || has('macunix')
  " let g:vimtex_view_method='zathura'
  let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '-r @line @pdf @tex'
elseif LINUX()
  let g:vimtex_view_method='zathura'
endif
let g:vimtex_fold_enabled = 1 "So large files can open more easily
let g:vimtex_latexmk_continuous=0

""""""""""""""""""""""""""""""
" Nerdi Commenter {{{
" ===============

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

nmap <a-?> <Plug>NERDCommenterAppend
imap <a-?> <C-o><Plug>NERDCommenterAppend
nmap <a-/> <Plug>NERDCommenterToggle
xmap <a-/> <Plug>NERDCommenterToggle
imap <a-/> <C-o><Plug>NERDCommenterToggle
nmap ÷ <Plug>NERDCommenterToggle
xmap ÷ <Plug>NERDCommenterToggle
imap ÷ <C-o><Plug>NERDCommenterToggle
nmap <leader>cp <Plug>NERDCommenterYank<Esc>p
nmap <leader>cP <Plug>NERDCommenterYank<Esc>P
" }}}

" Markdown {{{
" let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['csharp=cs', 'c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
" let g:vim_markdown_new_list_item_indent = 2
" Markdown }}}

" MarkdownPreview {{{
" -------------------
if OSX()
  let g:mkdp_path_to_chrome = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"
endif
let g:mkdp_auto_start = 0
let g:mkdp_auto_open = 0
" set to 1, the vim will auto open preview window when you edit the
" markdown file
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 1
let g:mkdp_command_for_global = 0
" MarkdownPreview }}}

" Markdown instant preview {{{
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
" Markdown instant preview }}}

" LUA: xolox/vim-lua-inspect {{{
" Don't enable the lua-inspect plug-in automatically in Lua buffers.
let g:lua_inspect_events = ''
"
" " Enable/disable the lua-inspect plug-in manually using <F6>.
imap <F6> <C-o>:LuaInspectToggle<CR>
nmap <F6>      :LuaInspectToggle<CR>
" LUA: xolox/vim-lua-inspect }}}

" AutoPairs{{{
" ------------

" System Shortcuts:
"     <CR>  : Insert new indented line after return if cursor in blank brackets or quotes.
"     <BS>  : Delete brackets in pair
"     <M-p> : Toggle Autopairs (g:AutoPairsShortcutToggle)
"     <M-e> : Fast Wrap (g:AutoPairsShortcutFastWrap)
"     <M-n> : Jump to next closed pair (g:AutoPairsShortcutJump)
"     <M-b> : BackInsert (g:AutoPairsShortcutBackInsert)
" let g:AutoPairsShortcutFastWrap   = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsMoveCharacter      = ''

" AutoPairs}}}

" DelimitMate {{{ "
" let g:delimitMate_expand_cr=1
" }}} DelimitMate "

" vim-sayonara {{{
nnoremap <silent><leader>x  :Sayonara<cr>
nnoremap <silent><leader>X  :Sayonara!<cr>

let g:sayonara_confirm_quit = 0
" vim-sayonara }}}

" Plugin: vim-online-thesaurus {{{2
nnoremap <leader>k :OnlineThesaurusCurrentWord<cr>
nnoremap <leader>K :Thesaurus<space>

" Plugin: vim-grepper {{{2
nnoremap <leader>g :Grepper -tool git<cr>
nnoremap <leader>G :Grepper -tool ag<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

highlight GrepperSideFile ctermfg=161 cterm=reverse
highlight Conceal ctermfg=NONE ctermbg=250

let grepper = {
      \ 'tools': ['git', 'ag', 'rubocop'],
      \ 'rubocop': {
      \   'grepprg': 'rubocop -femacs',
      \   'grepformat': '%f:%l:%c: %t: %m',
      \ }}

command! Todo Grepper -tool ag -query '(TODO|FIXME|XXX):'
" }}}2 "

" Plugins' configuration }}}




" vim: set et sw=2 ts=2 tw=78 foldmethod=marker foldlevel=1:
