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
    inoremap <buffer> `a \alpha
    inoremap <buffer> `b \beta
    inoremap <buffer> `g \gamma
    set spell
endfunction

augroup mdgroup
    autocmd!
    au filetype markdown call s:md_maps()
augroup END

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

noremap <c-b><c-b> :w<cr>:call Run_script()<cr>
inoremap <c-b><c-b> <esc>:w<cr>:call Run_script()<cr>

" let g:vimtex_latexmk_build_dir='build'
let g:vimtex_latexmk_build_dir='/tmp/build'
autocmd FileType tex let b:vimtex_main = 'main.tex'


" Jump out pairs
" inoremap
"
"
"


iab ,.s <esc>3a<c-v>{<esc>
iab ,.e <esc>3a<c-v>}<esc>
iab ,s <esc>3a<c-v>{<esc>,1Vj,ccj
iab ,,s <esc>3a<c-v>{<esc>,2Vj,ccj
iab ,e <esc>mz[zyy`zp:s/{{{/}}}/<cr>

" isi {{{
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

" colorscheme gruvbox
" colorscheme xcode-default
" AirlineTheme raven


" let g:mkdp_path_to_chrome="/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"
