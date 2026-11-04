local set = vim.o
set.cursorline = true
set.number = true
set.relativenumber = true
set.expandtab = true
set.wrap = false
set.swapfile = false
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.mouse = ''
set.clipboard = 'unnamedplus'
vim.g.mapleader = ' '
vim.cmd [[colorscheme catppuccin]]

require("config.lazy")
require("oil").setup()
require('lualine').setup()
require("mason").setup({
  ui = {
    icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" }
  }
})

require('nvim-treesitter').install({ 'c', 'lua', 'rust' })
require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
  indent = { enable = true }
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.lsp.enable('clangd')
vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
  settings = {
    Lua = { diagnostics = { globals = { "vim" } } }
  }
})
