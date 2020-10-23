" {{{ Initialize Vim Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}

" {{{ Plugins
call plug#begin('~/.config/nvim/plugged')

" Themeing
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'
Plug 'psliwka/vim-smoothie'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Navigation
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'preservim/nerdcommenter'
Plug 'LnL7/vim-nix'
Plug 'plasticboy/vim-markdown'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Coc Extensions
let g:coc_global_extensions = [
    \ 'coc-go',
    \ 'coc-vimlsp',
    \ 'coc-python',
    \ 'coc-rust-analyzer',
    \ 'coc-json',
    \ 'coc-prettier',
    \ 'coc-ttsever',
    \ 'coc-spell-checker',
    \ 'coc-highlight',
    \ ]

call plug#end()
" }}}

" {{{ Global configuration
syntax on
set encoding=UTF-8
set tabstop=4
set shiftwidth=4
set expandtab
set autochdir
set ignorecase
set smartcase
set conceallevel=2
set clipboard=unnamedplus
set number relativenumber
set emoji
set mouse=a
set history=1000
set foldmethod=marker
set foldlevel=1
set signcolumn=yes
" }}}

" {{{ Themeing
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
let g:onedark_termcolors=256
let g:airline_theme='onedark'
let g:onedark_terminal_italics=1
let g:onedark_hide_endofbuffer=1
colorscheme onedark

let g:vim_markdown_conceal = 1
let g:rainbow_active = 0
let g:airline_powerline_fonts = 1
" }}}

" Fzf Shortcut Directories {{{

" dir_shortcuts for LookupShortcut
let g:dir_shortcuts = {
    \ 'Home': '~',
    \ 'Projects': '~/Projects',
    \ 'Documents': '~/Documents',
    \ 'Downloads': '~/Downloads',
    \ 'Pictures': '~/Pictures',
    \ 'Nixos': '/etc/nixos/',
    \  'Config': '~/.config',
    \ 'Nvim': '~/.config/nvim',
    \ }

" LookupShortcut from g:dir_shortcuts variable use Fzf to list Keys and
" navigate to values based on selected
function! LookupShortcut()
    function! HandleInput(key)
        if empty(a:key)
            return
        endif

        let first = a:key[0]
        exec "edit" . g:dir_shortcuts[first] . "/."
    endfunction

    call fzf#run({'source': keys(g:dir_shortcuts), 'sink*': function('HandleInput'), 'down': '20%'})
endfunction
" }}}

" {{{ Keybindings
nnoremap <SPACE> <Nop>
let mapleader=" "
nnoremap <leader>w <C-w>
map <leader>gg :Git<CR>
map <leader>t :NERDTreeToggle<CR>
map <leader><leader> :Files<CR>
map <leader>b :Buffers<CR>
map <leader>s :Rg <C-r><C-w><CR>
map <leader>; <Plug>NERDCommenterToggle('n', 'Toggle')<Cr>
map <leader>- :e .<CR>
map <leader>fp :Files ~/.config/nvim/<CR>
map <leader>, :bprev<CR>
map <leader>e :CocDiagnostics<CR>
map <leader><CR> :call LookupShortcut()<CR>
nmap <silent> cd <Plug>(coc-definition)
nmap <silent> ct <Plug>(coc-type-definition)
nmap <silent> ci <Plug>(coc-implementation)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
let NERDTreeMapUpdir = '-'
let NERDTreeMapCustomOpen = '<tab>'
let NERDTreeMapChangeRoot = '<CR>'

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" }}}

" {{{ Fzf Configuration
let g:fzf_preview_window = ''
let g:fzf_layout = { 'down': '20%' }
" }}}

" {{{ Coc-nvim configuration
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
filetype plugin on

autocmd BufWritePre *.go :CocCommand editor.action.organizeImport
" }}}

" {{{ NERDTree Configuration
let NERDTreeHijackNetrw = 1

let g:rainbow_conf = {
  \    'separately': {
  \       'nerdtree': 0
  \    }
  \}
" }}}

" {{{ Startify Configuration
let g:startify_custom_header = [
    \'    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
    \'    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
    \'    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',   
    \'    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',   
    \'    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',    
    \'    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',    
    \ ]
" }}}
