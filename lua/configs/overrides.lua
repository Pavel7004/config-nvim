local M = {}

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"c",
		"cpp",
		"markdown",
		"markdown_inline",
		"rust",
		"go",
	},
	indent = {
		enable = true,
	},
}

M.mason = {
	ensure_installed = {},
}

return M
