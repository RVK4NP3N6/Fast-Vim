" status bar colors
au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

hi statusline guifg=#504945 guibg=white ctermfg=black ctermbg=cyan

" Status Line Custom

let g:currentmode={
      \ 'n'  : 'Nromal',
      \ 'no' : 'N·Operator Pending',
      \ 'v'  : 'VISUAL',
      \ 'V'  : 'V·Line',
      \ '' : 'V·Block',
      \ 's'  : 'Select',
      \ 'S'  : 'S·Line',
      \ '' : 'S·Block',
      \ 'i'  : 'Insert',
      \ 'R'  : 'Replace',
      \ 'Rv' : 'V·Replace',
      \ 'c'  : 'Command',
      \ 'cv' : 'Vim Ex',
      \ 'ce' : 'Ex',
      \ 'r'  : 'Prompt',
      \ 'rm' : 'More',
      \ 'r?' : 'Confirm',
      \ '!'  : 'Shell',
      \ 't'  : 'Terminal'
      \}


hi User1 ctermbg=green ctermfg=white   guibg=green guifg=#4AF2A1
hi User2 ctermbg=red   ctermfg=blue  guibg=red   guifg=blue
hi User3 ctermbg=blue  ctermfg=green guibg=blue  guifg=green
hi User4 ctermbg=green  ctermfg=white guibg=blue  guifg=green
hi User5 ctermbg=blue  ctermfg=green guibg=blue  guifg=green
hi User8 ctermbg=red ctermfg=white guibg=red  guifg=white
hi User9 ctermbg=yellow  ctermfg=white guibg=yellow  guifg=white

function! PasteForStatusline()
    let paste_status = &paste
    if paste_status == 1
        return "| PASTE "
    else
        return ""
    endif
endfunction

" ====== basic info ======

" ---- number of buffers : buffer number ----

function! StatlineBufCount()
    if !exists("s:statline_n_buffers")
        let s:statline_n_buffers = len(filter(range(1,bufnr('$')), 'buflisted(v:val)'))
    endif
    return s:statline_n_buffers
endfunction

if !exists('g:statline_show_n_buffers')
    let g:statline_show_n_buffers = 1
endif

if g:statline_show_n_buffers
    set statusline=[%{StatlineBufCount()}\:%n]\ %<
    " only calculate buffers after adding/removing buffers
    augroup statline_nbuf
        autocmd!
        autocmd BufAdd,BufDelete * unlet! s:statline_n_buffers
    augroup END
else
    set statusline=[%n]\ %<
endif


function! LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '⚠ 0' : printf('⚠ %1d', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '⨉0' : printf('⨉%1d ', all_errors)
endfunction


function! LightlineLinterOK() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '☻' : ''
endfunction

function! FileSize() abort
    let l:bytes = getfsize(expand('%p'))
    if (l:bytes >= 1024)
        let l:kbytes = l:bytes / 1025
    endif
    if (exists('kbytes') && l:kbytes >= 1000)
        let l:mbytes = l:kbytes / 1000
    endif
 
    if l:bytes <= 0
        return '0KB'
    endif
  
    if (exists('mbytes'))
        return l:mbytes . 'MB '
    elseif (exists('kbytes'))
        return l:kbytes . 'KB '
    else
        return l:bytes . 'B '
    endif
endfunction

function! ReadOnly()
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

if has("gui_running")
    set laststatus=2
    set statusline=
    set statusline+=%4*\ %{toupper(g:currentmode[mode()])}\  " The current mode
    set statusline+=%{PasteForStatusline()}       " paste flag
    set statusline+=%2*\ %n\                                 " Buffer number
    set statusline+=%*\ %l
    set statusline+=\ %*
    set statusline+=%*\ ‹‹
    set statusline+=%*\ %f\ %*
    set statusline+=%*\ ››
    set statusline+=%*\ %m
    set statusline+=%=
    " set statusline+=%*\ %{LinterStatus()}
    set statusline+=%*\ ‹‹
    set statusline+=%0*\ \ %r%w\%P\ \                      "Modified? Readonly? Top/bot.
    set statusline+=%9*\ %{LightlineLinterErrors()}\       " paste flag
    set statusline+=%8*\ %{LightlineLinterWarnings()}\       " paste flag
    "set statusline+=%4*\ %{LightlineLinterOK()}       " paste flag
    set statusline+=%*\ ››\ %*
    set statusline+=%2*\ %{FileSize()}\       " paste flag
    set statusline+=%{ReadOnly()}       " paste flag
else
    hi statusline guifg=#292929 guibg=white ctermfg=black ctermbg=cyan
    
    set laststatus=2
    set statusline=
    set statusline+=%*\ %{toupper(g:currentmode[mode()])}\  " The current mode
    set statusline+=%{PasteForStatusline()}       " paste flag
    set statusline+=%*\ %n\                                 " Buffer number
    set statusline+=%*\ %l
    set statusline+=\ %*
    set statusline+=%*\ ‹‹
    set statusline+=%*\ %f\ %*
    set statusline+=%*\ ››
    set statusline+=%*\ %m
    set statusline+=%=
    " set statusline+=%*\ %{LinterStatus()}
    set statusline+=%*\ ‹‹
    set statusline+=%*\ \ %r%w\%P\ \                      "Modified? Readonly? Top/bot.
    set statusline+=%*\ %{LightlineLinterErrors()}\       " paste flag
    set statusline+=%*\ %{LightlineLinterWarnings()}\       " paste flag
    "set statusline+=%4*\ %{LightlineLinterOK()}\       " paste flag
    set statusline+=%*\ ››\ %*
    set statusline+=%*\ %{FileSize()}\       " paste flag
    set statusline+=%{ReadOnly()}       " paste flag
    
endif

let s:hidden_all = 1
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        "set noshowmode
        "set noruler
        set laststatus=0
        "set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <S-h> :call ToggleHiddenAll()<CR>

"augroup status
  "autocmd!
  "autocmd WinEnter * setlocal statusline=%!ActiveStatus()
  "autocmd WinLeave * setlocal statusline=%!InactiveStatus()
  "autocmd ColorScheme kalisi if(&background=="dark") | hi User1 guibg=#afd700 guifg=#005f00 | endif
  "autocmd ColorScheme kalisi if(&background=="dark") | hi User2 guibg=#005f00 guifg=#afd700 | endif
  "autocmd ColorScheme kalisi if(&background=="dark") | hi User3 guibg=#222222 guifg=#005f00 | endif
  "autocmd ColorScheme kalisi if(&background=="dark") | hi User4 guibg=#222222 guifg=#d0d0d0 | endif
  "autocmd ColorScheme kalisi if(&background=="light") | hi User1 guibg=#afd700 guifg=#005f00 | endif
  "autocmd ColorScheme kalisi if(&background=="light") | hi User2 guibg=#005f00 guifg=#afd700 | endif
  "autocmd ColorScheme kalisi if(&background=="light") | hi User3 guibg=#707070 guifg=#005f00 | endif
  "autocmd ColorScheme kalisi if(&background=="light") | hi User4 guibg=#707070 guifg=#d0d0d0 | endif
"augroup END
