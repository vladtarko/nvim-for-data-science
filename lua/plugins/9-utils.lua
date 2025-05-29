return {
	{
		"AckslD/messages.nvim",
		opts = {
			prepare_buffer = function(opts)
				local buf = vim.api.nvim_create_buf(false, true)
				vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = buf })
				return vim.api.nvim_open_win(buf, true, opts)
			end,
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			keywords = {
				SECTION = { icon = "§", color = "info", alt = { "SEC", "CHAPTER" } },
			},
			pattern = [[.*(--#%s*(SECTION|SEC|CHAPTER)):?]],
		},
	},
}
