---@class mkv.config
---
---@field experimental config.experimental | fun(): config.experimental
---@field highlight_groups { [string]: config.hl } | fun(): { [string]: config.hl }
---@field html config.html | fun(): config.html
---@field latex config.latex | fun(): config.latex
---@field markdown config.markdown | fun(): config.markdown
---@field markdown_inline config.markdown_inline | fun(): config.markdown_inline
---@field preview config.preview | fun(): config.preview
---@field renderers config.renderer[] | fun(): config.renderer[]
---@field typst config.typst | fun(): config.typst
---@field yaml config.yaml | fun(): config.yaml
local options = {
	preview = {
		enable = true,
		filetypes = { "md", "rmd", "quarto", "codecompanion" },
		ignore_buftypes = { "nofile" },
		ignore_previews = {},

		modes = { "n", "no", "c" },
		hybrid_modes = {},
	},
	markdown = {
		enable = true,
	},
	markdown_inline = {
		enable = true,
	},
	typst = {
		enable = true,
	},
	yaml = {
		enable = true,
	},
}

return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	dependencies = {
		"gbprod/nord.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = options,
}
