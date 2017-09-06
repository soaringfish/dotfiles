""""""""""""""""""""""""""""""
" => Visual mode related {{{1
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap j gj
noremap k gk
noremap gj j
noremap gk k

inoremap <m-j> <c-o>j
inoremap <m-k> <c-o>k
inoremap <m-h> <c-o>h
inoremap <m-l> <c-o>l
inoremap <m-e> <c-o>e
inoremap <m-b> <c-o>b
" inoremap <C-A> <Home> " included in vim-rsi
" inoremap <C-E> <End>  " included in vi-rsi

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <expr> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
" <TAB>: completion.
" inoremap <silent> <expr> <CR> pumvisible() ? "\<c-y>\<cr>" : "\<CR>"
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap Y y$

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" map <space> /
" map <c-space> ?

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
map <silent> <leader><space> :set hls!<cr>

" Smart way to move between windows {{{1
noremap <c-J> <C-W>j
noremap <c-K> <C-W>k
noremap <c-H> <C-W>h
noremap <c-L> <C-W>l
noremap <m-J> <C-W>j
noremap <m-K> <C-W>k
noremap <m-H> <C-W>h
noremap <m-L> <C-W>l
noremap <C-w>J <C-W>j<C-W>_
noremap <C-w>K <C-W>k<C-W>_
noremap <C-w>H <C-W>h<C-W>|
noremap <C-w>L <C-W>l<C-W>|

nnoremap <s-left>   <c-w>>
nnoremap <s-right>  <c-w><
nnoremap <s-up>     <c-w>-
nnoremap <s-down>   <c-w>+


noremap <M-q> :q<cr>
noremap <M-Q> :q!<cr>

" Close the current buffer {{{1
map <leader>bd :Bclose<cr>
" :tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>


" Buffer/tab/qf/.../ movement {{{1 "
nnoremap [b  :bprevious<cr>zvzz
nnoremap ]b  :bnext<cr>zvzz
nnoremap [B  :bfirst<cr>zvzz
nnoremap ]B  :blast<cr>zvzz

nnoremap [t  :tabprevious<cr>zvzz
nnoremap ]t  :tabnext<cr>zvzz
nnoremap [T  :tabfirst<cr>zvzz
nnoremap ]T  :tablast<cr>zvzz

nnoremap [q  :cprevious<cr>zvzz
nnoremap ]q  :cnext<cr>zvzz
nnoremap [Q  :cfirst<cr>zvzz
nnoremap ]Q  :clast<cr>zvzz

nnoremap [l  :lprevious<cr>zvzz
nnoremap ]l  :lnext<cr>zvzz
nnoremap [L  :lfirst<cr>zvzz
nnoremap ]L  :llast<cr>zvzz

nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" switch comma-separated arguments
" nnoremap [w  :normal F,h]w2w<cr>
" nnoremap ]w  :let s=&isk \| setl isk+=\",' \| exe "norm diwmmebgPdw'mP" \| let &isk=s<cr>

nnoremap [w F,mzbmx`zw"adaw`zb"bdaw"aPf,"bp`x
nnoremap ]w f,mzbmx`zw"adaw`zb"bdaw"aPf,"bp`x

" Other movement {{{1 "
nnoremap }   }zz
nnoremap {   {zz
nnoremap ]]  ]]zz
nnoremap [[  [[zz
nnoremap []  []zz
nnoremap ][  ][zz

nnoremap g;  g;zvzz
nnoremap g,  g,zvzz

" Useful mappings for managing tabs {{{1
map <s-tab> :tabnext<CR>
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


augroup vimrcbasic
  au!
  au TabLeave * let g:lasttab = tabpagenr()
augroup END

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
" => Editing mappings  {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
" map 0 ^
nnoremap <m-h> ^
nnoremap <m-l> $
nnoremap H ^
nnoremap L $
nnoremap gb H
nnoremap gl L

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

augroup vimrcbasic
  autocmd BufWrite *.py :call DeleteTrailingWS()
  autocmd BufWrite *.coffee :call DeleteTrailingWS()
  autocmd BufWrite *.tex,*.lua,*.vim :call DeleteTrailingWS()
augroup END

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
" => Smart Keys Maps  {{{1
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
endif
" set osx-terminal 'Use option as Meta key'
" for macvim set macmeta
if 1 " All os
  " else " Linux/Windows
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
" => Ag searching and cope displaying  {{{1
"    requires ag.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you Ag after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ag and put the cursor in the right position
map <leader>gg :Ack<space>

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
" map <leader>cc :botright cope<cr>
" map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
" map <leader>n :cn<cr>
" map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking  {{{1
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
" => Misc {{{1
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


" ------------------------------------------------------------------
" Markdown headings  {{{1
" ------------------------------------------------------------------
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
" }}}1 "

" Atomically match bullets (*+- num \item) {{{1 "
" let s:bulletmatch = '^\s*\zs\([*+-]\s\)\|\(\d\+\.\?\s\)\ze'
let s:bulletmatch = '\v^\s*\zs([*\+-]\s)|(\d+\.?\s)|(\\item(\s|\[))\ze'

function! s:AddBullet()
  let l:ln = line('.')
  let l:bullet = matchstr(getline(l:ln-1),s:bulletmatch)

  if match(l:bullet, '^\s*\d') >= 0
    let l:bullet .= "\<Esc>^\<C-a>A"
  else
    let l:bullet = substitute(l:bullet,'[',' ','')
  endif
  return l:bullet
endfunction
inoremap <a-cr> <esc>o<c-r>=<SID>AddBullet()<cr>
au FileType markdown inoremap <a-cr> <esc>o<c-r>=<SID>AddBullet()<cr>
if OSX()
  au FileType markdown inoremap  <esc>o<c-r>=<SID>AddBullet()<cr>
endif
" }}}1 "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions  {{{1
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
        call CmdLine("Ack \"" . l:pattern . "\" " )
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
" }}}1 "

" Cscope mappings {{{1 "
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
" }}}1 "

augroup vimrcbasic
  au WinEnter    * set cursorline
  au WinLeave    * set nocursorline
  au InsertEnter * set nocursorline
  au InsertLeave * set cursorline
augroup END

" vim: set ft=vim sw=2 ts=2 et foldmethod=marker:
