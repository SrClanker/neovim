vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.mouse = ''
vim.o.clipboard = 'unnamedplus'
vim.g.mapleader = ' '

require("config.lazy")
require('nvim-treesitter').install({ 'c', 'rust' })
require("oil").setup()
require('lualine').setup()
require("mason").setup({
    ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.lsp.enable('c')
vim.lsp.enable('lua_ls')

vim.api.nvim_create_autocmd('FileType', {
    pattern = { '<filetype>' },
    callback = function() vim.treesitter.start() end,
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = { diagnostics = { globals = { "vim" } } }
  }
})

local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

local telescope = require("telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },
})
