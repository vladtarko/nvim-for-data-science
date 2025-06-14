-- general nvim options
require("options")

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load all lua files from lua/plugins folder in alphabetical order
require("lazy").setup({ { import = "plugins" } }, { change_detection = { enabled = false } })

-- theme
vim.cmd.colorscheme("tokyonight")

require("keymaps")
