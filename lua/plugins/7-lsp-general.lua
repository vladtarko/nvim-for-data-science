return {

	-- SECTION: mason-lspconfig.nvim (set up mason and ensure servers are installed)
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = {
			ensure_installed = {
				-- "r_language_server",
				"marksman",
				"rust_analyzer",
				"pyright",
				"lua_ls",
				-- "air",
			},
			automatic_installation = true,
		},
		config = function(_, opts)
			require("mason").setup()

			-- Capabilities for nvim-cmp
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			require("mason-lspconfig").setup({
				ensure_installed = opts.ensure_installed,
				automatic_installation = opts.automatic_installation,
				handlers = {
					function(server_name) -- default handler
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
					-- ["pyright"] = function()
					-- 	require("lspconfig").pyright.setup({
					-- 		capabilities = capabilities,
					-- 	})
					-- end,
					-- ["air"] = function()
					-- 	require("lspconfig").air.setup({
					-- 		on_attach = function(_, bufnr)
					-- 			vim.api.nvim_create_autocmd("BufWritePre", {
					-- 				buffer = bufnr,
					-- 				callback = function() vim.lsp.buf.format() end,
					-- 			})
					-- 		end,
					-- 	})
					-- end,
					-- ["r_language_server"] = function()
					-- 	require("lspconfig").r_language_server.setup({
					-- 		on_attach = function(client, _)
					-- 			client.server_capabilities.documentFormattingProvider = false
					-- 			client.server_capabilities.documentRangeFormattingProvider = false
					-- 		end,
					-- 	})
					-- end,
				},
			})
		end,
	},

	-- vscode-like pictograms for lsp completion items
	"onsails/lspkind.nvim",

	-- SECTION: formatter
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- quarto = { "injected" },
				-- rmd = { "injected" },
				-- r = { "air" },
			},
			formatters = {
				stylua = {
					prepend_args = { "--column-width", "120", "--collapse-simple-statement", "FunctionOnly" },
				},
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = false, --"fallback",
			},
		},
	},
}
