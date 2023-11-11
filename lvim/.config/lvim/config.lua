-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 4 spaces for a tab
vim.opt.softtabstop = 4 -- insert 4 spaces for a tab
vim.opt.relativenumber = true -- relative line numbers
vim.opt.wrap = true -- wrap lines
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = ""
vim.opt.clipboard = ""
vim.opt.showcmd = true


-- Setup Lualine statusline
local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_a = { "mode", }
lvim.builtin.lualine.sections.lualine_b = { components.branch, }
lvim.builtin.lualine.sections.lualine_c = { components.diff, components.python_env, components.filename, }
lvim.builtin.lualine.sections.lualine_x = { components.diagnostics, components.lsp, components.filetype, }
lvim.builtin.lualine.sections.lualine_y = { components.location, }
lvim.builtin.lualine.sections.lualine_z = { components.progress, }


-- Setup useful functions
vim.cmd('source ~/.config/lvim/user.vim')


-- Add extra plugins
lvim.plugins = {
  { "octol/vim-cpp-enhanced-highlight" },
  { "zhimsel/vim-stay" }
}


-- add `svls` to `skipped_servers` list
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "svls" })
-- remove `svlangserver` from `skipped_servers` list
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "svlangserver"
end, lvim.lsp.automatic_configuration.skipped_servers)
