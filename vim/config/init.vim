
" pre configuration before loading plugins {{{
" ============================================

let g:python_host_prog='/Users/ada/anaconda/envs/py27/bin/python'
let g:python3_host_prog='/Users/ada/anaconda/bin/python'

" Dein packages manager core {{{
" ------------------

let s:path = exists('g:vimpath') ? g:vimpath : "~/.vim"
let s:bundlepath = exists('g:bundlepath') ? g:bundlepath : s:path . "/dein"
let s:deinpath =  s:bundlepath . '/repos/github.com/Shougo/dein.vim'


if has('vim_starting')
  set nocompatible               " Be iMproved
endif

exec 'set runtimepath+=' . s:deinpath

let neobundle_readme=expand(s:deinpath . '/README.md')

if !filereadable(neobundle_readme)
  echo "Installing NeoBundle..."
  echo "mkdir " . s:deinpath
  exec 'silent !mkdir -p ' . s:deinpath
  echo "install dein"
  exec 'silent !git clone https://github.com/Shougo/dein.vim ' . s:deinpath
  " let g:not_finsh_neobundle = "yes"
endif

" }}}

" }}}


" Load plugins {{{
" ================


" Required:
"
" echo 'check state'
if dein#load_state(s:bundlepath)
    " echo 'load state from ' . s:bundlepath

" Let NeoBundle manage NeoBundle
" Required:
" NeoBundleFetch 'Shougo/neobundle.vim'
call dein#begin(s:deinpath)

"" NeoBundle install packages

call dein#add('scrooloose/nerdtree')
" call dein#add('jistr/vim-nerdtree-tabs.git')
call dein#add('tpope/vim-commentary')
call dein#add('scrooloose/nerdcommenter')

call dein#add('tpope/vim-fugitive')
call dein#add('mhinz/vim-signify')
" call dein#add('airblade/vim-gitgutter')


" call dein#add('sheerun/vim-polyglot')  " A collection of language packs for Vim.
call dein#add('vim-scripts/grep.vim')
" call dein#add('vim-scripts/CSApprox')  " makes GVim-only colorschemes Just Work in terminal Vim
call dein#add('bronson/vim-trailing-whitespace')
call dein#add('majutsushi/tagbar')
call dein#add('vim-scripts/taglist.vim')

" call dein#add('scrooloose/syntastic')
call dein#add("Yggdroot/indentLine")
call dein#add('jiangmiao/auto-pairs')
" call dein#add('Raimondi/delimitMate')

"" Vim-Session
call dein#add('xolox/vim-misc')
call dein#add('xolox/vim-session')


"" Snippets
call dein#add('SirVer/ultisnips')

call dein#add('honza/vim-snippets')

"" Color
call dein#add('tomasr/molokai')
call dein#add('roosta/srcery')
call dein#add('rakr/vim-one')
" call dein#add('jethrovt/vim-basal-colorscheme')
call dein#add('lucy/term.vim')
call dein#add('vim-scripts/Visual-Studio')
call dein#add('cohlin/vim-colorschemes')
call dein#add('altercation/vim-colors-solarized')
call dein#add('vim-scripts/mayansmoke')
call dein#add('nightsense/seabird')
call dein#add('morhetz/gruvbox')
call dein#add('gregsexton/Muon')

"" Custom bundles
"" Python Bundle
" call dein#add("davidhalter/jedi-vim")

"" Lua Bundle
call dein#add('xolox/vim-lua-ftplugin')
call dein#add('xolox/vim-lua-inspect')

" C Language
call dein#add('vim-scripts/c.vim')

"" latex bundle
call dein#add('vim-latex/vim-latex')
call dein#add('lervag/vimtex')

"" Markdown
"Bundle 'tpope/vim-markdown'
call dein#add('godlygeek/tabular') " Needed by vim-markdown
call dein#add('plasticboy/vim-markdown')
call dein#add('suan/vim-instant-markdown')
call dein#add('mzlogin/vim-markdown-toc')

" HTML
" call dein#add('amirh/HTML-AutoCloseTag')
" call dein#add('hail2u/vim-css3-syntax')
" call dein#add('gorodinskiy/vim-coloresque')
" call dein#add('tpope/vim-haml')
call dein#add('mattn/emmet-vim')

"" Auto Complete"
call dein#add('neitanod/vim-clevertab')
let g:use_clevertab=1
" call dein#add('ervandew/supertab')
call dein#add('Shougo/neocomplete.vim')
" call dein#add('valloric/youcompleteme')



"" Misc
" call dein#add('kana/vim-narrow')
" call dein#add('junegunn/vim-peekaboo')
" call dein#add('junegunn/goyo')
call dein#add('vim-scripts/mru.vim')
call dein#add('vim-voom/VOoM')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('tpope/vim-surround')
call dein#add('rking/ag.vim')
call dein#add('easymotion/vim-easymotion')
call dein#add('junegunn/vim-easy-align')
call dein#add('Shougo/unite.vim')
call dein#add('tsukkee/unite-tag')
call dein#add('Shougo/unite-outline')
call dein#add('dyng/ctrlsf.vim')
call dein#add('tmhedberg/matchit')
call dein#add('junegunn/fzf',  {'build': './install --all', 'rtp': ''})
call dein#add('junegunn/fzf.vim', {'depends': 'fzf'})
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('FelikZ/ctrlp-py-matcher')
" let g:airline#extensions#tabline#enabled = 1
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

if has('gui_running')  || 1
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
else
call dein#add('itchyny/lightline.vim')
endif

" call dein#add('Chiel92//vim-autoformat')
call dein#add('w0rp/ale')
let g:ale_emit_conflict_warnings = 0

call dein#end()
call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
if dein#check_install()
    call dein#install()
endif

"" ===================()()()((((()))))
" }}}
"

let g:session_autoload=0


" separator
"




" Plugins' configuration {{{
" ==========================

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

"  NeoComplete
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
" let g:neocomplete#sources#dictionary#dictionaries = {
"     \ 'default' : '',
"     \ 'vimshell' : $HOME.'/.vimshell_hist',
"     \ 'scheme' : $HOME.'/.gosh_completions'
"         \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

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
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
" set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" GEDI
let g:use_jedi = 1
if exists('g:use_jedi') && g:use_jedi
    let g:jedi#auto_vim_configuration = 0
    " let g:neocomplete#force_omni_input_patterns.python = '' " '[^. \t]\.\w*'
    let g:neocomplete#sources#omni#input_patterns.python = '' " '[^. \t]\.\w*'

    "au FileType python setlocal completeopt -=previewwindow
    au FileType python setlocal omnifunc=jedi#completions

    let g:jedi#popup_on_dot = 1
    let g:jedi#popup_select_first = 0

    " jedi-vim
    let g:jedi#goto_assignments_command = "<leader>g"
    let g:jedi#goto_definitions_command = "<leader>d"
    let g:jedi#documentation_command = "K"
    let g:jedi#usages_command = "<leader>n"
    let g:jedi#rename_command = "<leader>r"
    let g:jedi#show_call_signatures = "0"
    let g:jedi#completions_command = "<C-Space>"
    let g:jedi#smart_auto_mappings = 0
endif

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-P> <Plug>yankstack_substitute_newer_paste


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

" let g:ctrlp_map = '<c-f>'
map <leader>j :CtrlP<cr>
map <c-b>b :CtrlPBuffer<cr>
map <c-b>g :CtrlPBufTag<cr>
map <c-b>t :CtrlPTag<cr>
map <c-b>m :CtrlPMRUFiles<cr>
map <c-b>f :CtrlPCurFile<cr>

let g:ctrlp_max_height = 20
" let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'


" ctrlp.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 1

" CtrlSF.vim
let g:ctrlsf_ackprg = 'ag'

""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" noremap <leader>b :CtrlPBuffer<CR>
" let g:ctrlp_map = '<leader>e'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'




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
func! SyntasticCheckCoffeescript()
    let l:filename = substitute(expand("%:p"), '\(\w\+\)\.coffee', '.coffee.\1.js', '')
    execute "tabedit " . l:filename
    execute "SyntasticCheck"
    execute "Errors"
endfunc
nnoremap <silent> <leader>l :call SyntasticCheckCoffeescript()<cr>

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>



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

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts=1

" airline
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" if !exists('g:airline_powerline_fonts')
  " let g:airline#extensions#tabline#left_sep = ' '
  " let g:airline#extensions#tabline#left_alt_sep = '|'
  " let g:airline_left_sep          = '▶'
  " let g:airline_left_alt_sep      = '»'
  " let g:airline_right_sep         = '◀'
  " let g:airline_right_alt_sep     = '«'
  " let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  " let g:airline#extensions#readonly#symbol   = '⊘'
  " let g:airline#extensions#linecolumn#prefix = '¶'
  " let g:airline#extensions#paste#symbol      = 'ρ'
  " let g:airline_symbols.linenr    = '␊'
  " let g:airline_symbols.branch    = '⎇'
  " let g:airline_symbols.paste     = 'ρ'
  " let g:airline_symbols.paste     = 'Þ'
  " let g:airline_symbols.paste     = '∥'
  " let g:airline_symbols.whitespace = 'Ξ'
" else
  " let g:airline#extensions#tabline#left_sep = ''
  " let g:airline#extensions#tabline#left_alt_sep = ''

  " " powerline symbols
  " let g:airline_left_sep = ''
  " let g:airline_left_alt_sep = ''
  " let g:airline_right_sep = ''
  " let g:airline_right_alt_sep = ''
  " let g:airline_symbols.branch = ''
  " let g:airline_symbols.readonly = ''
  " let g:airline_symbols.linenr = ''
" endif


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

nmap <a-/> <Plug>NERDCommenterToggle
xmap <a-/> <Plug>NERDCommenterToggle
imap <a-/> <C-o><Plug>NERDCommenterToggle
nmap ÷ <Plug>NERDCommenterToggle
xmap ÷ <Plug>NERDCommenterToggle
imap ÷ <C-o><Plug>NERDCommenterToggle


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CleverTab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('g:use_clevertab') && g:use_clevertab
    inoremap <silent><tab> <c-r>=CleverTab#Complete('start')<cr>
                \<c-r>=CleverTab#Complete('tab')<cr>
                \<c-r>=CleverTab#Complete('ultisnips')<cr>
                \<c-r>=CleverTab#Complete('keyword')<cr>
                \<c-r>=CleverTab#Complete('neocomplete')<cr>
                \<c-r>=CleverTab#Complete('omni')<cr>
                \<c-r>=CleverTab#Complete('stop')<cr>
    inoremap <silent><s-tab> <c-r>=CleverTab#Complete('prev')<cr>
endif

let g:SuperTabDefaultCompletionType = "<c-n>"

" Markdown
" let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['csharp=cs','c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
" let g:vim_markdown_new_list_item_indent = 2

" Markdown instant preview
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0


" LUA: xolox/vim-lua-inspect
" Don't enable the lua-inspect plug-in automatically in Lua buffers.
let g:lua_inspect_events = ''
"
" " Enable/disable the lua-inspect plug-in manually using <F6>.
imap <F6> <C-o>:LuaInspectToggle<CR>
nmap <F6>      :LuaInspectToggle<CR>"


let s:path = expand('<sfile>:p:h')

exec 'source' . s:path .'/basic.vim'
exec 'source' . s:path .'/filetypes.vim'
exec 'source' . s:path .'/maps.vim'
exec 'source' . s:path .'/extended.vim'


" vim: set tw=78 foldmethod=marker foldlevel=0:n
