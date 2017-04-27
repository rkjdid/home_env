" Rasp-Laptop
highlight statusLine term=bold cterm=bold ctermfg=white ctermbg=blue
highlight statusLineNC ctermfg=white ctermbg=darkgrey cterm=NONE
"map ^X :set noautoindent nocindent<RETURN>
set fileencoding=utf8
set fileencodings=utf8
"set encoding=utf8
set termencoding=utf8

set background=dark
"""""""""""""""""""""""""""""""""""



set nocompatible
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME

syntax on

" ignore case if mins only
set ignorecase
" don't ignore case if majs
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,start
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
"set autoindent

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
" set confirm

" Use visual bell instead of beeping when doing something wrong

" Display line numbers on the left
" set number

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
syntax sync minlines=20000
nnoremap <C-L> :nohl<CR>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" next / previous tab
" nmap <C-J> :tabp<CR>
" nmap <C-K> :tabn<CR>
let mapleader = ","
nnoremap <leader><Left> :tabp<CR>
nnoremap <leader><Right> :tabn<CR>
nnoremap <A-Left> :tabp<CR>
nnoremap <A-Right> :tabn<CR>
nnoremap <leader>w :%s,[[:space:]]\+$,,<CR>
map <C-w>w <leader>w
nnoremap <C-w>l mzgg=G`z<CR>
map <leader>l <C-w>l
map W b
map B w


" Plugins
" Pathogen (automatically runs ~/.vim/bundle plugins
" call pathogen#infect()

" vim-indent-guides (plugin)
" let g:indent_guides_auto_colors = 0
" let g:indent_guides_guide_size = 1
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=darkgray
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=red
" let g:indent_guides_enable_on_vim_startup=1

" File relative path in bottom status bar
set statusline+=%f(%F)
set statusline=%t[%F][%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%l,%c/%L\ %P
" Absolute path
" set statusline+=%F
set laststatus=2



" set tags=~/.vim/tags-a9engine.tags
" nmap ,n :call OpenTag()<CR>

function! OpenTag()
    " Execute tag jump open file if one open tag, otherwise display all possibilities
    exe ":tabe | tj ".expand("<cword>")
    if expand('%') == ''
        " If we cancel or don't find tag we close the empty opened tag
        exe ":tabc"
    endif
endfunction

" Trailing whitespaces highlighting
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Custom filetypes
filetype plugin indent on
filetype on
au BufNewFile,BufRead *.lmx set filetype=xml
au BufNewFile,BufRead *.scss set filetype=scss

" But tab should be 2 spaces in HTML and Smarty templates
autocmd FileType html
  \ setlocal shiftwidth=2 |
  \ setlocal softtabstop=2
autocmd FileType scss
  \ setlocal shiftwidth=2 |
  \ setlocal softtabstop=2
autocmd FileType go
  \ setlocal noexpandtab |
  \ setlocal copyindent |
  \ setlocal preserveindent |
  \ setlocal softtabstop=0 |
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2
autocmd FileType json
  \ setlocal noexpandtab |
  \ setlocal copyindent |
  \ setlocal preserveindent |
  \ setlocal softtabstop=0 |
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2


" python.vim options
let python_highlight_string_formatting = 1
"    python_highlight_string_format         Highlight str.format syntax
"    python_highlight_string_templates      Highlight string.Template syntax
"    python_highlight_indent_errors         Highlight indentation errors
"    python_highlight_space_errors          Highlight trailing spaces


" Move current tab into the specified direction.
"
" @param direction -1 for left, 1 for right.
function! TabMove(direction)
    " get number of tab pages.
    let ntp=tabpagenr("$")
    " move tab, if necessary.
    if ntp > 1
        " get number of current tab page.
        let ctpn=tabpagenr()
        " move left.
        if a:direction < 0
            let index=((ctpn-1+ntp-1)%ntp)
        else
            let index=(ctpn%ntp)
        endif

        " move tab page.
        execute "tabmove ".index
    endif
endfunction

cabbrev tabpp call TabMove(-1)
cabbrev tabnn call TabMove(+1)

" Enable highlight_search (somehow disabled somewhere
set hls
" hls colors
hi Search guifg=#FF7777 guifg=#FF7777  guibg=#332222  gui=NONE  ctermfg=14  ctermbg=4  cterm=NONE


