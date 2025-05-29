return {
	"godlygeek/tabular",
	"preservim/vim-markdown",
	"junegunn/goyo.vim",
	"shortcuts/no-neck-pain.nvim",
	-- spelling errors displayed as diagnostics
	{
		"ravibrock/spellwarn.nvim",
		event = "VeryLazy",
		config = true,
	},
	-- "folke/zen-mode.nvim",
	{
		"andrewferrier/wrapping.nvim",
		opts = {
			softener = {
				markdown = true,
				rmd = true,
				quarto = true,
			},
			auto_set_mode_filetype_allowlist = {
				"markdown",
				"rmd",
				"quarto",
				-- add other filetypes as needed
			},
			create_keymaps = false,
		},
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
		-- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			heading = { position = "inline", border = true },
			paragraph = { enabled = false },
			quote = { repeat_linebreak = false, icon = "" },
			latex = { enabled = false },
			pipe_table = { preset = "round" },
		},
	},

	-- Pandoc
	-- "vim-pandoc/vim-pandoc",
	-- -- Pandoc syntax
	-- "vim-pandoc/vim-pandoc-syntax",
}
