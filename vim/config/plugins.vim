" pre configuration before loading plugins {{{
" ============================================

" let g:python_host_prog='/Users/ada/anaconda/envs/py27/bin/python'
let g:python3_host_prog='/Users/ada/anaconda/bin/python'
" let g:python3_host_prog='/usr/local/bin/python3'
let g:python_host_prog ='/usr/bin/python'

" Latex {{{
" -----------
""" vimtex
" let s:viewer = 'okular'
let s:viewer = 'open '
let g:tex_flavor='latex'
let g:tex_fold_enabled=0
let g:Tex_Outdir='build'
set iskeyword+=:
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_ps = 'okular' "'gv'
let g:Tex_ViewRule_pdf = s:viewer "'xpdf'
let g:Tex_ViewRule_dvi = 'okular' "'xdvi'
let g:Tex_UseEditorSettingInDVIViewer = 1
let g:Tex_CompileRule_dvi = 'latex -synctex=1 -src-specials -interaction=nonstopmode $*'
" let g:Tex_CoampileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode $*'
let g:Tex_CoampileRule_pdf = 'latexmk -pdf -output-directory=build -synctex=1 -interaction=nonstopmode $*'
" Set Tex_UseMakefile to 0 if you want to ignore the presence of a Makefile
" when deciding how to compile
let g:Tex_UseMakefile = 0 " FIXEDME
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'dvi,pdf'
" }}}

" VIMTEX settings {{{
" ===================
" let g:vimtex_latexmk_build_dir='build'
let g:vimtex_latexmk_build_dir='/tmp/build'
autocmd FileType tex let b:vimtex_main = 'main.tex'
if OSX()
  let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '-r @line "@pdf" "@tex"'
elseif LINUX()
  let g:vimtex_view_general_viewer = 'okular'
  let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
  let g:vimtex_view_general_options_latexmk = '--unique'
elseif WINDOWS()
  let g:vimtex_view_general_viewer = 'SumatraPDF'
  let g:vimtex_view_general_options
        \ = '-reuse-instance -forward-search @tex @line @pdf'
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
else
  echo 'Unknown OS'
endif
map \v :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf<CR>
" VIMTEX settings }}}

" Dein packages manager core {{{
" ------------------

let s:path = exists('g:vimpath') ? g:vimpath : "~/.vim"
let s:bundlepath = (exists('g:bundlepath') ? g:bundlepath : s:path) . "/plug"
" let s:plugpath =  s:bundlepath . '/plug.vim'
let s:plugpath =  s:path

let g:bundlepath = s:bundlepath
let g:plugpath   = s:plugpath
let g:path       = s:path

if has('vim_starting')
  set nocompatible               " Be iMproved
endif

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

silent! if plug#begin(s:bundlepath)
  ""  Installing packages

  " ==> UI {{{
  " ----------
    Plug 'scrooloose/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'sheerun/vim-polyglot'  " A collection of language packs for Vim.
    " Plug 'vim-scripts/CSApprox'  " makes GVim-only colorschemes Just Work in terminal Vim
    Plug 'majutsushi/tagbar'
    Plug 'vim-scripts/taglist.vim'
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
  " Plug 'tpope/vim-commentary'
  Plug 'scrooloose/nerdcommenter'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'machakann/vim-highlightedyank'
  let g:highlightedyank_highlight_duration = 100
  " Plug 'maxbrunsfeld/vim-yankstack'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'terryma/vim-expand-region'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'jiangmiao/auto-pairs'
  Plug 'rking/ag.vim'
  Plug 'Chiel92/vim-autoformat' " autoformat
  Plug 'w0rp/ale' " flying check
  let g:ale_emit_conflict_warnings = 0
  " Plug 'vim-scripts/grep.vim'
  " Plug 'scrooloose/syntastic'
  " Plug 'Raimondi/delimitMate'
  " ==> Edit }}}

  " ==> Navigating & Searching {{{
  " ------------------------------
  Plug 'rking/ag.vim'
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
  Plug 'mhinz/vim-signify'
  Plug 'airblade/vim-gitgutter'
  " => Git }}}


  " => Auto Complete {{{
  " -------------------
  if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'  " neovim-rpc wrapper
  endif
  let s:use_ncm = has('nvim') || (has('g:use_ncm') && g:use_ncm)
  if s:use_ncm
    Plug 'roxma/nvim-completion-manager' " ac
  else
    Plug 'Shougo/neocomplete.vim'
  endif
  Plug 'Shougo/neco-vim'               " pyton
  Plug 'davidhalter/jedi'              " Snippets
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
  Plug 'roosta/srcery'
  Plug 'rakr/vim-one'
  " Plug 'lucy/term.vim'
  " Plug 'vim-scripts/Visual-Studio'
  Plug 'cohlin/vim-colorschemes'
  Plug 'altercation/vim-colors-solarized'
  Plug 'vim-scripts/mayansmoke'
  Plug 'nightsense/seabird'
  Plug 'morhetz/gruvbox'
  Plug 'gregsexton/Muon'
  Plug 'joshdick/onedark.vim'
  "" Colors  }}}

  " ==> Languages {{{
  " -----------------
  "" Lua Bundle
  Plug 'xolox/vim-lua-ftplugin'
  Plug 'xolox/vim-lua-inspect'

  " C Language
  Plug 'vim-scripts/c.vim'

  "" latex bundle
  Plug 'vim-latex/vim-latex'
  Plug 'lervag/vimtex'

  "" Markdown
  "Bundle 'tpope/vim-markdown'
  Plug 'godlygeek/tabular' " Needed by vim-markdown
  Plug 'plasticboy/vim-markdown'
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

let g:neocomplete#enable_at_startup = 1

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
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


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
map <leader>fm :Denite file_mru<cr><c-o>
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
let g:gitgutter_enabled=0
nnoremap <silent> <Leader>d :GitGutterToggle<cr>


" session management
let g:session_directory = "~/.vim/tem/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1



" syntastic
let g:syntastic_python_checkers=['python', 'flake8']


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
if isdirectory(expand(s:bundlepath . "tabular"))
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

" xmap <Leader><Enter>   <Plug>(LiveEasyAlign)
" nmap <Leader><Leader>a <Plug>(LiveEasyAlign)

" inoremap <silent> => =><Esc>mzvip:EasyAlign/=>/<CR>`z$a<Space>
"
"
" VIM-TEX
if has('mac') || has('macunix')
  let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '-r @line @pdf @tex'
endif
let g:vimtex_fold_enabled = 0 "So large files can open more easily
let g:vimtex_latexmk_continuous=0

""""""""""""""""""""""""""""""
" Nerdi Commenter
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

nmap <a-?> <Plug>NERDComAppendComment
imap <a-?> <C-o><Plug>NERDComAppendComment
nmap <a-/> <Plug>NERDCommenterToggle
xmap <a-/> <Plug>NERDCommenterToggle
imap <a-/> <C-o><Plug>NERDCommenterToggle
nmap ÷ <Plug>NERDCommenterToggle
xmap ÷ <Plug>NERDCommenterToggle
imap ÷ <C-o><Plug>NERDCommenterToggle


" Markdown {{{
" let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['csharp=cs','c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
" let g:vim_markdown_new_list_item_indent = 2
" Markdown }}}

" MarkdownPreview {{{
" -------------------
let g:mkdp_path_to_chrome = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"
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
" Plugins' configuration }}}



" vim: set et sw=2 ts=2 tw=78 foldmethod=marker foldlevel=1:
