

" Shebang line:
function! Hashbang(portable, permission, RemExt)
    let shells = {
        \    'awk': "awk",
        \     'sh': "bash",
        \     'hs': "runhaskell",
        \     'jl': "julia",
        \    'lua': "lua",
        \    'mak': "make",
        \     'js': "node",
        \      'm': "octave",
        \     'pl': "perl",
        \    'php': "php",
        \     'py': "python3",
        \      'r': "Rscript",
        \     'rb': "ruby",
        \  'scala': "scala",
        \    'tcl': "tclsh",
        \     'tk': "wish"
        \    }

    let extension = expand("%:e")
    if has_key(shells,extension)
        let fileshell = shells[extension]

        if a:portable
            let line =  "#!/usr/bin/env " . fileshell
        else
            let line = "#!" . system("which " . fileshell)
        endif

        0put = line

        if a:permission
            :autocmd BufWritePost * :autocmd VimLeave * :!chmod u+x %
        endif
        if a:RemExt
            :autocmd BufWritePost * :autocmd VimLeave * :!mv % "%:p:r"
        endif
    endif
endfunction




" Automaticly trim all trailing whitespace on save(write)
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()



" AUTOCMD:
autocmd BufNewFile *.* :call Hashbang(1,1,0)



" MUST HAVE VIM REMAPS:

" disable spacebar (don't move forward)
nnoremap <SPACE> <Nop>

vnoremap <leader>p "_dP

" Number 5: Behave Vim
nnoremap Y y$

" Number 4: Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Number 3: Undo break points
inoremap . .<c-g>u
inoremap , ,<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap _ _<c-g>u
inoremap - -<c-g>u
inoremap <space> <space><c-g>u

" Number 2: Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Number 1: Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
vnoremap < <gv
vnoremap > >gv

