let s:headersRegexp = '\v^(#|.+\n(\=+|-+)$)'

" ToggleHeader toggles a Fold created by vim-markdown below a Header
function! ToggleHeader()
    let l:line = line('.')
    if getline(l:line) =~ s:headersRegexp
        " Move cursor down to possible fold
        call cursor(l:line + 1, 1)

        if foldclosed(l:line + 1) == -1
            foldclose
        else
            foldopen
        endif
        call cursor(l:line, 1)
    endif 
endfunction

map K <Plug>Markdown_OpenUrlUnderCursor

nmap <silent> <Tab> :call ToggleHeader()<CR>
