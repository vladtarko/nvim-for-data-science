return {

	-- SECTION: THEMES ------------------------------------------
	{
		"AlexvZyl/nordic.nvim",
		as = "nordic",
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	{
		"rmehri01/onenord.nvim",
		as = "onenord",
	},

	-- SECTION: ICONS -----------------------------------------------------------------

	-- "nvim-tree/nvim-web-devicons",

	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	-- SECTION: Pop-up command line ----------------------------------------------------------
	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = {
			{ "MunifTanjim/nui.nvim" },
		},
	},

	-- SECTION: Dashboard --------------------------------------------------------------------
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Set header
			dashboard.section.header.val = {

				-- OPTION 1

				[[                                  __]],
				[[     ___     ___    ___   __  __ /\_\    ___ ___]],
				[[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
				[[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
				[[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
				[[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],

				-- OPTION 2

				-- [[  \ |                  _)       ]],
				-- [[ .  |   -_)   _ \ \ \ / |   ` \ ]],
				-- [[_|\_| \___| \___/  \_/ _| _|_|_|]],

				-- OPTION 3

				-- [[      ___           ___           ___                                    ___     ]],
				-- [[     /__/\         /  /\         /  /\          ___        ___          /__/\    ]],
				-- [[     \  \:\       /  /:/_       /  /::\        /__/\      /  /\        |  |::\   ]],
				-- [[      \  \:\     /  /:/ /\     /  /:/\:\       \  \:\    /  /:/        |  |:|:\  ]],
				-- [[  _____\__\:\   /  /:/ /:/_   /  /:/  \:\       \  \:\  /__/::\      __|__|:|\:\ ]],
				-- [[ /__/::::::::\ /__/:/ /:/ /\ /__/:/ \__\:\  ___  \__\:\ \__\/\:\__  /__/::::| \:\]],
				-- [[ \  \:\~~\~~\/ \  \:\/:/ /:/ \  \:\ /  /:/ /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/]],
				-- [[  \  \:\  ~~~   \  \::/ /:/   \  \:\  /:/  \  \:\|  |:|     \__\::/  \  \:\      ]],
				-- [[   \  \:\        \  \:\/:/     \  \:\/:/    \  \:\__|:|     /__/:/    \  \:\     ]],
				-- [[    \  \:\        \  \::/       \  \::/      \__\::::/      \__\/      \  \:\    ]],
				-- [[     \__\/         \__\/         \__\/           ~~~~                   \__\/    ]],

				-- OPTION 4

				-- [[::::    ::: :::::::::: ::::::::  :::     ::: ::::::::::: ::::    ::::  ]],
				-- [[:+:+:   :+: :+:       :+:    :+: :+:     :+:     :+:     +:+:+: :+:+:+ ]],
				-- [[:+:+:+  +:+ +:+       +:+    +:+ +:+     +:+     +:+     +:+ +:+:+ +:+ ]],
				-- [[+#+ +:+ +#+ +#++:++#  +#+    +:+ +#+     +:+     +#+     +#+  +:+  +#+ ]],
				-- [[+#+  +#+#+# +#+       +#+    +#+  +#+   +#+      +#+     +#+       +#+ ]],
				-- [[#+#   #+#+# #+#       #+#    #+#   #+#+#+#       #+#     #+#       #+# ]],
				-- [[###    #### ########## ########      ###     ########### ###       ### ]],
			}

			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "  > Find file", ":Telescope find_files<CR>"),
				dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
				dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h<cr>"),
				dashboard.button("q", "🗶 > Quit NVIM", ":qa<CR>"),
			}

			-- Send config to alpha
			alpha.setup(dashboard.opts)
		end,
	},

	-- SECTION: Status bar and Tabs ------------------------------------------------------------
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			-- dyplay the status of the R server
			local rstt = {
				{ "-", "#aaaaaa" }, -- 1: ftplugin/* sourced, but nclientserver not started yet.
				{ "S", "#757755" }, -- 2: nclientserver started, but not ready yet.
				{ "S", "#117711" }, -- 3: nclientserver is ready.
				{ "S", "#ff8833" }, -- 4: nclientserver started the TCP server
				{ "S", "#3388ff" }, -- 5: TCP server is ready
				{ "R", "#ff8833" }, -- 6: R started, but nvimcom was not loaded yet.
				{ "R", "#3388ff" }, -- 7: nvimcom is loaded.
			}

			local rstatus = function()
				if not vim.g.R_Nvim_status or vim.g.R_Nvim_status == 0 then
					-- No R file type (R, Quarto, Rmd, Rhelp) opened yet
					return ""
				end
				return rstt[vim.g.R_Nvim_status][1]
			end

			local rsttcolor = function()
				if not vim.g.R_Nvim_status or vim.g.R_Nvim_status == 0 then
					-- No R file type (R, Quarto, Rmd, Rhelp) opened yet
					return { fg = "#000000" }
				end
				return { fg = rstt[vim.g.R_Nvim_status][2] }
			end

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "dracula",
					disabled_filetypes = {
						"NvimTree",
						"alpha",
						"aerial",
						"no-neck-pain",
					},
				},
				-- tabline = {
				-- 	lualine_a = {
				-- 		"buffers",
				-- 	},
				-- 	lualine_z = {
				-- 		"tabs",
				-- 	},
				-- },
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "" }, right_padding = 2 },
					},
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						{
							"filename",
							path = 1,
						},
					},
					lualine_x = { { rstatus, color = rsttcolor }, "filetype" },
					lualine_y = { "progress" },
					lualine_z = {
						{
							"location",
							separator = { right = "" }, -- rounded right
							-- other options
						},
					},
				},
			})
		end,
	},
}
