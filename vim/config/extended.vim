""""""""""""""""""""
"  extended.vim:   "
""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set font according to system
if has("mac") || has("macunix")
    set gfn=YaHei\ Consolas\ Hybrid:h14,Hack:h13,Source\ Code\ Pro:h13,Monaco:h13,Menlo:h13
elseif has("win16") || has("win32")
    set gfn=Hack:h12,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=Hack\ 12,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=Hack\ 12,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" Open MacVim in fullscreen mode
if has("gui_macvim")
    " set fuoptions=maxvert,maxhorz
    " au GUIEnter * set fullscreen
endif

" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Colorscheme
" set background=dark
" colorscheme peaksea
" showtabline: 0-off, 1-auto, 2-always
set showtabline=1


let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self
au FileType qf call OnQFPost()
au FileType qf noremap <buffer> x zc

augroup ag_python
  au!
  au FileType python setlocal iskeyword-=:
  au FileType python hi link pythonParam pythonBoolean
  " au FileType python map <buffer> F :set foldmethod=indent<cr>
  " autocmd BufReadPost *.py call PPythonSyncExt()
augroup END

function! PythonSyncExt()
    syn keyword pythonBoolean       False None True
    syn keyword pythonDefine class def nextgroup=pythonFunction skipwhite
    syn match pythonDefine '@' nextgroup=pythonFunction skipwhite
    "syn match pythonParameterList '\<\h\w*\s*(.\{3,})' transparent contains=TOP "TOP ,pythonParameterName
    "syn region pythonParameterList start='\<\h\w*(' end=')' transparent contains=TOP
    "syn region pythonParameterList matchgroup=lv1c start=+\%(\<\h\w*\s*\)\@99<=(+  end=+)+  contains=TOP,pythonParameterList,pythonParameterName,lv1,lv2,lv3,lv4,lv5,lv6,lv7,lv8,lv9 containedin=lv2c contains=TOP,pythonParameterList,lv1,lv2,lv3,lv4,lv1c,lv2c,lv3c,lv4c
    "syn region pythonParameterList matchgroup=pythonPL start=+\%(\<\h\w*\s*\)\@99<=(+  end=+)+  contains=ALL  containedin=pythonParameterList,lv1,lv2,lv3,lv4,lv5,lv6,lv7,lv8,lv9
    "transparent
    "contains=ALL
"syn keyword pythonBuiltin	False True None max dummy nextgroup=pythonParameterList skipwhite
"syn match pythonDummyFN	'\<\h\w*\s*' contains=TOP nextgroup=pythonParameterList skipwhite
    "syn match pythonParameterName
    "        \ '\%(\%(^\s*\|[(,]\)\s*\)\@<=\%(\<\h\w*\)\%(\s*=\)\@=' contained
    "        \ containedin=lv1,lv2,lv3,lv4,lv5,lv6,lv7,lv8,lv9,pythonParameterList
            "\ containedin=pythonParameterList
    syn match pythonTransChar '%-\?\d*\.\?\d*[sSdDxXuUlLfF]' contained contains=NONE containedin=pythonString
      "%d %s %2d %.2d %-2d
    "highlight def link pythonParameterList pythonDefine
    highlight def link pythonTransChar pythonDefine
    "highlight def link pythonParameterName Label
    highlight def link pythonBoolean Boolean
    highlight def link pythonDefine Define
    "highlight def link pythonOperator Operator
    "highlight def link pythonFunction Function
    "call confirm('highlight')
endfunction

augroup ag_help
  au!
  au FileType help,qf map <buffer> q :q<cr>
  au FileType help map <buffer> l <c-d>
  au FileType help map <buffer> h <c-u>
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists('g:mycfgfile')
    let s:mycfg=exists('g:vimpath')? g:vimpath : '~/.vim'
    let g:mycfgfile = s:mycfg . '/my_configs.vim'
endif
map <leader>e :e! <C-r>=g:mycfgfile<cr><cr>
" exec 'autocmd! bufwritepost my_configs.vim source' . g:mycfgfile
autocmd! bufwritepost my_configs.vim source %
try | exec 'source ' . g:mycfgfile | catch | endtry



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
" it deletes everything until the last slash
cno $q <C-\>eDeleteTillSlash()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

map <C-F11> :call FormartSrc()<CR>


"定义FormartSrc()
func! FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi --one-line=keep-statements -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    endif
    exec "e! %"
endfunc
"结束定义FormartSrc


"""""""""""""""""""""""""""""""
" Quick Fix
"
"au QuickFixCmdPost * call OnQFPost()
"au QuickFixCmdPost * set rnu
"au QuickFixCmdPost * set fdm=expr
"au QuickFixCmdPost * set foldexpr=QuickfixFold(v:lnum)
"au FileType qf call confirm('hh')
"au BufEnter qf call confirm('hh')
"au BufEnter qf call OnQFPost()
function! QuickfixFold(lnum)
  if a:lnum == 1
    let s:ptag = ''
    " return ">1"
  endif
  let l:tag = matchstr(getline(a:lnum),'^[^|]*\|')
  if empty(l:tag)
    return 1
  else
    let l:ptag = s:ptag
    let s:ptag = l:tag
    " let l:ptag = matchstr(getline(a:lnum-1),'^[^|]*\|')
    return (l:tag==# l:ptag) ? 1 : ">1"
  endif
endfunction
function! OnQFPost()
  exec 'set nu'
  exec 'set foldexpr=QuickfixFold(v:lnum)'
  exec 'set fdm=expr'
endfunction
" map <leader>x :call OnQFPost()<CR>


function! TwiddleCase(str)
    if a:str ==# toupper(a:str)
        let result = tolower(a:str)
    elseif a:str ==# tolower(a:str)
        let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
    else
        let result = toupper(a:str)
    endif
    return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgvl"))
let g:rainbow_active=1
" Color {{{1
function! s:colors_default() abort
  highlight Comment cterm=italic
  highlight texBoldStyle guifg=yellow ctermfg=yellow
  highlight texItalStyle guifg=cyan ctermfg=cyan
  highlight texBoldItalStyle guifg=Red ctermfg=Red
endfunction

function! s:colors_onedark() abort
  highlight texBoldStyle guifg=#e5c07b ctermfg=180
  highlight texItalStyle guifg=#56b6c2 ctermfg=38
  highlight texBoldItalStyle guifg=#e06c75 ctermfg=204
endfunction

augroup vimrc
  autocmd ColorScheme *      call s:colors_default()
  " autocmd ColorScheme janah  call s:colors_janah()
  " autocmd ColorScheme lucius call s:colors_lucius()
  autocmd ColorScheme onedark call s:colors_onedark()
augroup END


" vim: set ft=vim sw=2 ts=2 et foldmethod=marker:
