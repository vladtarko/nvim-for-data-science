return {

	{
		"R-nvim/R.nvim",
		-- Only required if you also set defaults.lazy = true
		lazy = false,
		-- R.nvim is still young and we may make some breaking changes from time
		-- to time (but also bug fixes all the time). If configuration stability
		-- is a high priority for you, pin to the latest minor version, but unpin
		-- it and try the latest version before reporting an issue:
		-- version = "~0.1.0"
		config = function()
			-- Create a table with the options to be passed to setup()
			---@type RConfigUserOpts
			local opts = {
				hook = {
					on_filetype = function()
						vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
						vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
					end,
				},
				pdfviewer = "evince",
				R_args = { "--quiet", "--no-save" },
				min_editor_width = 72,
				rconsole_width = 78,
				objbr_mappings = { -- Object browser keymap
					c = "class", -- Call R functions
					h = "head({object}, n = 15)", -- Use {object} notation to write arbitrary R code.
					u = "unique",
					s = "summary",
					t = "tail({object}, n = 15)",
					g = "dplyr::glimpse",
					v = "vd_view",
				},
				disable_cmds = {
					"RClearConsole",
					"RCustomStart",
					"RSPlot",
					"RSaveClose",
				},
				-- location of the help panel
				nvimpager = "tab", -- "split_v", "split_h", "tab", "no"
				-- location of object browser
				objbr_place = "console,above",
				objbr_opendf = false, -- Show data.frames elements
				objbr_openlist = false, -- Show lists elements
				-- open R console in external terminal window
				-- external_term = "kitten @ --to unix:/tmp/kitty_sock launch --type window --location=vsplit --keep-focus --cwd=current",
			}
			-- Check if the environment variable "R_AUTO_START" exists.
			-- If using fish shell, you could put in your config.fish:
			-- alias r "R_AUTO_START=true nvim"
			if vim.env.R_AUTO_START == "true" then
				opts.auto_start = "on startup"
				opts.objbr_auto_start = true
			end
			require("r").setup(opts)
		end,
	},

	-- r autocomplete (better than the lsp)
	-- "jalvesaq/cmp-nvim-r",
	{
		"R-nvim/cmp-r",
		{
			"hrsh7th/nvim-cmp",
			config = function()
				require("cmp").setup({
					sources = {
						{ name = "cmp_r" },
						{ name = "path" },
					},
				})
				require("cmp_r").setup({})
			end,
		},
	},

	-- air autoformatter is defined in lsp-general.lua
}
