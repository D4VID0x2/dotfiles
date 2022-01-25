let mapleader=" "
set timeout timeoutlen=3000

set mouse=
syntax on

set noerrorbells
set number
set relativenumber
set incsearch
set ignorecase
set ruler
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
set scrolloff=4
set inccommand=nosplit " highlight substitude



" PLUGINS:

call plug#begin('~/.config/nvim/autoload/plugged')

    Plug 'scrooloose/nerdcommenter'
    Plug 'preservim/nerdtree'

    Plug 'zhimsel/vim-stay'

    Plug 'morhetz/gruvbox' " themes
    "Plug 'sonph/onehalf'
    Plug 'navarasu/onedark.nvim'

    " Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'} " vim training game

    " Fuzzy file search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy file finder
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter' " addon for fzf, for git projects

    " Plug 'ycm-core/YouCompleteMe'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Better syntax highlighting
    " Python:
    " Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    " Plug 'davidhalter/jedi-vim'

    " C++:
    Plug 'octol/vim-cpp-enhanced-highlight'

    " Snippets
    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'ervandew/supertab'

    " Show git modifications to file
""Plug 'vim-scripts/vim-gitgutter'

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






    " LSP:

    " Collection of common configurations for the Nvim LSP client
    Plug 'neovim/nvim-lspconfig'

    " Autocompletion framework
    Plug 'hrsh7th/nvim-cmp'
    " cmp LSP completion
    Plug 'hrsh7th/cmp-nvim-lsp'
    " cmp Snippet completion
    Plug 'hrsh7th/cmp-vsnip'
    " cmp Path completion
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-buffer'
    " See hrsh7th other plugins for more great completion sources!

    " Adds extra functionality over rust analyzer
    Plug 'simrat39/rust-tools.nvim'

    " Snippet engine
    Plug 'hrsh7th/vim-vsnip'

    " Optional
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " Some color scheme other then default
    Plug 'arcticicestudio/nord-vim'

call plug#end()







" COLORSCHEME:

colorscheme gruvbox
"colorscheme onehalfdark let g:airline_theme='onehalfdark'
set background=dark






let g:rooter_manual_only = 1

" run current file plugin
let g:run_cmd_python = ['python3']
let g:run_split = 'right'

" HTTP
let g:vim_http_split_vertically = 1


" Markdown

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'xml', 'javascript', 'json', 'asm', 'cs']
let g:markdown_minlines = 100





" YouCompleteMe:
fun! SetupYCM()
    nnoremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
    nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
    nnoremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<CR>
    nnoremap <buffer> <silent> <leader>fx :YcmCompleter FixIt<CR>

    " make YCM compatible with UltiSnips (using supertab)
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'

    " better key bindings for UltiSnipsExpandTrigger
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

    let g:ycm_global_ycm_extra_conf = '/home/david/.config/nvim/autoload/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
endfun









" CoC:
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
endfun











" DOTNET:
fun! SetupDotnet()
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

    "augroup omnisharp_commands
      "autocmd!

      " Show type information automatically when the cursor stops moving.
      " Note that the type is echoed to the Vim command line, and will overwrite
      " any other messages in this space including e.g. ALE linting messages.
      autocmd CursorHold *.cs OmniSharpTypeLookup

      " The following commands are contextual, based on the cursor position.
      nmap <silent> <buffer> <Leader>gd <Plug>(omnisharp_go_to_definition)
      nmap <silent> <buffer> <Leader>gu <Plug>(omnisharp_find_usages)
      nmap <silent> <buffer> <Leader>gi <Plug>(omnisharp_find_implementations)
      nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
      nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
      nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
      nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
      nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
      nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
      nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
      imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

      " Navigate up and down by method/property/field
      nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
      nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
      " Find all code errors/warnings for the current solution and populate the quickfix window
      nmap <silent> <buffer> <Leader>oscc <Plug>(omnisharp_global_code_check)
      " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
      nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
      xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
      " Repeat the last code action performed (does not use a selector)
      nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
      xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

      nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

      nmap <silent> <buffer> <Leader>rn <Plug>(omnisharp_rename)

      nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
      nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
      nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)

      "nmap <silent> <buffer> <F5>:vs | term dotnet run
      nmap <buffer> <Leader>run :vs<CR>:w<CR>:term dotnet run<CR>

    "augroup END

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
endfun















" RUST:
" This is an example on how rust-analyzer can be configure using rust-tools
" https://sharksforarms.dev/posts/neovim-rust/

" Prerequisites:
" - neovim >= 0.5
" - rust-analyzer: https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary

" Steps:
" - :PlugInstall
" - Restart
"

function! SetupLSP()
    " Set completeopt to have a better completion experience
    " :help completeopt
    " menuone: popup even when there's only one match
    " noinsert: Do not insert text until a selection is made
    " noselect: Do not select, force user to select one from the menu
    set completeopt=menuone,noinsert,noselect,preview

    " Avoid showing extra messages when using completion
    "set shortmess+=c

    " Configure LSP through rust-tools.nvim plugin.
    " rust-tools will configure and enable certain LSP features for us.
    " See https://github.com/simrat39/rust-tools.nvim#configuration
    lua <<EOF

    -- nvim_lsp object
    local nvim_lsp = require'lspconfig'

    nvim_lsp.rust_analyzer.setup({
        tools = {
            autoSetHints = true,
            hover_with_actions = true,
            runnables = {
                use_telescope = true
            },
            inlay_hints = {
                show_parameter_hints = false,
                parameter_hints_prefix = "",
                other_hints_prefix = "",
            },
        },

        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
        server = {
            -- on_attach is a callback called when the language server attachs to the buffer
            -- on_attach = on_attach,
            filestypes = { "rust" },
            settings = {
                -- to enable rust-analyzer settings visit:
                -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                ["rust-analyzer"] = {
                    -- enable clippy on save
                    checkOnSave = {
                        command = "clippy"
                    },
                }
            }
        },
    })

    require('rust-tools').setup(opts)

    -- nvim_lsp.pylsp.setup({
    --     tools = {
    --         autoSetHints = true,
    --         hover_with_actions = true,
    --         runnables = {
    --             use_telescope = true
    --         },
    --         inlay_hints = {
    --             show_parameter_hints = false,
    --             parameter_hints_prefix = "",
    --             other_hints_prefix = "",
    --         },
    --     },
    -- })
EOF
    autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc

    " Code navigation shortcuts
    " as found in :help lsp
    nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    " nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

    " Quick-fix
    nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

    " Setup Completion
    " See https://github.com/hrsh7th/nvim-cmp#basic-configuration
    lua <<EOF
    local cmp = require'cmp'
    cmp.setup({
      snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })
      },

      -- Installed sources
      sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
      },
    })
EOF

    " have a fixed column for the diagnostics to appear in
    " this removes the jitter when warnings/errors flow in
    set signcolumn=yes

    " Set updatetime for CursorHold
    " 300ms of no cursor movement to trigger CursorHold
    set updatetime=300
    " Show diagnostic popup on cursor hover

    " TODO: bug, focuses popup window
    "autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

    " Goto previous/next diagnostic warning/error
    nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

    "colorscheme nord
endfunction












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






" Automaticly trim all trailing whitespace on save(write)
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()









" AUTOCMD:

autocmd BufNewFile,BufRead *.pde set syntax=java
autocmd BufNewFile,BufRead *.pde set filetype=java
autocmd BufNewFile,BufRead *.ino set syntax=arduino
autocmd BufNewFile,BufRead *.ino set filetype=arduino

autocmd BufNewFile *.* :call Hashbang(1,1,0)

" run python script
" autocmd BufNewFile,BufRead *.py nnoremap <C-S-R> :vs <CR> :term python % <CR>

nnoremap <leader>rr :Run <CR>

autocmd FileType java,typescript,go,cpp,h,c,pde :call SetupYCM()

autocmd FileType html,css,js,djangohtml,py,sh,lua,php :call SetupCoC()

autocmd FileType cs :call SetupDotnet()

" autocmd FileType rust :call SetupRust()

:call SetupLSP()





" REMAPPING:


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












" MUST HAVE VIM REMAPS:
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

