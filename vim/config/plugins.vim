""""""""""""""""""""""""""""""""""""""""""""""
"  plugins.vim: Loading & Configing plugins  "
""""""""""""""""""""""""""""""""""""""""""""""

" Plug packages manager core {{{
" ------------------------------

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

" Loading plugins {{{1
" --------------------

" let g:use_ncm = 1
let g:use_deoplete = 1
" let g:use_deoplete_nvim = 1
let g:load_python_mode = 0

silent! if plug#begin(s:bundlepath)
  ""  Installing packages

  " ==> UI {{{2
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    " if has('gui_running') | Plug 'jistr/vim-nerdtree-tabs' | endif " making NERDTree feel like a true panel, independent of tabs.
    Plug 'sheerun/vim-polyglot'  " A collection of language packs for Vim.
    let g:polyglot_disabled=['latex', 'nomarkdown', 'nolua', 'nopython']
    " Plug 'vim-scripts/CSApprox'  " makes GVim-only colorschemes Just Work in terminal Vim
    Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
    Plug 'vim-scripts/taglist.vim', { 'on': 'TlistToggle' }
    " if has('gui_running')
      " Plug 'luochen1990/rainbow'
    " else
      Plug 'kien/rainbow_parentheses.vim'
    " endif
    Plug 'junegunn/vim-emoji'
    " Plug 'ryanoasis/vim-devicons'
    Plug 'Yggdroot/indentLine'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Shougo/echodoc.vim'
    let g:echodoc#enable_at_startup = 1
    set cmdheight=2
    " Plug 'kana/vim-narrow'
    Plug 'junegunn/vim-peekaboo'
    Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
    Plug 'junegunn/limelight.vim', {'on': 'Limelight'}
    Plug 'vim-scripts/mru.vim'
    Plug 'vim-voom/VOoM', {'on': ['VoomToggle', 'Voom']}
    " Plug 'itchyny/lightline.vim'

  " ==> Edit {{{2
"   Plug 'chrisbra/unicode.vim'
  " Plug 'tpope/vim-commentary'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'scrooloose/nerdcommenter'
  Plug 'junegunn/vim-after-object'
  Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  " Plug 'bronson/vim-trailing-whitespace'
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
  " Python fold
  Plug 'tmhedberg/SimpylFold' , {'for': 'python'}
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'dhruvasagar/vim-table-mode'
  " Plug 'neomake/neomake'
  Plug 'Chiel92/vim-autoformat' " autoformat
  " Plug 'reedes/vim-pencil'
  Plug 'w0rp/ale' " flying check
  let g:ale_enabled = 0
  " let g:ale_emit_conflict_warnings = 0
  " Plug 'vim-scripts/grep.vim'
  " Plug 'scrooloose/syntastic'

  " ==> Navigating & Searching {{{2
"   Plug 'rking/ag.vim' " Deprecated
  Plug 'mileszs/ack.vim'
  Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
  Plug 'easymotion/vim-easymotion'
  Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'Shougo/unite.vim'
  " Plug 'tsukkee/unite-tag'
  " Plug 'Shougo/unite-outline'
  Plug 'Shougo/neomru.vim'
  " Plug 'dyng/ctrlsf.vim', {'on': ['CtrlSF', 'CtrlSFToggle']}
  Plug 'tmhedberg/matchit'
  Plug 'haya14busa/incsearch.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " Plug 'ctrlpvim/ctrlp.vim'
  " Plug 'FelikZ/ctrlp-py-matcher'
  " let g:airline#extensions#tabline#enabled = 1
  " let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

  " => Git {{{2
  Plug 'tpope/vim-fugitive'
  " Plug 'mhinz/vim-signify' " More pretty look, supports more VMs
  Plug 'airblade/vim-gitgutter' "Stage or Undo hunks
  Plug 'lambdalisue/vim-gita'
  Plug 'junegunn/gv.vim'
  Plug 'gregsexton/gitv'

  " => Auto Complete {{{2
  " -------------------
  let s:use_deoplete = (get(g:,'use_deoplete_nvim') || !has('nvim')) && get(g:, 'use_deoplete')
  " let s:use_deoplete=1
  let s:use_ncm = !s:use_deoplete && (has('nvim') || get(g:, 'use_ncm'))
  if s:use_deoplete
    if has('nvim')
      Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
      Plug 'ujihisa/neco-look'
    else
      Plug 'Shougo/deoplete.nvim'
      Plug 'roxma/nvim-yarp'
      Plug 'roxma/vim-hug-neovim-rpc'
    endif
    Plug 'zchee/deoplete-jedi'
    Plug 'tweekmonster/deoplete-clang2'
  elseif s:use_ncm
    if !has('nvim')
      Plug 'roxma/vim-hug-neovim-rpc'  " neovim-rpc wrapper
    endif
    Plug 'roxma/nvim-completion-manager' " ac
    Plug 'gaalcaras/ncm-R'
    " Plug 'roxma/clang_complete'
    Plug 'roxma/ncm-clang'
  else
    Plug 'Shougo/neocomplete.vim'
  endif

  function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
      !./install.py --clang-completer --gocode-completer
    endif
  endfunction
  Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp'], 'do': function('BuildYCM') }


  Plug 'Shougo/neco-vim'               " pyton
  " Plug 'davidhalter/jedi'            " Snippets
  Plug 'SirVer/ultisnips'              " UltiSnips
  Plug 'honza/vim-snippets'            " snipptes
  Plug 'davidhalter/jedi-vim' , {'for': 'python'}
  if ! get(s:,"use_ncm") || 0
    Plug 'wellle/tmux-complete.vim'
    let g:tmuxcomplete#trigger = ''
  endif
  " let g:tmuxcomplete#trigger = 'completefunc'
  " Plug 'neitanod/vim-clevertab'
  " let g:use_clevertab=1
  " Plug 'ervandew/supertab'
  " Plug 'valloric/youcompleteme'
  " => Autocomplete }}}2

  "" Colors  {{{2
  " Plug 'tomasr/molokai'
  " Plug 'ifepillar/vim-wwdc17-theme'
  " Plug 'roosta/srcery'
  " Plug 'ajmwagar/vim-deus'
  " Plug 'kudabux/vim-srcery-drk'
  Plug 'rakr/vim-one'
  Plug 'junegunn/seoul256.vim'
  " Plug 'lucy/term.vim'
  " Plug 'vim-scripts/Visual-Studio'
  " Plug 'cohlin/vim-colorschemes'
  Plug 'altercation/vim-colors-solarized'
  " Plug 'vim-scripts/mayansmoke'
  Plug 'nightsense/seabird'
  Plug 'morhetz/gruvbox'
  " Plug 'mhinz/vim-janah'
  " Plug 'jonathanfilip/vim-lucius'
  " Plug 'gregsexton/Muon'
  Plug 'joshdick/onedark.vim'

  " Plug 'skielbasa/vim-material-monokai'
  " Plug 'Heorhiy/VisualStudioDark.vim'
  " Plug 'nightsense/simplifysimplify'
  " Plug 'nightsense/seagrey'
  Plug 'chriskempson/base16-vim'
  " Plug 'chriskempson/vim-tomorrow-theme'

  "" Colors  }}}2

  " ==> Languages {{{2
  " -----------------
  "" Python"
  if get(g:, 'load_python_mode') | Plug 'klen/python-mode' | endif
  " Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
"   Plug 'vim-scripts/indentpython.vim'
  " Plug 'ivanov/vim-ipython'
  " Plug 'julienr/vim-cellmode'

  "" Lua Bundle
  Plug 'xolox/vim-lua-ftplugin', {'for': 'lua'}
  Plug 'xolox/vim-lua-inspect',  {'for': 'lua'}

  " C Language
  " Plug 'vim-scripts/c.vim'
  Plug 'vim-scripts/DoxygenToolkit.vim'

  "" latex bundle
  " Plug 'vim-latex/vim-latex'
  Plug 'lervag/vimtex' ", {'for': 'tex'}

  "" Markdown
  "Bundle 'tpope/vim-markdown'
  " Plug 'godlygeek/tabular' " Needed by vim-markdown
  " Plug 'plasticboy/vim-markdown'
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  " Plug 'vim-pandoc/vim-pandoc-after'
"   Plug 'suan/vim-instant-markdown'
  Plug 'mzlogin/vim-markdown-toc'
  Plug 'iamcco/mathjax-support-for-mkdp'
  Plug 'iamcco/markdown-preview.vim'

  "" rust
  if executable('rustc')
    if s:use_ncm
      Plug 'racer-rust/vim-racer', {'for': 'rust'}
      Plug 'roxma/nvim-cm-racer', {'for': 'rust'}
    endif
  endif

  if executable('R')
    Plug 'jalvesaq/Nvim-R', {'for': 'r'}
    Plug 'vim-pandoc/vim-rmarkdown'
  endif

  " Org modeline
  " Plug 'jceb/vim-orgmode'
  " Plug 'tpope/vim-speeddating'

  " HTML
  " Plug 'vim-scripts/HTML-AutoCloseTag'
  " Plug 'hail2u/vim-css3-syntax'
  " Plug 'gorodinskiy/vim-coloresque'
  " Plug 'tpope/vim-haml'
  Plug 'mattn/emmet-vim'
  Plug 'othree/xml.vim'

  " ==> Languages }}}2

  " "" Misc {{{2
  " -----------
  "" Vim-Session
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-session'
  Plug 'mhinz/vim-sayonara'
  Plug 'junegunn/vader.vim'
  Plug 'justinmk/vim-dirvish'
"   Plug 'beloglazov/vim-online-thesaurus'
  " Plug 'myusuf3/numbers.vim'
  Plug 'hotoo/pangu.vim' " Auto spacing mixed inputs
  Plug 'vim-scripts/DrawIt'
  Plug 'skywind3000/asyncrun.vim'
  if LINUX() || OSX()
    " Plug 'vim-scripts/fcitx.vim'
    Plug 'CodeFalling/fcitx-vim-osx'
  endif
  Plug 'ppwwyyxx/vim-PinyinSearch'
  " let g:PinyinSearch_Dict = $HOME . '/.vim/plug/vim-PinyinSearch/PinyinSearch.dict'

  " Plug 'itchyny/calendar.vim'
  Plug 'vimwiki/vimwiki'
  Plug 'justinmk/vim-gtfo'
  " Plug 'xolox/vim-notes'
  " "" Misc }}}2

  call plug#end()
endif

" Required:
filetype plugin indent on
syntax enable

" Loading plugins }}}


" Plugins' configuration {{{1
" ---------------------------

" Plugin: Autocomplete: NCM/deoplete/neocomplete {{{2
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
        " \ |
        " \ call cm#register_source({
        " \ 'name' : 'xml-tag',
        " \ 'priority' : 8,
        " \ 'scoping' : 1,
        " \ 'scopes' : ['html', 'xml'],
        " \ 'abbreviation' : 'xml',
        " \ 'cm_refresh_patterns' : ['</.*>'],
        " \ 'cm_refresh' : {'ominifunc': 'xmlcomplete#CompleteTags'}
        " \ })
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
  " let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  let g:neocomplete#sources#omni#input_patterns.tex =
        \ g:vimtex#re#neocomplete
endif

" Plugin: Clang-complete {{{ 3"
" let g:clang_library_path='/usr/local/opt/llvm/lib/libclang.dylib'
" let g:neomake_cpp_enabled_makers = ['clang']
" let g:neomake_c_enabled_makers = ['clang']
" " let g:clang_complete_auto = 1
" au FileType c,cpp  nmap gd <Plug>(clang_complete_goto_declaration)

" Python-complete {{{3 "
" autocmd FileType python setlocal omnifunc=jedi#completions

let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0


" Autocomplete }}}2
" Plugin: JEDI-VIM {{{2
let g:jedi#goto_command = "<leader>pc"
let g:jedi#goto_assignments_command = "<leader>pa"
let g:jedi#goto_definitions_command = "<leader>pd"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>pu"
" let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>pr"

" Plugin: vim-Session {{{2 "
" let g:session_autoload=0
" session management
"
let g:session_directory = "~/.vim/tem/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1


" Plugin: Unite {{{2 "
" call unite#custom#source('codesearch', 'max_candidates', 30)
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#filters#sorter_default#use(['sorter_rank'])


" Plugin: UltiSnips {{{2 "
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" let g:UltiSnipsEditSplit="vertical"


" Plugin: MRU {{{2 "
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>
map <localleader>f :MRU<CR>

" Plugin: Denite {{{2 "
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
" noremap <leader>b :CtrlPBuffer<CR>
" let g:ctrlp_map = '<leader>e'
" let g:ctrlp_open_new_file = 'r'
" let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
" let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
"let g:ctrlp_use_caching = 1



" The Silver Searcher {{{2 "
if executable('ag')
  " set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --vimgrep'
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " CtrlSF.vim
  if has_key(g:plugs,'ctrlsf.vim')
    let g:ctrlsf_ackprg = 'ag'
    let g:ctrlp_use_caching = 0
    let g:gitgutter_grep_command = 'ag'
  endif
endif

" Plugin: Tagbar {{{2 "
nmap <silent> <F4> :TagbarToggle<CR>
map <m-\> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Plugin: IndentLine {{{2 "
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1


" Plugin: NERDTree {{{2 "
" let g:NERDTreeWinPos = "right"
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>


" Plugin: vim-multiple-cursors {{{2 "
" let g:multi_cursor_use_default_mapping=0
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'
" let g:multi_cursor_start_key='<F7>'

" Plugin: surround.vim {{{2 "
" Annotate strings with gettext http://amix.dk/blog/post/19678
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if 0
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
endif

" Plugin: Goyo {{{2 "
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

" goyo.vim + limelight.vim
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

function! s:goyo_enter()
  if has('gui_running')
    set fullscreen
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  Limelight
  let &l:statusline = '%M'
  hi StatusLine ctermfg=red guifg=red cterm=NONE gui=NONE
endfunction

function! s:goyo_leave()
  if has('gui_running')
    set nofullscreen
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" Plugin: GitGutter {{{2 "
let g:gitgutter_enabled=1
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
nnoremap <silent> <Leader>tgg :GitGutterToggle<cr>



" Plugin: vim-airline {{{2 "
let g:airline_theme='sol'
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
if !exists('g:airline_powerline_fonts') ||
      \ g:airline_powerline_fonts == 0
  let g:airline#extensions#tabline#left_sep = ''
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
else "if 0
  " let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  " powerline symbols
  " let g:airline_left_sep = ''
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  " let g:airline_right_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  " let g:airline_symbols.linenr = ''
  let g:airline_symbols.linenr = '☰'
  " let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.maxlinenr = ''
endif


" Plugin: Tabularize {{{2 "
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

" Plugin: vim-easy-align {{{2 "
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
xmap <Leader><Leader>a <Plug>(LiveEasyAlign)
nmap <Leader><Leader>a <Plug>(LiveEasyAlign)
" inoremap <silent> => =><Esc>mzvip:EasyAlign/=>/<CR>`z$a<Space>

" Plugin: VIM-TEX {{{2 "
let g:tex_flavor='latex'
au filetype tex setlocal iskeyword+=:
if has('mac') || has('macunix')
  " let g:vimtex_view_method='zathura'
  let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '-r @line @pdf @tex'
elseif LINUX()
  " let g:vimtex_view_method='zathura'
endif
let g:vimtex_fold_enabled = 1 "So large files can open more easily
let g:vimtex_latexmk_continuous=0

" Plugin: Nerdcommenter {{{2 "
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'both'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

nmap <leader>c<leader> <Plug>NERDCommenterToggle
xmap <leader>c<leader> <Plug>NERDCommenterToggle
nmap <a-?> <Plug>NERDCommenterAppend
imap <a-?> <C-o><Plug>NERDCommenterAppend
nmap <a-/> <Plug>NERDCommenterToggle
xmap <a-/> <Plug>NERDCommenterToggle
imap <a-/> <C-o><Plug>NERDCommenterToggle
" map for osx, set option->meta
" nmap ÷ <Plug>NERDCommenterToggle
" xmap ÷ <Plug>NERDCommenterToggle
" imap ÷ <C-o><Plug>NERDCommenterToggle
nmap <leader>cp <Plug>NERDCommenterYank<Esc>p
nmap <leader>cP <Plug>NERDCommenterYank<Esc>P

" Plugin: Vim-Markdown {{{2 "
let g:vim_markdown_conceal = 1
let g:vim_markdown_fenced_languages = ['csharp=cs', 'c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
" let g:vim_markdown_new_list_item_indent = 2

try
  let g:pandoc#filetypes#pandoc_markdown = 1
  let g:pandoc#spell#enabled = 0
  " let g:pandoc#after#modules#enabled = ["nrrwrgn", "ultisnips"]
catch
  echomsg "pandoc may not be loaded"
endtry

" Plugin: MarkdownPreview {{{3 "
if OSX()
  let g:mkdp_path_to_chrome = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"
endif
let g:mkdp_auto_start = 0
let g:mkdp_auto_open = 0
" set to 1, the vim will auto open preview window when you edit the
" markdown file
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 1
let g:mkdp_command_for_global = 0

" Markdown instant preview {{{3 "
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0

" Plugin: python-mode {{{2 "
if get(g:,'load_python_mode')
  let g:pymode_lint_checkers = ['pyflakes']
  let g:pymode_trim_whitespaces = 0
  let g:pymode_options = 0
  let g:pymode_rope = 0"
endif
" Plugin: xolox/vim-lua-inspect {{{2 "
" Don't enable the lua-inspect plug-in automatically in Lua buffers.
let g:lua_inspect_events = ''
"
" " Enable/disable the lua-inspect plug-in manually using <F6>.
imap <F6> <C-o>:LuaInspectToggle<CR>
nmap <F6>      :LuaInspectToggle<CR>

" Plugin: AutoPairs {{{2 "

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


" Plugin: DelimitMate {{{2 "
let delimitMate_expand_cr            = 1
let delimitMate_expand_space         = 1
let delimitMate_expand_inside_quotes = 1
let delimitMate_jump_expansion       = 1

" Plugin: vim-sayonara {{{2 "
nnoremap <silent><leader>x  :Sayonara<cr>
nnoremap <silent><leader>X  :Sayonara!<cr>

let g:sayonara_confirm_quit = 0

" Plugin: vim-online-thesaurus {{{2
" nnoremap <leader>k :OnlineThesaurusCurrentWord<cr>
" nnoremap <leader>K :Thesaurus<space>

" Plugin: Asyncrun.vim {{{2 "
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

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

" Plugin: vim-after-object {{{2
silent! if has_key(g:plugs, 'vim-after-object')
  autocmd VimEnter * silent! call after_object#enable('=', ':', '#', ' ', '|')
endif

" ----------------------------------------------------------------------------
" ?ie | entire object {{{3
" ----------------------------------------------------------------------------
xnoremap <silent> ie gg0oG$
onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>

" ----------------------------------------------------------------------------
" ?il | inner line {{{3
" ----------------------------------------------------------------------------
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<CR>



" Plugin: vim-emoji :dog: :cat: :rabbit:! {{{2
" ----------------------------------------------------------------------------
command! -range EmojiReplace <line1>,<line2>s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

" Plugins' configuration }}}1

" vim: set et sw=2 ts=2 tw=78 foldmethod=marker foldlevel=1:
