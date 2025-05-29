-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- put the status line at the very bottom
vim.o.cmdheight = 0

-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

-- wrap long lines
vim.opt.wrap = false

-- when wrapping, don't split words
vim.opt_local.linebreak = true

-- spellcheck
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown", "rmd", "quarto" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
	end,
})

-- left move at beginning of line moves to end
-- of previous line; right move at end of line
-- moves to beginning of next line
vim.opt.whichwrap:append({
	["<"] = true,
	[">"] = true,
	["["] = true,
	["]"] = true,
	h = true,
	l = true,
})

-- no vim backups
vim.opt.swapfile = false
vim.opt.backup = false

-- search options
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.opt.termguicolors = true

-- scrolling without going all the way up or down
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- keep the cursor in the center of the screen
-- vim.opt.scrolloff = 999

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = "unnamedplus"

-- make pop-ups and diagnostics respond faster
vim.opt.updatetime = 50

-- wait times for shortcuts key sequences
vim.o.timeout = true
vim.o.timeoutlen = 200

-- creates transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- folds by expression
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- folds start out open:
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
