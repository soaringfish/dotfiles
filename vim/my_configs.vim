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

augroup luagroup
    autocmd!
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

augroup mdgroup
  autocmd!
  au filetype markdown call s:md_maps()
augroup END

augroup conf_group
  autocmd!
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
  AsyncRun ~/bin/runpdc % -o %<.pdf
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
    else
        echom "Unknown build method for:" &filetype
    endif
endfunction

" noremap <m-b> <c-b>
" noremap <m-f> <c-f>
noremap <c-x>b :w<cr>:call Run_script()<cr>
noremap <m-B> :w<cr>:call Run_script()<cr>
inoremap <c-x>b <esc>:w<cr>:call Run_script()<cr>
inoremap <m-B> <esc>:w<cr>:call Run_script()<cr>

" replaced by fcitx.vim
" set noimdisable
" autocmd! InsertLeave * set imdisable|set iminsert=0
" autocmd! InsertEnter * set noimdisable|set iminsert=0


augroup latexSurround
  autocmd!
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

let g:vimtex_toc_refresh_always = 0
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
augroup ft_maps
  if get(g:, "usecommaleader")
    " au FileType tex echo 'filetype-tex'. b:vimtex.compiler.build_dir
    " au BufReadPre *.tex echo 'pre:'. b:vimtex.compiler.build_dir
    " au BufRead *.tex echo 'read:'. b:vimtex.compiler.build_dir
    " au BufReadPost *.tex echo 'post:'. b:vimtex.compiler.build_dir
    au FileType tex
          \ map ,v <localleader>lv|
          \ map ,m <localleader>ll|
          \ nnoremap <localleader>lf :call <SID>vimtex_refresh(3)<cr>|
          \ nnoremap <localleader>o :call <SID>vimtex_outline(1,0,1)<cr>|
          \ nnoremap <localleader><localleader>o :call <SID>vimtex_outline(1,1,1)<cr>|
          \ nnoremap <localleader>t :VimtexTocOpen<cr>|
          \ nnoremap <localleader><localleader>t :call <SID>vimtex_outline(1,1,0)<cr>|
          \ nnoremap <localleader>y :<c-u>Denite vimtex_labels<cr>|
          \ nnoremap <localleader><localleader>y :<c-u>call <SID>vimtex_outline(2,1,1)<cr>

    au FileType pandoc
          \ map ,b <localleader>biw|
          \ map ,i <localleader>iiw|
          \ map ,` <localleader>`iw|
          \ map ,_ <localleader>_iw|
          \ map ,^ <localleader>^iw|
          \ map ,] <localleader>hsn|
          \ map ,[ <localleader>hsb|
          \ map ,cf <localleader>hcf|
          \ map ,cl <localleader>hcl|
          \ map ,cn <localleader>hcn|
          \ map ,h <localleader>hh|
          \ map ,p <localleader>hp|
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
augroup vimtex_map
  if get(g:, "usecommaleader")
    au FileType tex map
          \ map ,l <localleader>ll|
          \ map ,v <localleader>lv
  endif
augroup END
" }}}1 VIMTEX-MAPS "

" FZF {{{1
" =======
map <c-p> :<c-u>FZF<cr>
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

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
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

nnoremap ]a <plug>(ale_next)
nnoremap [a <plug>(ale_last)


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

nmap <c-x>t :call SwapBoolean()<cr>
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

augroup VIMWIKI
  au filetype vimwiki call s:vimwiki_settings()
  au BufNewFile *.mkd,*.wiki let b:new_file = 1
  " if &filetype=='vimwiki' | call setline(1,expand('%<')) | else | let b:new_file=1 | endif
augroup END

function! s:vimwiki_settings()
  map <Leader>w<space> <Plug>VimwikiToggleListItem
  if get(b:,'new_file',0)
    call setline(1,expand('%<'))
    call setline(2,'')
    call setline(3,'')
    normal gg=G
    " let b:new_file=0
    unlet b:new_file
  endif
endfunction

" }}}1 "

" capticalize first letter
map gc :s/\v<(.)(\w*>)/\u\1\L\2/g<cr>:noh<cr>


augroup voom
  au filetype voomtree map <buffer> h k<cr>|map <buffer> l j<cr>
augroup END
let g:voom_ft_modes = {'markdown': 'markdown', 'tex': 'latex'}
map <leader>o :call <SID>voom_open()<cr>
function! s:voom_open()
  try
    if expand('%:e')=='mkd'
      execute 'Voom markdown'
    else
      execute 'Voom ' . &ft
    endif
    execute 'Voom'
  catch
  endtry
endfunction
" let g:voom_return_key = "<C-Return>"
" let g:voom_tab_key = "<C-Tab>"
map <localleader>vl :Voomunl<cr>

" let g:vimwiki_listsyms = '✗○◐●✓'
" let g:calendar_diary='~/Documents/vimwiki/wiki/diary/'

"cnfile colder cnewer g; g,

