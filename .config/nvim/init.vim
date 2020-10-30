" ███╗   ██╗██╗ ██████╗██╗  ██╗██╗  ██╗ █████╗  ██████╗██╗  ██╗███╗   ███╗ █████╗ ███╗   ██╗
" ████╗  ██║██║██╔════╝██║ ██╔╝██║  ██║██╔══██╗██╔════╝██║ ██╔╝████╗ ████║██╔══██╗████╗  ██║
" ██╔██╗ ██║██║██║     █████╔╝ ███████║███████║██║     █████╔╝ ██╔████╔██║███████║██╔██╗ ██║
" ██║╚██╗██║██║██║     ██╔═██╗ ██╔══██║██╔══██║██║     ██╔═██╗ ██║╚██╔╝██║██╔══██║██║╚██╗██║
" ██║ ╚████║██║╚██████╗██║  ██╗██║  ██║██║  ██║╚██████╗██║  ██╗██║ ╚═╝ ██║██║  ██║██║ ╚████║
" ╚═╝  ╚═══╝╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
"
" Neovim config
" github.com/NickHackman

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
Plug 'Xuyuanp/nerdtree-git-plugin'

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
Plug 'ekalinin/Dockerfile.vim'
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'javascript.jsx','typescript'], 'do': 'make install' }

Plug 'mtth/scratch.vim'
Plug 'edkolev/tmuxline.vim'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Coc Extensions
let g:coc_global_extensions = [
    \ 'coc-go',
    \ 'coc-vimlsp',
    \ 'coc-python',
    \ 'coc-clangd',
    \ 'coc-rust-analyzer',
    \ 'coc-json',
    \ 'coc-prettier',
    \ 'coc-tsserver',
    \ 'coc-spell-checker',
    \ 'coc-highlight',
    \ 'coc-marketplace',
    \ 'coc-gitignore',
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
set foldlevel=0
set signcolumn=yes

let g:scratch_persistence_file = "~/Documents/scratch.md"
let g:scratch_top = 0
let g:scratch_height = 15
let g:scratch_filetype = 'markdown'
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

" {{{ Keybindings
nnoremap <SPACE> <Nop>
let mapleader=" "
map <leader>; <Plug>NERDCommenterToggle('n', 'Toggle')<Cr>
map <leader>x :Scratch<CR>
vmap <Tab> >
vmap <S-Tab> <

" {{{ Navigation

" dir_shortcuts for LookupShortcut
let g:dir_shortcuts = {
    \ 'home': '~',
    \ 'projects': '~/Projects',
    \ 'documents': '~/Documents',
    \ 'downloads': '~/Downloads',
    \ 'pictures': '~/Pictures',
    \ 'nixos': '/etc/nixos/',
    \  'config': '~/.config',
    \ }

" LookupShortcut from g:dir_shortcuts variable use Fzf to list Keys and
" navigate to values based on selected
function! LookupShortcut()
    function! HandleInput(key)
        if empty(a:key)
            return
        endif

        let first = a:key[0]
        exec printf("edit %s/.", g:dir_shortcuts[first])
    endfunction

    call fzf#run({'source': keys(g:dir_shortcuts), 'sink*': function('HandleInput'), 'down': '20%'})
endfunction

nnoremap <leader>w <C-w>
map <leader>t :NERDTreeToggle<CR>
map <leader><CR> :call LookupShortcut()<CR>
map <leader><leader> :call fzf#run({'source': 'fd -uu -E ".git"', 'sink': 'e', 'down': '20%'})<CR>
map <leader>b :Buffers<CR>
map <leader>s :Rg <C-r><C-w><CR>
map <leader>- :e .<CR>
map <leader>fp :call fzf#run({'source': 'fd "" ~/.config/nvim/ -E "plugged"', 'sink': 'e', 'down': '20%'})<CR>
map <leader>, :bprev<CR>
let NERDTreeMapUpdir = '-'
let NERDTreeMapCustomOpen = '<tab>'

" }}}

" {{{ Coc-nvim
let g:NERDCreateDefaultMappings = 0

nnoremap <leader>e :CocDiagnostics<CR>
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>ct <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <leader> <leader>cR <Plug>(coc-rename)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <leader>mp :CocList marketplace<CR>
nmap <leader>gi :CocList gitignore<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

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

" {{{ Markdown keybindings

let s:headersRegexp = '\v^(#|.+\n(\=+|-+)$)'

" ToggleHeader toggles a Fold created by vim-markdown below a Header
function! ToggleHeader()
    let line = line('.')
    if getline(line) =~ s:headersRegexp
        " Move cursor down to possible fold
        call cursor(line + 1, 1)

        if foldclosed(line + 1) == -1
            foldclose
        else
            foldopen
        endif
        call cursor(line, 1)
    endif 
endfunction

augroup Markdown
    autocmd! Markdown
    autocmd FileType markdown map K <Plug>Markdown_OpenUrlUnderCursor
    autocmd FileType markdown nmap <silent> <Tab> :call ToggleHeader()<CR>
augroup end

" }}}

" {{{ Fugitive Keybindings


" Push wraps around Fugitive functionality to automatically to push to the
" remote branch
function! Push(force)
    let head = FugitiveHead('.')
    " HEAD is detached
    if empty(head)
        return
    endif

    let force = ''
    if a:force
        let force = ' --force'
    endif

    function! FugitiveCustomCallback(job, data, type) closure
        let lines = a:data[:-2]
        let output = join(lines, "\n")

        if empty(output)
            echo printf("Git push origin/%s finished", head)
        else
            echo output
        endif

        if &ft == 'fugitive'
            execute 'edit %'
        endif
    endfunction

    let cmd = printf('git push origin %s %s', head, force)

    call jobstart(cmd, {'on_stdout': 'FugitiveCustomCallback', 'stdout_buffered': 1})
endfunction

" Pull wraps around Fugitive functionality to automatically to pull from the
" remote branch
function! Pull()
    let head = FugitiveHead('.')
    " HEAD is detached
    if empty(head)
        return
    endif

    function! FugitiveCustomCallback(job, data, type) closure
        let lines = a:data[:-2]
        echo join(lines, "\n")
        if &ft == 'fugitive'
            execute 'edit %'
        endif
    endfunction

    let repository = expand('%:p:h:h')

    let cmd = printf('git -C %s pull origin %s', repository, head)

    call jobstart(cmd, {'on_stdout': 'FugitiveCustomCallback', 'stdout_buffered': 1})
endfunction

" SelectBranch lists all branches using Fzf to user and calls closure on
" selected.
"
" Parameters:
"
" closure: cref
"   Closure to call when a branch is selected.
"   NOTE: cref is passed a LIST that can be empty
"
" includeHead: bool
"   Whether or not to include the Head branch in the selectable list
"
" includeRemotes: bool
"   Whether or not to include remotes
"
" prompt: string
"   Prompt to display in Fzf
function! SelectBranch(closure, includeHead, includeRemotes, prompt)
    let Closure = a:closure
    let cmd = 'git branch --list'
    if a:includeRemotes
        let cmd = cmd . ' -a'
    endif

    let output = system(cmd)
    let allBranches = split(output)
    let branches = []

    if !a:includeHead
        let index = index(allBranches, '*')

        if index == -1
            return
        endif

        if index == 0
            let branches = allBranches[2:]
        else
            let branches = allBranches[:index - 1] + allBranches[index + 2:]
        endif

    else
        let branches = filter(allBranches, 'v:val != "*"')
    endif

    if empty(branches)
        echom 'No other branches'
        return
    endif

    call fzf#run({'source': branches, 'sink*': a:closure, 'down': '20%', 'options': ['--prompt', a:prompt]})
endfunction

" CheckoutBranch checkout selected branch 
"
" NOTE: callback for SelectBranch
function! CheckoutBranch(branch)
    execute 'Git checkout ' . a:branch[0]
endfunction

" CheckoutCreateBranch create a new branch and checkout the new branch
"
" NOTE: callback for SelectBranch
function! CheckoutCreateBranch(branch)
    if empty(a:branch[0])
        return
    endif

    call inputsave()
    let newBranch = input('[Starting: ' . a:branch[0] . '] Branch to checkout: ')
    call inputrestore()
    silent execute 'Git checkout -b ' . newBranch . ' ' . a:branch[0]
endfunction

" BranchRename callback for SelectBranch
"
" NOTE: callback for SelectBranch
function! BranchRename(branch)
    if empty(a:branch[0])
        return
    endif

    call inputsave()
    let newBranch = input('Rename ' . a:branch[0] . ' to: ')
    call inputrestore()
    execute 'Git branch --move ' . a:branch[0] . ' ' . newBranch
endfunction

" BranchDelete delete a branch
"
" NOTE: callback for SelectBranch
function! BranchDelete(branch)
    if empty(a:branch[0])
        return
    endif

    call inputsave()
    let confirm = input('Delete ' . a:branch[0] . ' [y/N]: ')
    call inputrestore()
    execute 'Git branch --delete ' a:branch[0]
endfunction

function! Merge(branch)
    if empty(a:branch[0])
        return
    endif

    execute printf('Git merge -e %s', a:branch[0])
endfunction

" Open Git repository even in NERDTree
function! OpenGit()
    let path = expand('%')
    if &ft == "nerdtree"
        let path = b:NERDTree.getRoot().path.str()
        execute printf('cd %s', path)
    endif

    execute 'Git'
endfunction

map <leader>gg :call OpenGit()<CR>

" RebaseInteractive given an operation replace the first word with that
" operation.
function! RebaseInteractive(operation)
    let line = getline('.')
    if line[0] == '#' || empty(line)
        return
    endif

    let split = split(line)
    if empty(split)
        return
    endif

    let output = join([a:operation] + split[1:], ' ')
    call setline('.', output)
endfunction

augroup FugitiveRebase
    autocmd! FugitiveRebase

    autocmd FileType gitrebase nmap <buffer> <silent> f :call RebaseInteractive('fixup')<CR>
    autocmd FileType gitrebase nmap <buffer> <silent> e :call RebaseInteractive('edit')<CR>
    autocmd FileType gitrebase nmap <buffer> <silent> p :call RebaseInteractive('pick')<CR>
    autocmd FileType gitrebase nmap <buffer> <silent> d :call RebaseInteractive('drop')<CR>
    autocmd FileType gitrebase nmap <buffer> <silent> r :call RebaseInteractive('reword')<CR>
    autocmd FileType gitrebase nmap <buffer> <silent> s :call RebaseInteractive('squash')<CR>
augroup end
    

augroup Fugitive
    autocmd! Fugitive

    autocmd FileType fugitive map <Tab> =

    " Rebind p to Nop instead of Fugitive's echo
    autocmd FileType fugitive nmap <buffer> <silent> p <Nop>
    autocmd FileType fugitive nmap <buffer> <silent> L :Git log --date='relative' --decorate='short'<CR>

    " Push keybinds
    autocmd FileType fugitive nmap <buffer> <silent> pp :call Push(0)<CR>
    autocmd FileType fugitive nmap <buffer> <silent> pf :call Push(1)<CR>
    autocmd FileType fugitive nmap <buffer> <silent> F  :call Pull()<CR>
    autocmd FileType fugitive nmap <buffer> <silent> m  :call SelectBranch(function('Merge'), 0, 1, 'Merge... ')<CR>

    " Fetch keybinds
    autocmd FileType fugitive nmap <buffer> <silent> ff :Git fetch<CR>
    autocmd FileType fugitive nmap <buffer> <silent> fa :Git fetch --all<CR>
    autocmd FileType fugitive nmap <buffer> <silent> ft :Git fetch --tags<CR>

    " Branch keybinds
    autocmd FileType fugitive nmap <buffer> <silent> bl :call SelectBranch(function('CheckoutBranch'), 0, 1, 'Branch to checkout... ')<CR>
    autocmd FileType fugitive nmap <buffer> <silent> bc :call SelectBranch(function('CheckoutCreateBranch'), 1, 1, 'Creating branch starting from... ')<CR>
    autocmd FileType fugitive nmap <buffer> <silent> bn :call SelectBranch(function('CheckoutCreateBranch'), 1, 1, 'Creating branch starting from... ')<CR>
    autocmd FileType fugitive nmap <buffer> <silent> br :call SelectBranch(function('BranchRename'), 1, 0, 'Rename branch... ')<CR>
    autocmd FileType fugitive nmap <buffer> <silent> bd :call SelectBranch(function('BranchDelete'), 0, 0, 'Delete branch... ')<CR>
augroup end
" }}}
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
