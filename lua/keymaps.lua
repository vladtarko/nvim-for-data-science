-- SECTION: GENERAL STUFF ---------------------------------------------------------------------

-- save in insert mode and normal mode
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>gi")

-- undo in insert mode
vim.keymap.set("i", "<C-z>", "<Esc>ui")

-- Esc toggles normal/insert modes
vim.keymap.set("n", "<Esc>", "a")

-- exit with C-q
vim.keymap.set("n", "<C-q>", ":q<CR>")
vim.keymap.set("i", "<C-q>", "<Esc>:q<CR>")

-- show messages
vim.keymap.set("n", "<leader>m", ":Messages messages<CR>", { desc = "Show [m]essages" })

-- show diagnostic in a pop-up of error/warning
vim.keymap.set(
	"n",
	"<leader>?",
	function() vim.diagnostic.open_float(nil, { focus = false }) end,
	{ desc = "Show diagnostic in popup" }
)

vim.keymap.set("n", "<leader>dd", "<cmd>TodoTelescope buf=0<CR>", { desc = "List TODOs, NOTEs, TESTs, etc." })

-- SECTION: CLIPBOARD ----------------------------------------------------------------------------

-- copy to system clipboard
vim.keymap.set("n", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })

-- prevent change to copy the changed content to clipboard
vim.keymap.set("n", "c", '"_c', { noremap = true })
vim.keymap.set("n", "C", '"_C', { noremap = true })
-- stop delete from overwriting the clipboard
vim.keymap.set({ "n", "v" }, "d", '"_d')
-- when pasting over a visual selection don't overwrite the clipboard
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })

-- C-A selects all, copies to clipboars, and returns to original position
vim.keymap.set("n", "<C-a>", "mzggVGy`z", { noremap = true, silent = true })
vim.keymap.set("i", "<C-a>", "<Esc>mzggVGy`za", { noremap = true, silent = true })

-- SECTION: TELESCOPE ---------------------------------------------------------------------------

vim.keymap.set("n", "<leader>f", require("telescope.builtin").find_files, { desc = "Find [f]iles" })
vim.keymap.set("n", "<leader>o", require("telescope.builtin").oldfiles, { desc = "Recently [o]pened files" })
vim.keymap.set("n", "<leader>g", require("telescope.builtin").live_grep, { desc = "[g]rep: Search text in files" })
vim.keymap.set("n", "<leader>b", require("telescope.builtin").buffers, { desc = "List [b]uffers" })
vim.keymap.set("n", "<leader>t", require("telescope-tabs").list_tabs, { desc = "List vim [t]abs" })
vim.keymap.set("n", "<C-t>", require("telescope-tabs").go_to_previous, { desc = "Previous tab" })
vim.keymap.set("n", "<leader>H", require("telescope.builtin").help_tags, { desc = "Vim [H]elp files" })
vim.keymap.set("n", "<leader>D", ":Telescope diagnostics<CR>", { desc = "List [D]iagnostics" })

vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzy search in current buffer" })

function SpellCheck()
	require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({
		prompt_title = "",
		layout_config = {
			height = 0.25,
			width = 0.25,
		},
	}))
end
vim.keymap.set("n", "<leader>s", SpellCheck, { desc = "[S]pelling suggestions" })
vim.keymap.set("i", "<C-.>", SpellCheck, { desc = "[S]pelling suggestions" })

-- SECTION: WHICH-KEY --------------------------------------------------------------------------

vim.keymap.set(
	"n",
	"<leader>k",
	function() require("which-key").show({ global = false }) end,
	{ desc = "Buffer local [k]eymaps" }
)

-- define labels for groups
require("which-key").add({
	mode = { "n", "v" },
	{ "<leader>c", group = "[C]ode" },
	{ "<leader>d", group = "[D]ocument" },
	{ "<leader>w", group = "[W]orkspace" },
})

-- SECTION: WIN-SHIFT -- move windows/panes ------------------------------------------------------

vim.keymap.set("n", "<C-w><C-m>", "<Cmd>WinShift<CR>", { desc = "Move windows" })
vim.keymap.set("n", "<C-W>m", "<Cmd>WinShift<CR>", { desc = "Move windows" })
vim.keymap.set("n", "<M-Enter>", "<Cmd>WinShift<CR>", { desc = "Move windows" })

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<c-up>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-down>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-left>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-right>", ":wincmd l<CR>")

vim.keymap.set("t", "<c-up>", "<C-\\><C-n>:wincmd k<CR>")
vim.keymap.set("t", "<c-down>", "<C-\\><C-n>:wincmd j<CR>")
vim.keymap.set("t", "<c-left>", "<C-\\><C-n>:wincmd h<CR>")
vim.keymap.set("t", "<c-right>", "<C-\\><C-n>:wincmd l<CR>")

-- SECTION: FILE TREE ----------------------------------------------------------------------------

--vim.keymap.set("n", "<leader>n", vim.cmd.Ex)
vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>", { desc = "Toggle File Manager" })

-- SECTION: Fine Command Line ---------------------------------------------------------------

vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })

-- SECTION: BARBAR TABS --------------------------------------------------------------------------

-- Move to previous/next
vim.api.nvim_set_keymap("n", "<A-left>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-right>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })

-- SECTION: SEARCH ------------------------------------------------------------------------------

-- keeps cursors in the middle while searching
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })

-- clear highlighting after search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Stop search [h]ighlight" })

-- SECTION: HARPOON ----------------------------------------------------------------------------

-- M- is for Alt-
vim.keymap.set("n", "<M-a>", require("harpoon.mark").add_file)
vim.keymap.set("n", "<M-m>", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<M-1>", function() require("harpoon.ui").nav_file(1) end)
vim.keymap.set("n", "<M-2>", function() require("harpoon.ui").nav_file(2) end)
vim.keymap.set("n", "<M-3>", function() require("harpoon.ui").nav_file(3) end)
vim.keymap.set("n", "<M-4>", function() require("harpoon.ui").nav_file(4) end)
vim.keymap.set("n", "<M-5>", function() require("harpoon.ui").nav_file(5) end)
vim.keymap.set("n", "<M-6>", function() require("harpoon.ui").nav_file(6) end)
vim.keymap.set("n", "<M-7>", function() require("harpoon.ui").nav_file(7) end)

-- SECTION: MARKDOWN stuff -------------------------------------------------------------------

-- toggle Aerial
vim.keymap.set("n", "<leader>do", "<cmd>AerialToggle!<CR>", { desc = "Toggle [D]ocument [O]utline" })

-- toggle centered view
vim.keymap.set("n", "<leader>z", "<cmd>NoNeckPain<CR>", { desc = "[z]en mode: Centered view" })

-- make up/down arrow keys work well with long wrapped lines
-- (adds flicker :/)
vim.keymap.set("i", "<Up>", "<C-o>gk")
vim.keymap.set("i", "<Down>", "<C-o>gj")
vim.keymap.set("n", "<Up>", "gk")
vim.keymap.set("n", "<Down>", "gj")

-- convert to PDF using pandoc
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.keymap.set(
			"n",
			"<leader>dp",
			":!pandoc --citeproc % -o %:r.pdf<CR>",
			{ buffer = true, desc = "Pandoc: Convert Markdown to [P]DF" }
		)
	end,
})

-- convert to Word using pandoc
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.keymap.set(
			"n",
			"<leader>dw",
			":!pandoc --citeproc % -o %:r.docx<CR>",
			{ buffer = true, desc = "Pandoc: Convert Markdown to [W]ord" }
		)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.keymap.set(
			"n",
			"<leader>db",
			":!pandoc --citeproc -t beamer % -o %:r.pdf<CR>",
			{ buffer = true, desc = "Pandoc: Convert Markdown to [B]eamer presentation" }
		)
	end,
})

-- SECTION: R shortcuts ---------------------------------------------------------------------------------------

-- note: some terminals require special customization to allow Ctrl-Shift
-- https://www.reddit.com/r/neovim/comments/mbj8m5/how_to_setup_ctrlshiftkey_mappings_in_neovim_and/

-- pipe and assignment shortcuts
vim.keymap.set("i", "<C-S-m>", " |> ")
vim.keymap.set("i", "<C-S-,>", " <- ")
vim.keymap.set("i", "<C-S-.>", " -> ")

-- Function to view data frame in visidata
-- uses R function defined in .Rprofile
local function vd_view()
	local word = vim.fn.expand("<cword>")
	vim.cmd("RSend vd_view(" .. word .. ")")
end

-- Function to view summary of data frame in visidata
-- uses R function defined in .Rprofile
local function vd_summary()
	local word = vim.fn.expand("<cword>")
	vim.cmd("RSend vd_summary(" .. word .. ")")
end

-- set up keybinds for ".r" files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "r",
	callback = function()
		-- style paragraph
		vim.keymap.set("n", "<localleader>pf", "vip :RFormat<CR>", { desc = "[F]ormat paragraph" })

		vim.keymap.set("n", "<localleader>dv", vd_view, {
			noremap = true,
			silent = true,
			desc = "[V]iew data frame in Visidata",
		})

		vim.keymap.set("n", "<localleader>ds", vd_summary, {
			noremap = true,
			silent = true,
			desc = "View [s]ummary of data frame in Visidata",
		})

		-- mapping to function that runs glipse on a dataframe
		vim.keymap.set(
			"n",
			"<localleader>dg",
			function() vim.cmd("RSend dplyr::glimpse(" .. vim.fn.expand("<cword>") .. ")") end,
			{
				noremap = true,
				silent = true,
				desc = "[g]limpse data frame",
			}
		)
	end,
})

require("which-key").add({
	-- buffer = true,
	mode = { "n", "v" },
	{ "<localleader>b", group = "[B]etween marks" },
	{ "<localleader>c", group = "[C]hunks" },
	{ "<localleader>d", group = "[D]ata" },
	{ "<localleader>f", group = "[F]unctions" },
	{ "<localleader>g", group = "[G]oto" },
	{ "<localleader>i", group = "[I]ron REPL" },
	{ "<localleader>k", group = "[K]nit" },
	{ "<localleader>p", group = "[P]aragraph" },
	{ "<localleader>q", group = "[Q]uarto" },
	{ "<localleader>r", group = "[R] general" },
	{ "<localleader>s", group = "[S]plit or [S]end" },
	{ "<localleader>t", group = "[T]erminal" },
	{ "<localleader>v", group = "[V]iew" },
})

-- SECTION: LSP stuff --------------------------------------------------------------------------------

-- NOTE: Remember that lua is a real programming language, and as such it is possible
-- to define small helper and utility functions so you don't have to repeat yourself
-- many times.
--
-- In this case, we create a function that lets us more easily define mappings specific
-- for LSP related items. It sets the mode, buffer and description for us each time.
local nmap = function(keys, func, desc)
	if desc then
		desc = "LSP: " .. desc
	end

	-- vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	require("which-key").add({
		{
			keys, -- the key sequence (string)
			func, -- the function or command to execute
			desc = desc, -- description for which-key
			buffer = bufnr, -- buffer-local mapping
			mode = "n", -- normal mode
			icon = " ", -- optional: add a Nerd Font icon here
		},
	})
end

nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
nmap("<leader>cd", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
nmap(
	"<leader>ds",
	function()
		require("telescope.builtin").lsp_document_symbols({
			symbol_width = 60,
			layout_config = { prompt_position = "top" },
			sorting_strategy = "ascending",
		})
	end,
	"[D]ocument [S]ymbols"
)
nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

-- See `:help K` for why this keymap
nmap("K", vim.lsp.buf.hover, "Hover Documentation")
nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

-- Lesser used LSP functionality
nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
nmap(
	"<leader>wl",
	function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
	"[W]orkspace [L]ist Folders"
)
