return {

	-- SECTION: file tree ----------------------------------------------------------------------
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			require("nvim-tree").setup({
				view = { width = 30 },
			})
		end,
	},

	-- SECTION: Which-key menus -----------------------------------------------
	--
	-- 'linty-org/key-menu.nvim', -- possible alternative to whichkey

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
		},
		keys = {
			{
				"<leader>k",
				function() require("which-key").show({ global = false }) end,
				desc = "Buffer local [k]eymaps",
			},
		},
	},

	-- save buffers for easy access
	"theprimeagen/harpoon",

	-- tab bar at the top
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function() vim.g.barbar_auto_setup = false end,
		opts = {
			sidebar_filetypes = {
				NvimTree = true,
				["no-neck-pain"] = true,
			},
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},

	-- SECTION: move windows/panes around -----------------------------------------------------------
	{
		"sindrets/winshift.nvim",

		-- table of options passed to require('winshift').setup({})
		opts = {
			highlight_moving_win = true, -- Highlight the window being moved
			focused_hl_group = "Visual", -- The highlight group used for the moving window
			moving_win_options = {
				-- These are local options applied to the moving window while it's
				-- being moved. They are unset when you leave Win-Move mode.
				wrap = false,
				cursorline = false,
				cursorcolumn = false,
				colorcolumn = "",
			},
			keymaps = {
				disable_defaults = false, -- Disable the default keymaps
				win_move_mode = {
					["h"] = "left",
					["j"] = "down",
					["k"] = "up",
					["l"] = "right",
					["H"] = "far_left",
					["J"] = "far_down",
					["K"] = "far_up",
					["L"] = "far_right",
					["<left>"] = "left",
					["<down>"] = "down",
					["<up>"] = "up",
					["<right>"] = "right",
					["<S-left>"] = "far_left",
					["<S-down>"] = "far_down",
					["<S-up>"] = "far_up",
					["<S-right>"] = "far_right",
				},
			},
			---A function that should prompt the user to select a window.
			---The window picker is used to select a window while swapping windows with
			---`:WinShift swap`.
			---@return integer? winid # Either the selected window ID, or `nil` to
			---   indicate that the user cancelled / gave an invalid selection.
			window_picker = function()
				return require("winshift.lib").pick_window({
					-- A string of chars used as identifiers by the window picker.
					picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
					filter_rules = {
						-- This table allows you to indicate to the window picker that a window
						-- should be ignored if its buffer matches any of the following criteria.
						cur_win = true, -- Filter out the current window
						floats = true, -- Filter out floating windows
						filetype = {}, -- List of ignored file types
						buftype = {}, -- List of ignored buftypes
						bufname = {}, -- List of vim regex patterns matching ignored buffer names
					},
					---A function used to filter the list of selectable windows.
					---@param winids integer[] # The list of selectable window IDs.
					---@return integer[] filtered # The filtered list of window IDs.
					filter_func = nil,
				})
			end,
		}, -- end of options table
	},

	-- SECTION: TELESCOPE -----------------------------------------------------------------------------
	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function() return vim.fn.executable("make") == 1 end,
			},
		},
		opts = {
			defaults = {
				layout_config = {
					prompt_position = "top",
				},
				sorting_strategy = "ascending", -- ensures results appear below the prompt
			},
		},
	},

	-- using Telescope to switch tabs
	{
		"LukasPietzschmann/telescope-tabs",
		config = function()
			require("telescope").load_extension("telescope-tabs")
			require("telescope-tabs").setup({})
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
	},

	-- Pop-up notifications and messages -------------------------------------------
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- add any options here
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },

	-- SECTION: Outline in markdown, and symbol outline in programming languages ---------------------------
	{
		"stevearc/aerial.nvim",
		opts = {
			-- optionally use on_attach to set keymaps when aerial has attached to a buffer
			on_attach = function(bufnr)
				-- Jump forwards/backwards with '{' and '}'
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,

			-- Determines how the aerial window decides which buffer to display symbols for
			--   window - aerial window will display symbols for the buffer in the window from which it was opened
			--   global - aerial window will display symbols for the current window
			attach_mode = "window",

			-- Determines where the aerial window will be opened
			--   edge   - open aerial at the far right/left of the editor
			--   window - open aerial to the right/left of the current window
			placement = "edge",

			-- Highlight the symbol in the source buffer when cursor is in the aerial win
			highlight_on_hover = false,

			-- When jumping to a symbol, highlight the line for this many ms.
			-- Set to false to disable
			highlight_on_jump = 1000,

			-- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
			-- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
			-- default collapsed icon. The default icon set is determined by the
			-- "nerd_font" option below.
			-- If you have lspkind-nvim installed, it will be the default icon set.
			-- This can be a filetype map (see :help aerial-filetype-map)
			icons = {
				Array = " ",
				Boolean = "󰨙 ",
				Class = "󰆧 ",
				Constant = "󰏿 ",
				Constructor = " ",
				Enum = " ",
				EnumMember = " ",
				Event = " ",
				Field = " ",
				File = " ",
				Function = "󰊕 ",
				Interface = "󰓏",
				Key = "󰌋 ",
				Method = "󰊕 ",
				Module = " ",
				Namespace = "󰦮 ",
				Null = "󰟢 ",
				Number = "󰎠 ",
				Object = " ",
				Operator = "󰆕 ",
				Package = " ",
				Property = " ",
				String = " ",
				Struct = " ",
				TypeParameter = "󰗴 ",
				Variable = "󰀫 ",
				Collapsed = "󱨧",
			},

			-- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
			-- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
			nerd_font = "auto",

			-- Show box drawing characters for the tree hierarchy
			show_guides = false,

			guides = {
				-- When the child item has a sibling below it
				mid_item = "├─",
				-- When the child item is the last in the list
				last_item = "└─",
				-- When there are nested child guides to the right
				nested_top = "│ ",
				-- Raw indentation
				whitespace = "  ",
			},

			-- Automatically open aerial when entering supported buffers.
			-- This can be a function (see :help aerial-open-automatic)
			open_automatic = false,

			treesitter = {
				-- How long to wait (in ms) after a buffer change before updating
				update_delay = 300,
				-- Experimental feature to navigate to symbol names instead of the declaration
				-- See https://github.com/stevearc/aerial.nvim/issues/279
				-- If no bugs are reported for a time this will become the default
				experimental_selection_range = false,
			},

			markdown = {
				-- How long to wait (in ms) after a buffer change before updating
				update_delay = 300,
			},
		},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}
