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

		r = { "trim_whitespace", "trim_newlines", "format_r" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},

	formatters = {
		format_r = {
			command = "Rscript",
			args = {
				"-e",
				"formatR::tidy_source(text = readLines('stdin'), arrow = TRUE, blank = TRUE, comment = TRUE, wrap = FALSE, args.newline = TRUE, indent = 2, width.cutoff = 60)",
			},
			stdin = true,
		},
	},
}

require("conform").setup(options)
