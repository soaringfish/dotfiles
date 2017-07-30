" vim: set ft=vim sw=2 ts=2 et foldmethod=marker:


set fo+=j

let g:snips_author="Chuancai Gu"
let g:snips_email="gucc.gu@gmail.com"
let g:snips_github="https://github.com/soaringfish"


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
    set spell
endfunction

augroup mdgroup
    autocmd!
    au filetype markdown call s:md_maps()
augroup END

" augroup ag_latex
"   au!
"   au filetype tex inoremap <m-m> `
" augroup END

inoremap <A-;> <C-o>:
" osx <a-;>
inoremap … <C-o>:
noremap … :

function! s:get_makefile_dir()

endfunction

function! Run_script()
    if &filetype == 'markdown'
        execute '!make -C ../'
    elseif &filetype == 'tex'
        silent execute 'normal \ll'
        silent execute 'normal \lv'
    else
        echom "Unknown build method for:" &filetype
    endif
endfunction

noremap <m-b> <c-b>
noremap <c-B> :w<cr>:call Run_script()<cr>
inoremap <c-B> <esc>:w<cr>:call Run_script()<cr>

" set noimdisable
autocmd! InsertLeave * set imdisable|set iminsert=0
autocmd! InsertEnter * set noimdisable|set iminsert=0


" VIMTEX settings {{{
" ===================
" let g:vimtex_disable_recursive_main_file_detection=0
let g:vimtex_compiler_latexmk = {
      \ 'background' : 1,
      \ 'build_dir' : 'build',
      \ 'callback' : 1,
      \ 'continuous' : 0,
      \ 'executable' : 'latexmk',
      \ 'options' : [
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
  let g:vimtex_view_method='zathura'
  " let g:vimtex_view_method = 'mupdf'
  " let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  " let g:vimtex_view_general_options = '-r @line @pdf @tex'
elseif LINUX()
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
" VIMTEX settings }}}

" Jump out pairs
" inoremap
"
"
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><leader>l <Plug>(easymotion-lineforward)
map <Leader><leader>. <Plug>(easymotion-repeat)
map <Leader><leader>S <Plug>(easymotion-s2)
map sh <Plug>(easymotion-linebackward)
map sl <Plug>(easymotion-lineforward)
map s. <Plug>(easymotion-repeat)
map s <Plug>(easymotion-prefix)
map S <Plug>(easymotion-s2)

iab ,.s <esc>3a<c-v>{<esc>
iab ,.e <esc>3a<c-v>}<esc>
iab ,s <esc>3a<c-v>{<esc>,1Vj,ccj
iab ,,s <esc>3a<c-v>{<esc>,2Vj,ccj
iab ,e <esc>mz[zyy`zp:s/{{{/}}}/<cr>


" MARKDOWN-MAPS {{{ "
augroup ft_maps
  if get(g:, "usecommaleader")
    " au FileType tex echo 'filetype-tex'. b:vimtex.compiler.build_dir
    " au BufReadPre *.tex echo 'pre:'. b:vimtex.compiler.build_dir
    " au BufRead *.tex echo 'read:'. b:vimtex.compiler.build_dir
    " au BufReadPost *.tex echo 'post:'. b:vimtex.compiler.build_dir
    au FileType tex
          \ map ,v <localleader>lv|
          \ map ,m <localleader>ll
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
augroup END
" }}} MARKDOWN-MAPS "

" VIMTEX-MAPS {{{ "
augroup vimtex_map
  if get(g:, "usecommaleader")
    au FileType tex map
          \ map ,l <localleader>ll|
          \ map ,v <localleader>lv
  endif
augroup END
" }}} VIMTEX-MAPS "

" FZF {{{
" =======

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
" FZF }}}

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
call NERDTreeHighlightFile('hbs', 202, 'none', '#FC4709')
call NERDTreeHighlightFile('jade', 149, 'none', '#A0D24D')
call NERDTreeHighlightFile('json', 223, 'none', '#FECEA0')
call NERDTreeHighlightFile('scss', 44, 'none', '#1AD0CE')
call NERDTreeHighlightFile('css', 44, 'none', '#1AD0CE')
call NERDTreeHighlightFile('js', 226, 'none', '#FFFF0D')
call NERDTreeHighlightFile('rb', 197, 'none', '#E53378')
call NERDTreeHighlightFile('md', 208, 'none', '#FD720A')
call NERDTreeHighlightFile('php', 140, 'none', '#9E6FCD')
call NERDTreeHighlightFile('svg', 178, 'none', '#CDA109')
call NERDTreeHighlightFile('gif', 36, 'none', '#15A274')
call NERDTreeHighlightFile('jpg', 36, 'none', '#15A274')
call NERDTreeHighlightFile('png', 36, 'none', '#15A274')
call NERDTreeHighlightFile('vim', 36, 'none', '#15A274')


" ALE gutter sign colors
hi ALEErrorSign ctermfg=203 ctermbg=237 guifg=#ff0000 guibg=#343d46
hi ALEWarningSign ctermfg=221 ctermbg=237 guifg=#fac863 guibg=#343d46
