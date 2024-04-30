local M = {}

M.input = {
	enabled = true,
	default_prompt = "Input",
	trim_prompt = true,
	title_pos = "left",

	-- When true, <Esc> will close the modal
	insert_only = true,
	-- When true, input will start in insert mode.
	start_in_insert = true,

	border = "rounded",
	relative = "cursor",

	prefer_width = 40,
	width = nil,
	max_width = { 140, 0.9 },
	min_width = { 20, 0.2 },

	buf_options = {},
	win_options = {
		wrap = false,
		list = true,
		listchars = "precedes:…,extends:…",
		sidescrolloff = 0,
	},

	mappings = {
		n = {
			["<Esc>"] = "Close",
			["<CR>"] = "Confirm",
		},
		i = {
			["<C-c>"] = "Close",
			["<CR>"] = "Confirm",
			["<Up>"] = "HistoryPrev",
			["<Down>"] = "HistoryNext",
		},
	},
}

M.select = {
	enabled = true,
	backend = { "telescope", "builtin", "nui" },

	trim_prompt = true,
	telescope = require("telescope.themes").get_ivy({}),

	nui = {
		position = "50%",
		size = nil,
		relative = "editor",
		border = {
			style = "rounded",
		},
		buf_options = {
			swapfile = false,
			filetype = "DressingSelect",
		},
		win_options = {
			winblend = 0,
		},
		max_width = 80,
		max_height = 40,
		min_width = 40,
		min_height = 10,
	},

	builtin = {
		show_numbers = true,
		border = "rounded",
		relative = "editor",

		buf_options = {},
		win_options = {
			cursorline = true,
			cursorlineopt = "both",
		},

		width = nil,
		max_width = { 140, 0.8 },
		min_width = { 40, 0.2 },
		height = nil,
		max_height = 0.9,
		min_height = { 10, 0.2 },

		mappings = {
			["<Esc>"] = "Close",
			["<C-c>"] = "Close",
			["<CR>"] = "Confirm",
		},
	},
}

return M
