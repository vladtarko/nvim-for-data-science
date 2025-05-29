return {
	"godlygeek/tabular",
	"preservim/vim-markdown",

	-- zen mode, centered layout
	-- "junegunn/goyo.vim",
	-- "folke/zen-mode.nvim",
	"shortcuts/no-neck-pain.nvim",

	-- spelling errors displayed as diagnostics
	{
		"ravibrock/spellwarn.nvim",
		event = "VeryLazy",
		config = true,
	},

	-- soft wraps for specific file types
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
			notify_on_switch = false,
		},
	},

	-- fancy look for markdown files in normal mode
	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
		-- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
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

	-- -- Pandoc
	-- "vim-pandoc/vim-pandoc",
	-- -- Pandoc syntax (more trouble than it's worth)
	-- "vim-pandoc/vim-pandoc-syntax",

	-- for image support
	-- imagemagick needs to be installed on your system
	-- lazy.nvim
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			image = {
				-- Use Inkscape for SVG conversion
				magick_args = {
					svg = function(input, output)
						return {
							"magick",
							input,
							output,
						}
					end,
				},
			},
		},
	},
}
