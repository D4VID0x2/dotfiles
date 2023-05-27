let mapleader=" "
set timeout timeoutlen=3000

set mouse=
syntax on

set nocompatible
set noerrorbells
set number
set relativenumber
set incsearch
set ignorecase
set smartcase
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
    Plug 'zhimsel/vim-stay' " Stay at my cursor

    " Colorthemes
    Plug 'morhetz/gruvbox'
    Plug 'navarasu/onedark.nvim'

    " Fuzzy file search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy file finder
    Plug 'junegunn/fzf.vim'
    Plug 'chengzeyi/fzf-preview.vim' " fzf preview for more things
    Plug 'airblade/vim-rooter'

    " Show git modifications to file
    "Plug 'vim-scripts/vim-gitgutter'

    Plug 'duane9/nvim-rg'

    Plug 'sbdchd/vim-run' " run current file

    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'nicwest/vim-http' " Simple wrapper over curl and http syntax highlighting.
    Plug 'tpope/vim-markdown' " Markdown syntax highlighting

    " LSP:
    " Collection of common configurations for the Nvim LSP client
    Plug 'neovim/nvim-lspconfig'
    " Optional
    Plug 'williamboman/nvim-lsp-installer' " Automaticlly install language server
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-telescope/telescope.nvim'

    Plug 'hrsh7th/nvim-cmp' " Autocompletion framework
    Plug 'hrsh7th/cmp-nvim-lsp' " cmp LSP completion
    Plug 'hrsh7th/cmp-path' " cmp Path completion
    Plug 'hrsh7th/cmp-buffer'
    Plug 'saadparwaiz1/cmp_luasnip' " Snippets
    Plug 'L3MON4D3/LuaSnip'

    Plug 'stevearc/aerial.nvim' " Code outline window


    " Adds extra functionality over rust analyzer
    Plug 'simrat39/rust-tools.nvim'

    " Better python sytax highlighting
    Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

    " LaTeX support
    " Plug 'vim-latex/vim-latex'

call plug#end()



" COLORSCHEME:
colorscheme gruvbox
set background=dark



" PLUGIN CONFIGURATION:
" run current file plugin
let g:run_cmd_python = ['python3']
let g:run_split = 'right'

" HTTP
let g:vim_http_split_vertically = 1

" Markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'xml', 'javascript', 'json', 'asm', 'cs', 'c', 'cpp']
let g:markdown_minlines = 100

" Vim rooter
"let g:rooter_manual_only = 1
let g:rooter_patterns = ['_darcs', '.hg', '.bzr', '.svn', '*.csproj', '*.sln', 'Makefile', 'package.json', '.git']

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'


" LSP:
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect,preview

" Avoid showing extra messages when using completion
"set shortmess+=c

lua <<EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v<cmd>lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>=', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)

end

require("nvim-lsp-installer").setup {
    automatic_installation = true
}

require('rust-tools').setup({})

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup language servers
local nvim_lsp = require('lspconfig')
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'omnisharp', 'html', 'cssls', 'texlab', 'gopls', 'tsserver'}
for _, server in ipairs(servers) do
  local config = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server == "omnisharp" then
    local pid = vim.fn.getpid()
    local omnisharp_bin = '~/.local/share/nvim/lsp_servers/omnisharp/omnisharp/OmniSharp'
    config.cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }
  end

  nvim_lsp[server].setup(config)
end

-- luasnip setup
local luasnip = require 'luasnip'

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    -- Add tab support
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

require('aerial').setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '[m', '<cmd>AerialPrev<CR>', {buffer = bufnr})
    vim.keymap.set('n', ']m', '<cmd>AerialNext<CR>', {buffer = bufnr})
  end
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
EOF

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes





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

autocmd BufNewFile,BufRead *.pde set syntax=java
autocmd BufNewFile,BufRead *.pde set filetype=java
autocmd BufNewFile,BufRead *.ino set syntax=arduino
autocmd BufNewFile,BufRead *.ino set filetype=arduino

autocmd BufNewFile *.* :call Hashbang(1,1,0)



" REMAPPING:

nnoremap <leader>rr :Run <CR>

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

nnoremap <silent> <leader>fg :GFiles<CR>
nnoremap <silent> <leader>ff :Files<CR>

vnoremap <leader>p "_dP



" MUST HAVE VIM REMAPS:

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

