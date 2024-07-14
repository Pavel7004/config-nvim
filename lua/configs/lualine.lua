local M = {}

M.options = {
	icons_enabled = true,
	theme = "nord",
	component_separators = { left = "", right = "" },
	section_separators = { left = "", right = "" },
	disabled_filetypes = {
		statusline = {
			"Trouble",
			"trouble",
			"lazy",
			"toggleterm",
			"mason",
		},
		winbar = {},
	},
	ignore_focus = {},
	always_divide_middle = true,
	globalstatus = false,
	refresh = {
		statusline = 1000,
		tabline = 1000,
		winbar = 1000,
	},
}

M.sections = {
	lualine_a = { "mode" },
	lualine_b = { "filename" },
	lualine_c = { "location" },
	lualine_x = {
		"searchcount",
		"branch",
	},
	lualine_y = {
		"diff",
		"diagnostics",
		"encoding",
	},
	lualine_z = {
		"filetype",
	},
}

M.inactive_sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = { "filename" },
	lualine_x = { "location" },
	lualine_y = {},
	lualine_z = {},
}

M.tabline = {}

M.winbar = {}
M.inactive_winbar = {}

M.extensions = {
	"quickfix",
	"oil",
	"nvim-dap-ui",
	"man",
}

return M
