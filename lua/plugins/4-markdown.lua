return {
	-- align helper
	"godlygeek/tabular",

	"preservim/vim-markdown",

	-- zen mode, centered layout
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

	{
		"jalvesaq/zotcite",
		dependencies = {
			"nvim-telescope/telescope.nvim", -- if you want telescope integration
			"nvim-treesitter/nvim-treesitter", -- optional but recommended
		},
		config = function() require("zotcite").setup({}) end,
	},

	{
		"vpratz/zotcite-betterbibtex",
	},

	{
		"jalvesaq/cmp-zotcite",
		dependencies = { "jalvesaq/zotcite", "vpratz/zotcite-betterbibtex" }, -- ensure zotcite loads first
		opts = {},
	},

	-- -- Pandoc
	-- "vim-pandoc/vim-pandoc",
	-- -- Pandoc syntax (more trouble than it's worth)
	-- "vim-pandoc/vim-pandoc-syntax",

	-- for image support
	-- imagemagick needs to be installed on your system
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			image = {
				magick_args = {
					svg = function(input, output) return { "magick", input, output } end,
				},
				math = { enabled = false },
			},
		},
	},

	{
		"Thiago4532/mdmath.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			-- Filetypes that the plugin will be enabled by default.
			filetypes = { "markdown", "rmd", "quarto" },
			-- Color of the equation, can be a highlight group or a hex color.
			foreground = "Normal", -- Examples: 'Normal', '#ff0000'
			anticonceal = false, -- Set true to hide the text when the equation is under the cursor.
			hide_on_insert = true, -- Hide the text when in the Insert Mode.
			dynamic = true, -- Enable dynamic size for non-inline equations.
			dynamic_scale = 0.5, -- Configure the scale of dynamic-rendered equations.
			update_interval = 400, -- Interval between updates (milliseconds).
			-- Internal scale of the equation images, increase to prevent blurry images when increasing terminal
			-- font, high values may produce aliased images.
			-- WARNING: This do not affect how the images are displayed, only how many pixels are used to render them.
			--          See `dynamic_scale` to modify the displayed size.
			internal_scale = 1.0,
		},

		-- The build is already done by default in lazy.nvim, so you don't need
		-- the next line, but you can use the command `:MdMath build` to rebuild
		-- if the build fails for some reason.
		-- build = ':MdMath build'
	},
}
