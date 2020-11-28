if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin("~/.vim/plugged")
    Plug 'ciaranm/inkpot'
    Plug 'liuchengxu/space-vim-theme'
    Plug 'tyrannicaltoucan/vim-quantum'
    Plug 'google/vim-colorscheme-primary'
    Plug 'edkolev/tmuxline.vim'
    Plug 't9md/vim-choosewin'
    Plug 'lilydjwg/colorizer'
    Plug 'jiangmiao/auto-pairs'
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/nerdcommenter'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'sbdchd/neoformat'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vim-scripts/Rainbow-Parenthesis'
    Plug 'tpope/vim-unimpaired'
    Plug 'samling/previewcolors.vim'
    Plug 'Chiel92/vim-autoformat'
    Plug 'scrooloose/nerdtree'
    Plug 'mileszs/ack.vim'
    Plug 'w0rp/ale'
    Plug 'majutsushi/tagbar'
    Plug 'sheerun/vim-polyglot'
    Plug 'fisadev/fisa-vim-colorscheme'
    Plug 'mhinz/vim-signify'
    Plug 'vim-scripts/Wombat'
    Plug 'jlanzarotta/bufexplorer'
    Plug 'yegappan/mru'
    Plug 'junegunn/goyo.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'mattn/emmet-vim'
    Plug 'Valloric/MatchTagAlways'
	  Plug 'Yggdroot/indentLine'
    Plug 'sheerun/vim-polyglot'
    Plug 'itchyny/lightline.vim'
    Plug 'mhinz/vim-startify'
    Plug 'owickstrom/vim-colors-paramount'
    Plug 'mhartington/oceanic-next'
    Plug 'itchyny/vim-cursorword'
    Plug 'lfv89/vim-interestingwords'
    Plug 'gu-fan/colorv.vim'
    Plug 'sbdchd/neoformat'
    Plug 'posva/vim-vue'
    Plug 'joshdick/onedark.vim'
    Plug 'liuchengxu/vim-clap'
    Plug 'ayu-theme/ayu-vim'
    Plug 'gosukiwi/vim-atom-dark'
    Plug 'rakr/vim-one'
    " Use release branch (Recommend)
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"load setting{
source ~/.vim/configure/basiconf.vim
source ~/.vim/configure/guiconf.vim
"source ~/.vim/configure/statusline.vim
source ~/.vim/configure/keybind.vim
source ~/.vim/configure/miscconf.vim
" }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => basic settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Include local vim config
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" always highlights the enclosing html/xml tags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mta_use_matchparen_group = 1
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \}

"set noshowmode
set laststatus=2
" if hidden is not set, TextEdit might fail.
set hidden


" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
"set signcolumn=no

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <space>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <space>f  <Plug>(coc-format-selected)
nmap <space>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <space>a  <Plug>(coc-codeaction-selected)
nmap <space>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <space>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <space>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified','charvaluehex' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }
" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"suggest.autoTrigger": "trigger"
"suggest.triggerAfterInsertEnter": true
"suggest.timeout": 500,
"Use <Tab> and <S-Tab> to navigate the completion list

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'vue': ['prettier'],
\   'html': ['prettier'],
\}
