""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap j gj
noremap k gk
noremap gj j
noremap gk k

imap <m-j> <c-o>j
imap <m-k> <c-o>k
imap <m-h> <c-o>h
imap <m-l> <c-o>l
imap <m-e> <c-o>e
imap <m-b> <c-o>b
inoremap <C-A>		<Home>
inoremap <C-E>		<End>

nnoremap Y y$

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" map <space> /
" map <c-space> ?

nmap <space> <leader>
nmap <space><space> <leader><leader>

try
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
catch
endtry

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
map <silent> <leader><space> :set hls!<cr>

" Smart way to move between windows
map <m-J> <C-W>j
map <m-K> <C-W>k
map <m-H> <C-W>h
map <m-L> <C-W>l
noremap <C-w>J <C-W>j<C-W>_
noremap <C-w>K <C-W>k<C-W>_
noremap <C-w>H <C-W>h<C-W>|
noremap <C-w>L <C-W>l<C-W>|


map <M-q> :q<cr>
map <M-Q> :q!<cr>

" Close the current buffer
map <leader>bd :Bclose<cr>
" :tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" map <leader>l :bnext<cr>
map ]b :bnext<cr>
" map <leader>h :bprevious<cr>
map [b :bprevious<cr>

" Useful mappings for managing tabs
map <tab> :tabnext<CR>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove
func! Tabmoveto(no)
    tabfirst
    if a:no > 1
        execute "tabmove " . a:no
    endif
endfunc

map <leader>tm :<c-u>call Tabmoveto(v:count1)<cr>
map <leader>t<leader> :tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Goto Buffer
nmap <leader>b :<C-U>execute "b" . v:count1<CR>

" match %
nnoremap g5 %

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
" map 0 ^
nmap H ^
nmap L $
nmap gb H
nmap gl L

noremap U <c-r>
inoremap <s-cr> <esc>o
" VIM can't get s-cr from terminals
inoremap <m-cr> <esc>o

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

if OSX()
            inoremap ‘ <C-o>:call InsertIndent(0)<CR>
    inoremap “ <C-o>:call <SID>Indent(1)<CR>
else
endif
inoremap <A-]> <Esc>:call <SID>Indent(0)<CR>a
inoremap <A-[> <Esc>:call <SID>Indent(1)<CR>a
function! InsertIndent(left)
    call s:Indent(a:left)
    return ''
endfunction

function! s:Indent(left)
    let s:direct = (1 == a:left) ? '<<' : '>>'
    let s:pos = getpos('.')
    let s:lenold = len(getline('.'))
    exec 'normal! ' . s:direct . ''
    " let s:shift = s:pos[2] + len(getline('.')) - s:lenold - 1
    " if s:shift > 0
    "     exec 'normal! ' . s:shift . 'l'
    " endif
    let s:pos[2] += len(getline('.')) - s:lenold
    call setpos('.',s:pos)

endfunction

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.tex,*.lua,*.vim :call DeleteTrailingWS()

nmap <leader>tw :call DeleteTrailingWS()

"" Copy/Paste/Cut
if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>


"""""""""""""""""""""""""""""""""""""""
" => Smart Keys Maps
"""""""
if OSX()
    inoremap ˙ <Left>
    inoremap ¬ <Right>
    inoremap ∆ <Esc>ja
    inoremap ˚ <Esc>ka
    inoremap ´ <Esc>ea
    inoremap <c-u> <esc>ua
    inoremap ¨ <esc>ui

    inoremap <c-d> <Del>
    " inoremap <c-e> <Backspace> "<c-h> mapped somewhere later"
    imap <a-backspace> <esc>d^xi
    map <a-backspace> d^
    imap <a-delete> <esc>ld$a
    map <a-delete> d$
    imap <a-x> <esc>ld$a
    map <a-x> d$
    imap <S-CR> <esc>o

else " Linux/Windows"
    inoremap <a-h> <Left>
    inoremap <a-l> <Right>
    inoremap <a-j> <Esc>ja
    inoremap <a-k> <Esc>ka
    inoremap <a-e> <Esc>ea
    inoremap <c-u> <esc>ua
    inoremap <a-u> <esc>ui

    inoremap <c-d> <Del>
    " inoremap <c-e> <Backspace> "<c-h> mapped somewhere later"
    imap <a-backspace> <esc>d^xi
    map <a-backspace> d^
    imap <a-delete> <esc>ld$a
    map <a-delete> d$
    imap <a-x> <esc>ld$a
    map <a-x> d$
    imap <S-CR> <esc>o
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ag searching and cope displaying
"    requires ag.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you Ag after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ag and put the cursor in the right position
map <leader>g :Ag

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ag, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>st :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
function! RemoveWinCR()
  normal mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
endfunction
" noremap <Leader>m :call RemoveWinCR()<cr>

" Quickly open a buffer for scribble
" map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
" map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


" ----------------------------------------------------------------------------
" Markdown headings
" ----------------------------------------------------------------------------
" nnoremap <leader>1 m`yypVr=``
" nnoremap <leader>2 m`yypVr-``
" nnoremap <leader>3 m`^i### <esc>``4l
" nnoremap <leader>4 m`^i#### <esc>``5l
" nnoremap <leader>5 m`^i##### <esc>``6l

nnoremap <leader>1 :call MarkdownHeadline(1)<cr>
nnoremap <leader>2 :call MarkdownHeadline(2)<cr>
nnoremap <leader>3 :call MarkdownHeadline(3)<cr>
nnoremap <leader>4 :call MarkdownHeadline(4)<cr>
nnoremap <leader>5 :call MarkdownHeadline(5)<cr>

function! MarkdownHeadline(lvl)
    let l:ln = line('.')
    let l:ls = getline(l:ln)
    let l:pos = getpos('.')

    if match(ls,'^#\+\s\+.*') == 0
        let ls = substitute(l:ls,'^#\+\s\+','','')
        call setline(l:ln,l:ls)
    endif
    if match(getline(l:ln+1),'^[=-]\+\s*$') == 0
        " call setline(ln+1,'')
        " normal! jddk
        execute (l:ln+1) 'delete _'
        call setpos('.',l:pos)
    endif
    if a:lvl == 1 || a:lvl == 2
        exec 'normal! m`yypVr' . ['-','='][-a:lvl] . '``'
        " exec 'm`yypVr' . ['=','-'][-a:lvl] . '``'
    elseif a:lvl >2 && a:lvl<6
        call setline(l:ln, join(['#','#','#','#','#'][0:a:lvl-1],'') . ' ' . l:ls )
    endif
endfunction


let g:bulletmatch = '^\s*\zs\([*+-]\s\)\|\(\d\+\.\?\s\)\ze'
if OSX()
    au FileType markdown inoremap  <cr><c-r>=matchstr(getline(line('.')-1),g:bulletmatch)<cr><esc>^<c-a><Esc>$A
else
    au FileType markdown inoremap <a-cr> <cr><c-r>=matchstr(getline(line('.')-1),g:bulletmatch)<cr><esc>^<c-a>>$A
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Make VIM remember position in file after reopen
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" ----------------------------------------------------------------------------
" Cscope mappings
" ----------------------------------------------------------------------------
function! s:add_cscope_db()
  " add any database in current directory
  let db = findfile('cscope.out', '.;')
  if !empty(db)
    silent cs reset
    silent! execute 'cs add' db
  " else add database pointed to by environment
  elseif !empty($CSCOPE_DB)
    silent cs reset
    silent! execute 'cs add' $CSCOPE_DB
  endif
endfunction

if has("cscope")
  set csprg=/usr/local/bin/cscope
  set csto=0
  set cst
  set nocsverb
  set csverb
  call s:add_cscope_db()

  "   's'   symbol: find all references to the token under cursor
  "   'g'   global: find global definition(s) of the token under cursor
  "   'c'   calls:  find all calls to the function name under cursor
  "   't'   text:   find all instances of the text under cursor
  "   'e'   egrep:  egrep search for the word under cursor
  "   'f'   file:   open the filename under cursor
  "   'i'   includes: find files that include the filename under cursor
  "   'd'   called: find functions that function under cursor calls
  nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  xnoremap <C-\>t y:cs find t <C-R>"<CR>
  " nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  " nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

  " extends
  nnoremap <C-\>e :cs find t extends <C-R>=expand("<cword>")<CR><CR>
  " implements
  nnoremap <C-\>i :cs find t implements <C-R>=expand("<cword>")<CR><CR>
  " new
  nnoremap <C-\>n :cs find t new <C-R>=expand("<cword>")<CR><CR>
endif


" ----------------------------------------------------------------------------
" Readline-style key bindings in command-line (excerpt from rsi.vim)
" ----------------------------------------------------------------------------
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
silent! exe "set <S-Left>=\<Esc>b"
silent! exe "set <S-Right>=\<Esc>f"


" vim: set ft=vim sw=2 ts=2 et foldmethod=marker:
