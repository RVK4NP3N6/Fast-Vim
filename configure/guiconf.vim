
set clipboard+=unnamed      " 共享剪贴板

let g:space_vim_transp_bg = 0
if has("gui_vimr")
    let $TERM="xterm-256color"
    "colorscheme space_vim_theme
    colorscheme space_vim_theme

elseif has("gui_macvim")
    colorscheme  one 
    "set background=dark
    set guifont=Hack\ Nerd\ Font:h14
    hi Normal     ctermbg=NONE guibg=NONE
    hi LineNr     ctermbg=NONE guibg=NONE
    hi SignColumn ctermbg=NONE guibg=NONE
    set cursorline
else
    colorscheme atom-dark
    hi Normal guibg=NONE ctermbg=NONE
    set guifont=Hack\ Nerd\ Font:h15


endif

