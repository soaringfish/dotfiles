"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Important:
"       This requries that you install https://github.com/amix/vimrc !
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set font according to system
if has("mac") || has("macunix")
    set gfn=Hack:h13,Source\ Code\ Pro:h13,Monaco:h13,Menlo:h13
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

" Map ½ to something useful
map ½ $
cmap ½ $
imap ½ $


" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => Parenthesis/bracket
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vnoremap $1 <esc>`>a)<esc>`<i(<esc>
" vnoremap $2 <esc>`>a]<esc>`<i[<esc>
" vnoremap $3 <esc>`>a}<esc>`<i{<esc>
" vnoremap $$ <esc>`>a"<esc>`<i"<esc>
" vnoremap $q <esc>`>a'<esc>`<i'<esc>
" vnoremap $e <esc>`>a"<esc>`<i"<esc>
"
" " Map auto complete of (, ", ', [
" inoremap $1 ()<esc>i
" inoremap $2 []<esc>i
" inoremap $3 {}<esc>i
" inoremap $4 {<esc>o}<esc>O
" inoremap $q ''<esc>i
" inoremap $e ""<esc>i
"

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


" vim: set ft=vim sw=2 ts=2 et foldmethod=marker:
