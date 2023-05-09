" vim: set ft=vim sw=2 ts=2 et foldmethod=marker:

set fo+=j

let g:snips_author    = "Chuancai Gu"
let g:snips_author_cn = "谷传才"
let g:snips_email     = "gucc.gu@gmail.com"
let g:snips_github    = "https://github.com/soaringfish"

set foldlevel=9
let g:SimpylFold_docstring_preview = 1

" Vim-pinyin-search
let g:PinyinSearch_Dict = $HOME . '/.vim/plug/vim-PinyinSearch/PinyinSearch.dict'
map <leader>/ :call PinyinSearch()<cr>

augroup myvim
  au!
augroup END

augroup myvim
  " lua type
  au filetype lua iab <buffer> pp print()<left><C-o>
  au filetype lua iab <buffer> pps print('')<left><left><C-o>
  au filetype lua iab <buffer> tins table.insert()<left><left><C-o>
  au filetype lua iab <buffer> trem table.remove()<left><left><C-o>
  au filetype lua iab <buffer> tcon table.concat()<left><left><C-o>
  au filetype lua iab <buffer> tsrt table.sort()<left><left><C-o>
augroup END

function! s:md_maps()
    " inoremap <buffer> `a \alpha
    " inoremap <buffer> `b \beta
    " inoremap <buffer> `g \gamma
"     set spell
endfunction

augroup myvim
  au filetype markdown call s:md_maps()
augroup END

augroup myvim
  au FileType mru map <esc> q
augroup END

inoremap <A-;> <C-o>:
" osx <a-;>
inoremap … <C-o>:
noremap … :

function! s:get_makefile_dir()

endfunction

function! Pdc2Pdf()
  update
  AsyncRun ~/bin/pdclecture % -o %<.pdf
endfunction

function! Pdc2Docx()
  update
  exec '!pandoc --from=markdown --to=docx  % --output %<.docx'
endfunction

function! Run_script()
    if &filetype =~ '\v(markdown)|(pandoc)'
        " execute '!make -C ../'
        call Pdc2Pdf()
    elseif &filetype == 'tex'
      normal ;ll
      normal ;lv
"         silent execute 'normal ;ll'
"         silent execute 'normal ;lv'
    elseif &filetype == 'python'
      exec '!python %'
      " AsyncRun python %
    else
        echom "Unknown build method for:" &filetype
    endif
endfunction

" noremap <m-b> <c-b>
" noremap <m-f> <c-f>
" noremap <c-x>b :w<cr>:call Run_script()<cr>
noremap <m-B> :w<cr>:call Run_script()<cr>
inoremap <c-x><c-b> <esc>:w<cr>:call Run_script()<cr>
inoremap <m-B> <esc>:w<cr>:call Run_script()<cr>

" replaced by fcitx.vim
" set noimdisable
" autocmd! InsertLeave * set imdisable|set iminsert=0
" autocmd! InsertEnter * set noimdisable|set iminsert=0


augroup myvim
  " latexSurround
  autocmd FileType tex call s:latexSurround()
  autocmd FileType markdown,pandoc call s:markdownSurround()
augroup END

function! s:latexSurround()
  " let b:surround_{char2nr("e")}
        " \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
  let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
  let b:surround_{char2nr("b")} = "\\textbf{\r}"
  let b:surround_{char2nr("i")} = "\\textit{\r}"
  let b:surround_{char2nr("e")} = "\\emph{\r}"
  let b:surround_{char2nr("m")} = "\\textbf{\\textit{\r}}"

  nmap <buffer> ,b ysiwb
  nmap <buffer> ,e ysiwe
  nmap <buffer> ,i ysiwi
  vmap <buffer> ,b Sb
  vmap <buffer> ,e Se
  vmap <buffer> ,i Si

  setlocal sw=2
endfunction

function! s:markdownSurround()
  let b:surround_{char2nr("1")} = "# \r #"
  let b:surround_{char2nr("2")} = "## \r ##"
  let b:surround_{char2nr("3")} = "### \r ###"
  let b:surround_{char2nr("4")} = "#### \r ####"

  let b:surround_{char2nr("e")} = "*\r* "
  let b:surround_{char2nr("b")} = "**\r** "

  hi Title cterm=bold
  hi Conceal ctermfg=9

  execute  'syn match pandocAtxStart /#\@1<!##\@1!/ contained containedin=pandocAtxHeaderMark conceal cchar=☰'
  execute  'syn match pandocAtxStart /#\@1<!###\@1!/ contained containedin=pandocAtxHeaderMark conceal cchar=※'
  execute  'syn match pandocAtxStart /#\@1<!####\@1!/ contained containedin=pandocAtxHeaderMark conceal cchar=▣'
  execute  'syn match pandocAtxStart /#\@1<!#####\@1!/ contained containedin=pandocAtxHeaderMark conceal cchar=✠'
 " =■◆¶'※

 " let g:table_mode_corner = '+'
 let g:table_mode_corner = '|'

endfunction

" VIMTEX settings {{{1
" ===================
" let g:vimtex_disable_recursive_main_file_detection=0
let g:vimtex_fold_enabled = 0

" let g:vimtex_toc_refresh_always = 0
" augroup vimtex
"   autocmd!
"   autocmd BufWritePost *.tex call vimtex#toc#refresh()
" augroup END

if has('nvim') && executable('nvr')
  let g:vimtex_compiler_progname='nvr'
endif

let g:vimtex_compiler_latexmk = {
      \ 'background' : 1,
      \ 'build_dir' : 'build',
      \ 'callback' : 1,
      \ 'continuous' : 0,
      \ 'executable' : 'latexmk',
      \ 'options' : [
      \   '-xelatex',
      \   '-pdf',
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ],
      \}
" let g:vimtex_view_enabled=1
" autocmd FileType tex let b:vimtex_main = 'main.tex'
if OSX()
  " let g:vimtex_view_method='zathura'
  " let g:vimtex_view_method = 'mupdf'
  " let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  " let g:vimtex_view_general_options = '-r @line @pdf @tex'
elseif LINUX()
  if executable('zathura')
    let g:vimtex_view_method='zathura'
  elseif executable('okular')
    " let g:vimtex_view_method='okular'
    let g:vimtex_view_general_viewer = 'okular'
    let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
    let g:vimtex_view_general_options_latexmk = '--unique'
  endif
  " let g:vimtex_view_general_viewer = 'okular'
  " let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
  " let g:vimtex_view_general_options_latexmk = '--unique'
elseif WINDOWS()
  " let g:vimtex_view_general_viewer = 'SumatraPDF'
  " let g:vimtex_view_general_options
        " \ = '-reuse-instance -forward-search @tex @line @pdf'
  " let g:vimtex_view_general_options_latexmk = '-reuse-instance'
else
  echo 'Unknown OS'
endif
" map \v :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf<CR>
" VIMTEX settings }}}1

" Jump out pairs
" inoremap
"
"
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><leader>l <Plug>(easymotion-lineforward)
map <Leader><leader>. <Plug>(easymotion-repeat)
map <Leader><leader>S <Plug>(easymotion-s2)
nmap sh <Plug>(easymotion-linebackward)
nmap sl <Plug>(easymotion-lineforward)
nmap s. <Plug>(easymotion-repeat)
nmap s <Plug>(easymotion-prefix)
nmap S <Plug>(easymotion-s2)

iab ,.s <esc>3a<c-v>{<esc>
iab ,.e <esc>3a<c-v>}<esc>
iab ,s <esc>3a<c-v>{<esc>,1Vj,ccj
iab ,,s <esc>3a<c-v>{<esc>,2Vj,ccj
iab ,e <esc>mz[zyy`zp:s/{{{/}}}/<cr>

function! s:vimtex_refresh(type)
  " echom a:type
  if and(a:type,1)
    call vimtex#toc#refresh()
    " echom "toc update"
  endif
  if and(a:type,2)
    call vimtex#labels#refresh()
    " echom "labels update"
  endif
endfunction

function! s:vimtex_outline(type, refresh, denite)
  if a:refresh
    call <SID>vimtex_refresh(a:type)
  endif
  if a:denite
    if a:type==1
      execute "Denite vimtex_toc"
    else
      execute "Denite vimtex_labels"
    endif
  else
    if a:type==1
      execute "VimtexTocOpen"
    else
      execute "VimtexLabelsOpen"
    endif
  endif
endfunction

" MARKDOWN-MAPS {{{1 "
augroup myvim
  " ft_maps
  if get(g:, "usecommaleader")
    " au FileType tex echo 'filetype-tex'. b:vimtex.compiler.build_dir
    " au BufReadPre *.tex echo 'pre:'. b:vimtex.compiler.build_dir
    " au BufRead *.tex echo 'read:'. b:vimtex.compiler.build_dir
    " au BufReadPost *.tex echo 'post:'. b:vimtex.compiler.build_dir
    au FileType tex
          \ map <buffer> ,v <localleader>lv|
          \ map <buffer> ,m <localleader>ll|
          \ nnoremap <buffer> <localleader>lf :call <SID>vimtex_refresh(3)<cr>|
          \ nnoremap <buffer> <localleader>o :call <SID>vimtex_outline(1,0,1)<cr>|
          \ nnoremap <buffer> <localleader><localleader>o :call <SID>vimtex_outline(1,1,1)<cr>|
          \ nnoremap <buffer> <localleader>t :VimtexTocOpen<cr>|
          \ nnoremap <buffer> <localleader><localleader>t :call <SID>vimtex_outline(1,1,0)<cr>|
          \ nnoremap <buffer> <localleader>y :<c-u>Denite vimtex_labels<cr>|
          \ nnoremap <buffer> <localleader><localleader>y :<c-u>call <SID>vimtex_outline(2,1,1)<cr>

    au FileType pandoc
          \ map <buffer> ,b <localleader>biw|
          \ map <buffer> ,i <localleader>iiw|
          \ map <buffer> ,` <localleader>`iw|
          \ map <buffer> ,_ <localleader>_iw|
          \ map <buffer> ,^ <localleader>^iw|
          \ map <buffer> ,] <localleader>hsn|
          \ map <buffer> ,[ <localleader>hsb|
          \ map <buffer> ,cf <localleader>hcf|
          \ map <buffer> ,cl <localleader>hcl|
          \ map <buffer> ,cn <localleader>hcn|
          \ map <buffer> ,h <localleader>hh|
          \ map <buffer> ,p <localleader>hp|
          \ imap <buffer> <c-x>b <c-c><localleader>biwa|
          \ imap <buffer> <c-x>i <c-c><localleader>iiwa|
          \ imap <buffer> <c-x>` <c-c><localleader>`iwa|
          \ imap <buffer> <c-x>_ <c-c><localleader>_iwa|
          \ imap <buffer> <c-x>^ <c-c><localleader>^iwa|
          \ imap <buffer> <c-x>] <c-c><localleader>hsna|
          \ imap <buffer> <c-x>[ <c-c><localleader>hsba|
          \ imap <buffer> <c-x>cf <c-c><localleader>hcfa|
          \ imap <buffer> <c-x>cl <c-c><localleader>hcla|
          \ imap <buffer> <c-x>cn <c-c><localleader>hcna|
          \ imap <buffer> <c-x>h <c-c><localleader>hha|
          \ imap <buffer> <c-x>p <c-c><localleader>hpa
  endif

  au FileType pandoc hi clear pandocStrong
  au FileType pandoc hi link pandocStrong markdownBold
  au FileType pandoc hi clear pandocEmphasis
  au FileType pandoc hi link pandocEmphasis markdownItalic
  au FileType pandoc hi clear pandocStrongEmphasis
  au FileType pandoc hi link pandocStrongEmphasis texBoldItalStyle
  au FileType pandoc hi clear pandocStrongInEmphasis
  au FileType pandoc hi link pandocStrongInEmphasis texBoldItalStyle
  au FileType pandoc hi clear pandocEmphasisInStrong
  au FileType pandoc hi link pandocEmphasisInStrong texBoldItalStyle

augroup END
" }}}1 MARKDOWN-MAPS "

" VIMTEX-MAPS {{{1 "
augroup myvim
  " vimtex_map
  if get(g:, "usecommaleader")
    au FileType tex
          \ map <buffer> ,l <localleader>ll|
          \ map <buffer> ,v <localleader>lv
  endif
augroup END
" }}}1 VIMTEX-MAPS "

" Leaderf Config {{{1 "
"
map ;j :LeaderfBufTag<cr>
let g:Lf_ShortcutF = '<C-P>'
" }}}1 "

"" FZF {{{1
" =======
" map <c-p> :<c-u>FZF<cr>
map <a-o> :<c-u>FZF<cr>
map <leader>jf :<c-u>FZF .<cr>
map <leader>jg :<c-u>GFiles<cr>
map <leader>jG :<c-u>GFiles!?<cr>
map <leader>js :<c-u>GFiles!?<cr>
map <leader>jl :<c-u>Lines<cr>
map <leader>jL :<c-u>BLines<cr>
map <leader>jb :<c-u>Buffers<cr>
map <leader>jw :<c-u>Windows<cr>
inoremap <m-s> <c-o>:<c-u>Snippets<cr>
map <leader>jc :<c-u>Commits!<cr>
map <leader>jh :<c-u>Helptags<cr>
map <leader>jt :<c-u>Tags<cr>
map <leader>jT :<c-u>BTags<cr>
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
nnoremap <silent> q: :History:<CR>
nnoremap <silent> q/ :History/<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap ;; <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
" FZF }}}1

" colorscheme gruvbox
" colorscheme xcode-default
" AirlineTheme raven


" => new bindings {{{
" ===================
" Bind s/S
" => new bindings }}}

nmap ]a <plug>(ale_next)
nmap [a <plug>(ale_last)

map <localleader>e :<c-u>e <c-r>=expand("%:h")<cr>/
cmap ;; <c-r>=expand("%:h")<cr>/
cmap ,, <c-r>=expand("%:h")<cr>/../

" NERDTrees File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('html', 202, 'none', '#FC4709')
call NERDTreeHighlightFile('hbs',  202, 'none', '#FC4709')
call NERDTreeHighlightFile('jade', 149, 'none', '#A0D24D')
call NERDTreeHighlightFile('json', 223, 'none', '#FECEA0')
call NERDTreeHighlightFile('scss', 44,  'none', '#1AD0CE')
call NERDTreeHighlightFile('css',  44,  'none', '#1AD0CE')
call NERDTreeHighlightFile('js',   226, 'none', '#FFFF0D')
call NERDTreeHighlightFile('rb',   197, 'none', '#E53378')
call NERDTreeHighlightFile('md',   208, 'none', '#FD720A')
call NERDTreeHighlightFile('php',  140, 'none', '#9E6FCD')
call NERDTreeHighlightFile('svg',  178, 'none', '#CDA109')
call NERDTreeHighlightFile('gif',  36,  'none', '#15A274')
call NERDTreeHighlightFile('jpg',  36,  'none', '#15A274')
call NERDTreeHighlightFile('png',  36,  'none', '#15A274')
call NERDTreeHighlightFile('vim',  36,  'none', '#15A274')


" ALE gutter sign colors
hi ALEErrorSign ctermfg=203 ctermbg=237 guifg=#ff0000 guibg=#343d46
hi ALEWarningSign ctermfg=221 ctermbg=237 guifg=#fac863 guibg=#343d46

function! LoadPythonVirutalenv()
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
endfunction

function! DummyPythonEvn()
  " Add the virtualenv's site-packages to vim path
  if has('python')
    py << EOF
    import os.path
    import sys
    import vim
    if 'VIRTUAL_ENV' in os.environ:
      project_base_dir = os.environ['VIRTUAL_ENV']
      sys.path.insert(0, os.path.join(project_base_dir, 'lib', 'python%d.%d' % sys.version_info[:2], 'site-packages'))
EOF
  endif
endfunction

" let g:mcc=0

" function! Mycount()
"   let g:mcc = g:mcc+1
"   return g:mcc
" endfunction
" " set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{Mycount()}

" call PPythonSyncExt()

let g:onedark_terminal_italics = 1

function! PPythonSyncExt()
  " syn match pythonFunctionCall  '\<\h\w*\s*\%((\)\@=' contains=TOP nextgroup=pythonParameterList skipwhite
    syn region pythonParameterList matchgroup=pythonPL start=+\%(\<\h\w*\s*\)\@99<=(+  end=+)+ contains=ALL containedin=pythonParameterList,lv1,lv2,lv3,lv4,lv5,lv6,lv7,lv8,lv9 transparent
    syn match pythonParameterName '\%(\%(^\s*\|[(,]\)\s*\)\@<=\%(\<\h\w*\)\%(\s*=\)\@=' contained containedin=lv1,lv2,lv3,lv4,lv5,lv6,lv7,lv8,lv9,pythonParameterList
    "highlight def link pythonParameterList pythonDefine
    highlight def link pythonParameterName Label
    "highlight def link pythonFunction Function
endfunction

function! SwapBoolean()
let l:booleans = {'0':'1','1':'0','true':'false','false':'true','True':'False','False':'True','TRUE':'FALSE','FALSE':'TRUE'}
  let l:v = expand('<cword>')
  try
    let l:r = l:booleans[l:v]
    execute "normal ciw" . l:r ."\<ESC>"
  catch
    echo "Not a boolean value: " . l:v
  endtry
endfunction

imap <c-x>t <c-o>:call SwapBoolean()<cr>
nmap ,t :call SwapBoolean()<cr>

" let g:airline_section_z="%3p%% %#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%3v"
let g:airline_section_z="%2l%#__restore__#:%2v %{g:airline_right_alt_sep} %P"
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:pandoc#syntax#conceal#cchar_overrides = {
    \"newline": "↵",
    \"image": "▨",
    \"super": "ⁿ",
    \"sub": "ₙ",
    \"strike": "x̶",
    \"atx": "§",
    \"codelang": "λ",
    \"codeend": "—",
    \"abbrev": "→",
    \"footnote": "†",
    \"definition": "»",
    \"li": "▶",
                \"html_c_s": "‹",
                \"html_c_e": "›"}

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

function! EchoHello()
  echom 'echo hello invoked!'
endfunction

" autoupdate for terminal {{{1 "
" For autoread in terminal
" set updatetime=1000

if !has('gui_running')
  au FocusGained,BufEnter * checktime
  if !has('nvim')
    au FocusGained,BufEnter * let s:holded = 0
    " | echom "gained"
    au CursorHold,CursorHoldI * checktime | let s:holded = 1
    " |  echom "hold"
    au cursorMoved,CursorMovedI * call <SID>checkafterhold()
  endif
endif

let s:holded = 0
function! s:checkafterhold()
  if s:holded==1
    checktime
    let s:holded=0
    " echom "moved"
  endif
endfunction

" }}}1 "

" let g:notes_suffix = '.txt'
" let g:notes_directories = ['~/Documents/Notes']

" VimWik {{{1 "
let g:vimwiki_list = [
      \ {'path': '~/Documents/wiki/wiki',
      \ 'path_html': '~/Documents/wiki/html',
      \ 'syntax': 'markdown',
      \ 'ext': '.mkd',
      \ 'custom_wiki2html': 'misaka_md2html.py',
      \ 'diary_link_count': 5},
      \{'path': '~/Documents/vimwiki/wiki',
      \ 'path_html': '~/Documents/vimwiki/html',
      \ 'syntax': 'default',
      \ 'diary_link_count': 5},
      \ ]

augroup myvim
  " VIMWIKI
  au filetype vimwiki call s:vimwiki_settings()
  au BufNewFile *.mkd,*.wiki let b:new_file = 1
  " if &filetype=='vimwiki' | call setline(1,expand('%<')) | else | let b:new_file=1 | endif
augroup END

function! s:vimwiki_settings()
  map <Leader>w<space> <Plug>VimwikiToggleListItem
  if get(b:,'new_file',0)
    call setline(1,expand('%<'))
    " call setline(1,'% ' . expand('%<'))
    call setline(2,'')
    call setline(3,'')
    normal gg=G
    " normal G
    " let b:new_file=0
    unlet b:new_file
  endif
endfunction

" }}}1 "

" capticalize first letter
map gc :s/\v<(.)(\w*>)/\u\1\L\2/g<cr>:noh<cr>


augroup myvim
  " voom
  au filetype voomtree map <buffer> h k<cr>|map <buffer> l j<cr>
augroup END
let g:voom_ft_modes = {'markdown': 'markdown', 'tex': 'latex'}
map <leader>o :call <SID>voom_open()<cr>
function! s:voom_open()
  let l:ret=''
  if expand('%:e')=='mkd'
    let l:ret=execute('Voom markdown')
  else
    let l:ret=execute ('Voom ' . &ft)
  endif
  if match(l:ret, 'cannot') > -1
    execute 'Voom'
  endif
endfunction
" let g:voom_return_key = "<C-Return>"
" let g:voom_tab_key = "<C-Tab>"
map <localleader>vl :Voomunl<cr>

" let g:vimwiki_listsyms = '✗○◐●✓'
" let g:calendar_diary='~/Documents/vimwiki/wiki/diary/'

"cnfile colder cnewer g; g,

" use `noautocmd` to accelerate the macro execution
nnoremap <leader>@ :<c-u>noautocmd normal <C-r>=v:count?v:count:22<cr>@
xnoremap <leader>@ :<c-u>noautocmd '<,'> normal @
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" NOTE:
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" echom 'config scope ..'

" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
      try
        cs add cscope.out
      catch
      endtry
      " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
      try
        cs add $CSCOPE_DB
      catch
      endtry
    endif

    " show msg when any other cscope db added
    set cscopeverbose

    " cscope/vim key mappings

    " The following maps all invoke one of the following cscope search types:
    " 's'   symbol: find all references to the token under cursor
    " 'g'   global: find global definition(s) of the token under cursor
    " 'c'   calls:  find all calls to the function name under cursor
    " 't'   text:   find all instances of the text under cursor
    " 'e'   egrep:  egrep search for the word under cursor
    " 'f'   file:   open the filename under cursor
    " 'i'   includes: find files that include the filename under cursor
    " 'd'   called: find functions that function under cursor calls

    " The above maps can be called in three different ways.
    " 1) <C-\> + map:     open search result
    " 2) <C-\> + h + map: open search result in horizontal split
    " 3) <C-\> + v + map: open search result in vertical split

    " You can use CTRL-T to go back to where you were before the search.

    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>


    " Horizontal split, with search result displayed in the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    nmap <C-\>hs :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>hg :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>hc :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>ht :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>he :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>hf :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>hi :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>hd :scs find d <C-R>=expand("<cword>")<CR><CR>


    " Vertical split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-\>vs :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>vg :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>vc :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>vt :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>ve :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>vf :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>vi :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>vd :vert scs find d <C-R>=expand("<cword>")<CR><CR>

endif

" echom 'scope configed'

nmap <localleader>/ :%s/
vmap <localleader>/ :s/


function! GetFunctionName(lnum)
  let l:lnum = getpos('.')[1] + a:lnum
  let l:line = getline(l:lnum)
  return matchstr(l:line, '\v\w+\ze\s*\(')
endfunction

imap <a-'> <c-r>=GetFunctionName(1)<cr>
smap <a-'> <del><c-r>=GetFunctionName(1)<cr>
" Fold description {{{1 "
nmap <a-'> :call AddFunctionComment()<cr>

function! AddFunctionComment()
  execute "normal Ofold\<c-j>"
  execute "normal \<a-'>"
  normal f1
  "\<del>\<c-r>=GetFunctionName(1)\<cr>"
endfunction

function! XMLTagClose()
  return "</\<c-x>\<c-o>"
endfunction

augroup myvim
  " au FileType html,xml imap <buffer> <a-.> <c-r>=XMLTagClose()<cr><c-r>="\<tab>"<cr>
  au FileType html,xml imap <buffer> <a-.> </<c-x><c-o>
augroup END


function! s:plugopen(entry)
  " execute 'NERDTree ' expand(s:bundle_dir) .'/'. a:entry
  execute 'Dirvish' expand(s:bundle_dir) .'/'. a:entry
  execute 'lcd' expand('%')
  " execute 'lcd' expand(s:bundle_dir) .'/'. a:entry
endfunction

let s:bundle_dir = g:bundlepath
command! Plugins call fzf#run({
      \ 'source':  reverse(sort(map(globpath(s:bundle_dir, '*', 0, 1), 'fnamemodify(v:val, ":t")'))),
      \ 'sink':    function('<sid>plugopen'),
      \ 'options': '+m',
      \ 'left':    30
      \ })


" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>


" ----------------------------------------------------------------------------
" tmux {{{2
" ----------------------------------------------------------------------------
function! s:tmux_send(content, dest) range
  let dest = empty(a:dest) ? input('To which pane? ') : a:dest
  let tempfile = tempname()
  call writefile(split(a:content, "\n", 1), tempfile, 'b')
  call system(printf('tmux load-buffer -b vim-tmux %s \; paste-buffer -d -b vim-tmux -t %s',
        \ shellescape(tempfile), shellescape(dest)))
  call delete(tempfile)
endfunction

function! s:tmux_map(key, dest)
  execute printf('nnoremap <silent> %s "tyy:call <SID>tmux_send(@t, "%s")<cr>', a:key, a:dest)
  execute printf('xnoremap <silent> %s "ty:call <SID>tmux_send(@t, "%s")<cr>gv', a:key, a:dest)
endfunction

call s:tmux_map('<localleader>tt', '')
call s:tmux_map('<localleader>th', '.left')
call s:tmux_map('<localleader>tj', '.bottom')
call s:tmux_map('<localleader>tk', '.top')
call s:tmux_map('<localleader>tl', '.right')
call s:tmux_map('<localleader>ty', '.top-left')
call s:tmux_map('<localleader>to', '.top-right')
call s:tmux_map('<localleader>tn', '.bottom-left')
call s:tmux_map('<localleader>t.', '.bottom-right')


" SaveMacro / LoadMacro {{{2
" ----------------------------------------------------------------------------
function! s:save_macro(name, file)
  let content = eval('@'.a:name)
  if !empty(content)
    call writefile(split(content, "\n"), a:file)
    echom len(content) . " bytes save to ". a:file
  endif
endfunction
command! -nargs=* SaveMacro call <SID>save_macro(<f-args>)

function! s:load_macro(file, name)
  let data = join(readfile(a:file), "\n")
  call setreg(a:name, data, 'c')
  echom "Macro loaded to @". a:name
endfunction
command! -nargs=* LoadMacro call <SID>load_macro(<f-args>)


" ----------------------------------------------------------------------------
" :Shuffle | Shuffle selected lines {{{2
" ----------------------------------------------------------------------------
function! s:shuffle() range
ruby << RB
  first, last = %w[a:firstline a:lastline].map { |e| VIM::evaluate(e).to_i }
  (first..last).map { |l| $curbuf[l] }.shuffle.each_with_index do |line, i|
    $curbuf[first + i] = line
  end
RB
endfunction
command! -range Shuffle <line1>,<line2>call s:shuffle()


" :Chomp {{{2
" ----------------------------------------------------------------------------
command! Chomp %s/\s\+$// | normal! ``

" ----------------------------------------------------------------------------
" :Count {{{2
" ----------------------------------------------------------------------------
command! -nargs=1 Count execute printf('%%s/%s//gn', escape(<q-args>, '/')) | normal! ``


" :Root | Change directory to the root of the Git repository {{{2
" ----------------------------------------------------------------------------
function! s:root(curbase)
  " echom a:curbase
  if a:curbase
    execute 'lcd %:p:h'
  endif
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
command! -bang Root call s:root(<bang>1)


" HL | Find out syntax group {{{2
" ----------------------------------------------------------------------------
function! s:hl()
  " echo synIDattr(synID(line('.'), col('.'), 0), 'name')
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')
endfunction
command! HL call <SID>hl()


" :A {{{2
" ----------------------------------------------------------------------------
function! s:a(cmd)
  let name = expand('%:t:r')
  let ext = tolower(expand('%:e'))
  let sources = ['c', 'cc', 'cpp', 'cxx']
  let headers = ['h', 'hh', 'hpp', 'hxx']
  for pair in [[sources, headers], [headers, sources]]
    let [set1, set2] = pair
    if index(set1, ext) >= 0
      for h in set2
        let aname = name.'.'.h
        " for a in [aname, toupper(aname)]
          let f = findfile(aname)
          if filereadable(f)
            execute a:cmd f
            return
          else
            " echo 'Fiel not readable: ' f
          endif
        " endfor
      endfor
    endif
  endfor
  echo 'notfind ' . name
endfunction
command! A call s:a('e')
command! AV call s:a('botright vertical split')


" Todo {{{2
" ----------------------------------------------------------------------------
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
        \ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! GTodo call s:todo()

" ----------------------------------------------------------------------------
" Profile {{{2
" ----------------------------------------------------------------------------
function! s:profile(bang)
  if a:bang
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *
  endif
endfunction
command! -bang Profile call s:profile(<bang>0)

" ----------------------------------------------------------------------------
" Open FILENAME:LINE:COL {{{2
" ----------------------------------------------------------------------------
function! s:goto_line()
  let tokens = split(expand('%'), ':')
  if len(tokens) <= 1 || !filereadable(tokens[0])
    return
  endif

  let file = tokens[0]
  let rest = map(tokens[1:], 'str2nr(v:val)')
  let line = get(rest, 0, 1)
  let col  = get(rest, 1, 1)
  bd!
  silent execute 'e' file
  execute printf('normal! %dG%d|', line, col)
endfunction

autocmd myvim BufNewFile * nested call s:goto_line()


" ----------------------------------------------------------------------------
" co? : Toggle options (inspired by unimpaired.vim) {{{2
" ----------------------------------------------------------------------------
function! s:map_change_option(...)
  let [key, opt] = a:000[0:1]
  let op = get(a:, 3, 'set '.opt.'!')
  execute printf("nnoremap co%s :%s<bar>set %s?<cr>", key, op, opt)
endfunction

call s:map_change_option('p', 'paste')
call s:map_change_option('n', 'number')
call s:map_change_option('w', 'wrap')
call s:map_change_option('h', 'hlsearch')
call s:map_change_option('m', 'mouse', 'let &mouse = &mouse == "" ? "a" : ""')
call s:map_change_option('t', 'textwidth',
    \ 'let &textwidth = input("textwidth (". &textwidth ."): ")<bar>redraw')
call s:map_change_option('b', 'background',
    \ 'let &background = &background == "dark" ? "light" : "dark"<bar>redraw')

" ----------------------------------------------------------------------------
" <Leader>?/! | Google it / Feeling lucky {{{2
" ----------------------------------------------------------------------------
function! s:goog(pat, lucky)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?%sq=%s"',
                   \ a:lucky ? 'btnI&' : '', q))
endfunction

nnoremap <leader>? :call <SID>goog(expand("<cWORD>"), 0)<cr>
nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>
xnoremap <leader>? "gy:call <SID>goog(@g, 0)<cr>gv
xnoremap <leader>! "gy:call <SID>goog(@g, 1)<cr>gv


" TEXT OBJECTS {{{1
" ============================================================================

" ----------------------------------------------------------------------------
" Common {{{2
" ----------------------------------------------------------------------------
function! s:textobj_cancel()
  if v:operator == 'c'
    augroup textobj_undo_empty_change
      autocmd InsertLeave <buffer> execute 'normal! u'
            \| execute 'autocmd! textobj_undo_empty_change'
            \| execute 'augroup! textobj_undo_empty_change'
    augroup END
  endif
endfunction

noremap         <Plug>(TOC) <nop>
inoremap <expr> <Plug>(TOC) exists('#textobj_undo_empty_change')?"\<esc>":''

" ----------------------------------------------------------------------------
" ?ii / ?ai | indent-object
" ?io       | strictly-indent-object
" ----------------------------------------------------------------------------
function! s:indent_len(str)
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction

function! s:indent_object(op, skip_blank, b, e, bd, ed)
  let i = min([s:indent_len(getline(a:b)), s:indent_len(getline(a:e))])
  let x = line('$')
  let d = [a:b, a:e]

  if i == 0 && empty(getline(a:b)) && empty(getline(a:e))
    let [b, e] = [a:b, a:e]
    while b > 0 && e <= line('$')
      let b -= 1
      let e += 1
      let i = min(filter(map([b, e], 's:indent_len(getline(v:val))'), 'v:val != 0'))
      if i > 0
        break
      endif
    endwhile
  endif

  for triple in [[0, 'd[o] > 1', -1], [1, 'd[o] < x', +1]]
    let [o, ev, df] = triple

    while eval(ev)
      let line = getline(d[o] + df)
      let idt = s:indent_len(line)

      if eval('idt '.a:op.' i') && (a:skip_blank || !empty(line)) || (a:skip_blank && empty(line))
        let d[o] += df
      else | break | end
    endwhile
  endfor
  execute printf('normal! %dGV%dG', max([1, d[0] + a:bd]), min([x, d[1] + a:ed]))
endfunction
xnoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), 0, 0)<cr>
xnoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), -1, 1)<cr>
onoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), -1, 1)<cr>
xnoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line('.'), line('.'), 0, 0)<cr>

" ----------------------------------------------------------------------------
" <Leader>I/A | Prepend/Append to all adjacent lines with same indentation {{{2
" ----------------------------------------------------------------------------
nmap <silent> <leader>I ^vio<C-V>I
nmap <silent> <leader>A ^vio<C-V>$A

" ----------------------------------------------------------------------------
" ?i_ ?a_ ?i. ?a. ?i, ?a, ?i/ {{{2
" ----------------------------------------------------------------------------
function! s:between_the_chars(incll, inclr, char, vis)
  let cursor = col('.')
  let line   = getline('.')
  let before = line[0 : cursor - 1]
  let after  = line[cursor : -1]
  let [b, e] = [cursor, cursor]

  try
    let i = stridx(join(reverse(split(before, '\zs')), ''), a:char)
    if i < 0 | throw 'exit' | end
    let b = len(before) - i + (a:incll ? 0 : 1)

    let i = stridx(after, a:char)
    if i < 0 | throw 'exit' | end
    let e = cursor + i + 1 - (a:inclr ? 0 : 1)

    execute printf("normal! 0%dlhv0%dlh", b, e)
  catch 'exit'
    call s:textobj_cancel()
    if a:vis
      normal! gv
    endif
  finally
    " Cleanup command history
    if histget(':', -1) =~ '<SNR>[0-9_]*between_the_chars('
      call histdel(':', -1)
    endif
    echo
  endtry
endfunction

for [s:c, s:l] in items({'_': 0, '.': 0, ',': 0, '/': 1, '-': 0})
  execute printf("xmap <silent> i%s :<C-U>call <SID>between_the_chars(0,  0, '%s', 1)<CR><Plug>(TOC)", s:c, s:c)
  execute printf("omap <silent> i%s :<C-U>call <SID>between_the_chars(0,  0, '%s', 0)<CR><Plug>(TOC)", s:c, s:c)
  execute printf("xmap <silent> a%s :<C-U>call <SID>between_the_chars(%s, 1, '%s', 1)<CR><Plug>(TOC)", s:c, s:l, s:c)
  execute printf("omap <silent> a%s :<C-U>call <SID>between_the_chars(%s, 1, '%s', 0)<CR><Plug>(TOC)", s:c, s:l, s:c)
endfor

" ----------------------------------------------------------------------------
" ?ie | entire object {{{2
" ----------------------------------------------------------------------------
xnoremap <silent> ie gg0oG$
onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>

" ----------------------------------------------------------------------------
" ?il | inner line {{{2
" ----------------------------------------------------------------------------
xnoremap <silent> il <Esc>^vg_
onoremap <silent> il :<C-U>normal! ^vg_<CR>

" ----------------------------------------------------------------------------
" ?i# | inner comment {{{2
" ----------------------------------------------------------------------------
function! s:inner_comment(vis)
  if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
    call s:textobj_cancel()
    if a:vis
      normal! gv
    endif
    return
  endif

  let origin = line('.')
  let lines = []
  for dir in [-1, 1]
    let line = origin
    let line += dir
    let skip = 1
    while line >= 1 && line <= line('$')
      execute 'normal!' line.'G^'
      let synID = synIDattr(synID(line('.'), col('.'), 0), 'name')
      if synID !~? 'comment'
        if getline('.' ) !~ '^\s*$'
          break
        else
          let skip += 1
        endif
      else
        let skip = 1
      endif
      let line += dir
    endwhile
    let line -= dir * skip
    call add(lines, line)
  endfor

  execute 'normal!' lines[0].'GV'.lines[1].'G'
endfunction
xmap <silent> i# :<C-U>noautocmd call <SID>inner_comment(1)<CR><Plug>(TOC)
omap <silent> i# :<C-U>noautocmd call <SID>inner_comment(0)<CR><Plug>(TOC)

" ----------------------------------------------------------------------------
" ?ic / ?iC | Blockwise column object {{{2
" ----------------------------------------------------------------------------
function! s:inner_blockwise_column(vmode, cmd)
  if a:vmode == "\<C-V>"
    let [pvb, pve] = [getpos("'<"), getpos("'>")]
    normal! `z
  endif

  execute "normal! \<C-V>".a:cmd."o\<C-C>"
  let [line, col] = [line('.'), col('.')]
  let [cb, ce]    = [col("'<"), col("'>")]
  let [mn, mx]    = [line, line]

  for dir in [1, -1]
    let l = line + dir
    while line('.') > 1 && line('.') < line('$')
      execute "normal! ".l."G".col."|"
      execute "normal! v".a:cmd."\<C-C>"
      if cb != col("'<") || ce != col("'>")
        break
      endif
      let [mn, mx] = [min([line('.'), mn]), max([line('.'), mx])]
      let l += dir
    endwhile
  endfor

  execute printf("normal! %dG%d|\<C-V>%s%dG", mn, col, a:cmd, mx)

  if a:vmode == "\<C-V>"
    normal! o
    if pvb[1] < line('.') | execute "normal! ".pvb[1]."G" | endif
    if pvb[2] < col('.')  | execute "normal! ".pvb[2]."|" | endif
    normal! o
    if pve[1] > line('.') | execute "normal! ".pve[1]."G" | endif
    if pve[2] > col('.')  | execute "normal! ".pve[2]."|" | endif
  endif
endfunction

xnoremap <silent> ic mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'iw')<CR>
xnoremap <silent> iC mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'iW')<CR>
xnoremap <silent> ac mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'aw')<CR>
xnoremap <silent> aC mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'aW')<CR>
onoremap <silent> ic :<C-U>call   <SID>inner_blockwise_column('',           'iw')<CR>
onoremap <silent> iC :<C-U>call   <SID>inner_blockwise_column('',           'iW')<CR>
onoremap <silent> ac :<C-U>call   <SID>inner_blockwise_column('',           'aw')<CR>
onoremap <silent> aC :<C-U>call   <SID>inner_blockwise_column('',           'aW')<CR>

" ----------------------------------------------------------------------------
" ?i<shift>-` | Inside ``` block {{{2
" ----------------------------------------------------------------------------
xnoremap <silent> i~ g_?^\s*```<cr>jo/^\s*```<cr>kV:<c-u>nohl<cr>gv
xnoremap <silent> a~ g_?^\s*```<cr>o/^\s*```<cr>V:<c-u>nohl<cr>gv
onoremap <silent> i~ :<C-U>execute "normal vi~"<cr>
onoremap <silent> a~ :<C-U>execute "normal va~"<cr>


" }}}
" ============================================================================


" Statusline {{{1
command! -bar ToggleStatusline let b:stl_location  = !get(b:, 'stl_location')
command! -bar ToggleHighlight  let b:stl_highlight = !get(b:, 'stl_highlight')

nnoremap <silent><f10> :ToggleStatusline<cr>
nnoremap <silent><f11> :ToggleHighlight<cr>

" set statusline=%!SetStatusline()

function! SetStatusline()
  let stl = ' %4*%<%f%*'

  if exists('b:git_dir')
    let stl    .= '%3*:%*'
    let branch  = fugitive#head(8)
    let stl    .= (branch == 'master') ? '%1*master%*' : '%2*'. branch .'%*'
    " let stl    .= mhi#sy_stats_wrapper()
  endif

  let stl .= '%m%r%h%w '

  " right side
  let stl .=
        \   '%= '
        \ . '%#ErrorMsg#%{&paste ? " paste " : ""}%*'
        \ . '%#WarningMsg#%{&ff != "unix" ? " ".&ff." ":""}%* '
        \ . '%#warningmsg#%{&fenc != "utf-8" && &fenc != "" ? " ".&fenc." " :""}%* '

  if get(b:, 'stl_highlight')
    let id = synID(line('.'), col('.'), 1)
    let stl .=
          \   '%#WarningMsg#['
          \ . '%{synIDattr('.id.',"name")} as '
          \ . '%{synIDattr(synIDtrans('.id.'),"name")}'
          \ . ']%* '
  endif

  if get(b:, 'stl_location')
    let stl .=
          \   '%3*[%*%v%3*,%*%l%3*/%*%L%3*]%* '
          \ . '%p%3*%%%* '
  endif

  return stl
endfunction
" }}}1

let g:ycm_global_ycm_extra_conf = '~/.vim/plug/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 1
let g:ycm_extra_conf_globlist = ['~/Documents/workspace/*']


autocmd vimrc FileType c,cpp,go nnoremap <buffer> ]d :YcmCompleter GoTo<CR>
autocmd vimrc FileType c,cpp    nnoremap <buffer> K  :YcmCompleter GetType<CR>

augroup myvim
  let g:xml_syntax_folding = 1
  au filetype xml setlocal foldmethod=syntax
augroup END
let g:airline#extensions#ale#enabled = 1
" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0


function! Local_iab(iab)
  " let l:file = (a:iab == '')?expand("%:h") . '/.iab.vim':a:iab
  let l:file = (a:iab == '')? getcwd() . '/.iab.vim':a:iab

  " let l:file = expand("%:h") . '/.iab.vim'
  if !filereadable(l:file)
    echo "file '" . l:file . "' is not exisit."
  else
    exec "source " . l:file
    echo "file '" . l:file . "' is loaded."
  endif
endfunction

map <leader>mb :call Local_iab('')<cr>

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_RootMarkers = ['.root']
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

noremap <localleader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <localleader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <localleader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <localleader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <localleader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

noremap ]g :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap [g :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

map ;r :<C-u>Rg <C-R><C-W><CR>
map ,r :<C-u>Rg <C-R><C-W><CR>
noremap ;b :<C-u>LeaderfBuffer<CR>
