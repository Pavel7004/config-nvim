local M = {}

M.transparent = false

M.terminal_colors = true

M.diff = { mode = "bg" }

M.borders = true

M.errors = { mode = "bg" }

M.search = { theme = "vscode" }

M.styles = {
	comments = { italic = true },
	keywords = {},
	functions = {},
	variables = {},

	bufferline = {
		current = {},
		modified = { italic = true },
	},
}

return M
