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
set.mouse = ""
set.clipboard = "unnamedplus"
vim.g.mapleader = " "

require("config.lazy")
require("oil").setup()
require("lualine").setup()
require("ibl").setup()
require("mason").setup({
	ui = {
		icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
	},
})

require("catppuccin").setup({
	flavour = "auto",
	transparent_background = false,
	float = {
		transparent = true,
		solid = true,
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
vim.cmd.colorscheme("catppuccin-mocha")

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

require("nvim-treesitter").install({ "c", "lua", "rust" })
require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
	indent = { enable = true },
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start()
	end,
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
	settings = {
		Lua = { diagnostics = { globals = { "vim" } } },
	},
})
