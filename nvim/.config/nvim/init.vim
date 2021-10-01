
let mapleader=" "
set timeout timeoutlen=2000

set mouse=
syntax on

set noerrorbells
set number
set relativenumber
set incsearch
set ignorecase
set ruler
set noswapfile
set splitright
set splitbelow
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set nohlsearch
set cursorline


call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'scrooloose/nerdcommenter'
    Plug 'preservim/nerdtree'

    Plug 'morhetz/gruvbox' " themes
    Plug 'sonph/onehalf'

    " Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'} " vim training game

    " Fuzzy file search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy file finder
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter' " addon for fzf, for git projects

    " Plug 'ycm-core/YouCompleteMe' 
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Python syntax highlight
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    " Plug 'davidhalter/jedi-vim'

    " Coc Snippets
    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'

    " Show git modifications to file
    Plug 'vim-scripts/vim-gitgutter'

    Plug 'jremmen/vim-ripgrep' " Rg uses word under cursor

    " run current file
    Plug 'sbdchd/vim-run'

    " HTTP
    Plug 'nicwest/vim-http'


    " .NET C#
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'dense-analysis/ale'



    " Markdown
    " Plug 'plasticboy/vim-markdown'
    " Plug 'kamikat/vim-markdown'
    Plug 'tpope/vim-markdown'

call plug#end()



colorscheme gruvbox
"colorscheme onehalfdark let g:airline_theme='onehalfdark'
set background=dark

:set inccommand=nosplit " highlight substitude

let g:rooter_manual_only = 1

" run current file plugin
let g:run_cmd_python = ['python3']
let g:run_split = 'right'


"fun! SetupYCM()
    "nnoremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
    "nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
    "nnoremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<CR>
    "let g:UltiSnipsExpandTrigger="<c-space>"
"endfun




" CoC

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

fun! SetupCoC()
    inoremap <buffer> <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    inoremap <buffer> <silent><expr> <C-space> coc#refresh()

    nmap <buffer> <leader>gd <Plug>(coc-definition)
    nmap <buffer> <leader>gr <Plug>(coc-references)
    nmap <buffer> <leader>gy <Plug>(coc-type-definition)
    nmap <buffer> <leader>gi <Plug>(coc-implementation)
    nmap <buffer> <leader>rn <Plug>(coc-rename)
endfun

let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-prettier',
    \ 'coc-json',
    \ 'coc-pyright',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-xml',
    \ 'coc-yaml',
    \ 'coc-lua',
    \ ]

autocmd BufNewFile,BufRead *.pde set syntax=java
autocmd BufNewFile,BufRead *.pde set filetype=java
autocmd BufNewFile,BufRead *.ino set syntax=arduino
autocmd BufNewFile,BufRead *.ino set filetype=arduino

" run python script
" autocmd BufNewFile,BufRead *.py nnoremap <C-S-R> :vs <CR> :term python % <CR>

nnoremap <leader>rr :Run <CR>

" autocmd FileType java,typescript,go :call SetupYCM()

autocmd FileType cpp,h,c,html,css,js,djangohtml,py,sh,lua,php :call SetupCoC()
" call SetupCoC()



" CoC snippet tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"




" Shebang line
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
        \     'py': "python",
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
		let line =  "#! /usr/bin/env " . fileshell 
	else 
		let line = "#! " . system("which " . fileshell)
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

:autocmd BufNewFile *.* :call Hashbang(1,1,0)


" HTTP
let g:vim_http_split_vertically = 1





" .NET C#
" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview', 'popup'
" and 'popuphidden' if you don't want to see any documentation whatsoever.
" Note that neovim does not support `popuphidden` or `popup` yet:
" https://github.com/neovim/neovim/issues/10996
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  " Highlight the completion documentation popup background/foreground the same as
  " the completion menu itself, for better readability with highlighted
  " documentation.
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
  set previewheight=5
endif

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
"let g:ale_linters = { 'cs': ['OmniSharp'] }

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> <Leader>gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>gu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>gi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>oscc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>rn <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)

  "autocmd FileType cs nmap <silent> <buffer> <F5>:vs | term dotnet run
  autocmd FileType cs nmap <buffer> <Leader>run :vs<CR>:w<CR>:term dotnet run<CR>

augroup END


let g:OmniSharp_selector_ui = 'fzf'    " Use fzf
let g:OmniSharp_selector_findusages = 'fzf'

let g:OmniSharp_highlighting = 3 " Highlight in insert mode

let g:OmniSharp_highlight_groups = {
\ 'Comment': 'NonText',
\ 'XmlDocCommentName': 'Identifier',
\ 'XmlDocCommentText': 'NonText'
\}

let g:OmniSharp_popup_options = {
\ 'winblend': 30,
\ 'winhl': 'Normal:Normal'
\}

" Enable snippet completion, using the ultisnips plugin
let g:OmniSharp_want_snippet=1






" Markdown

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'xml', 'javascript', 'json', 'asm']
let g:markdown_minlines = 100




" disable spacebar (don't move forward)
nnoremap <SPACE> <Nop>

" quickly move through panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" resize panes
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <silent> <leader>* :resize +5<CR>
nnoremap <silent> <leader>/ :resize -5<CR>

nnoremap <silent> <leader>fgf :GFiles<CR>
nnoremap <silent> <leader>ff :Files<CR>

vnoremap <leader>p "_dP

inoremap <C-/>:call NERDComment(0,"toggle")<CR>
nnoremap <C-/>:call NERDComment(0,"toggle")<CR>



" MUST HAVE VIM REMAPS
" https://youtu.be/hSHATqh8svM

" Number 5: Behave Vim
nnoremap Y y$ 

" Number 4: Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
" nnoremap J mzJ`z

" Number 3: Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
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
inoremap <C-j> :m .+1<CR>==
inoremap <C-k> :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==


vnoremap < <gv
vnoremap > >gv

" vnoremap <S-Tab> <gv
" vnoremap <Tab> >gv
