local options = {
	lsp_fallback = true,

	formatters_by_ft = {
		lua = { "stylua" },

		javascript = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },

		sh = { "shfmt" },

		latex = { "latexindent" },

		go = { "gofmt", "goimports", "goimports-reviser", "golines" },

		c = { "clang-format" },
		cpp = { "clang-format" },

		rust = { "trim_whitespace", "trim_newlines", "rustfmt" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

require("conform").setup(options)
