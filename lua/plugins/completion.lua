return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = {
		"nvim-web-devicons",

		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
			config = function(_, opts)
				require("luasnip").setup(opts)

				require("luasnip.loaders.from_vscode").lazy_load({ exclude = vim.g.vscode_snippets_exclude or {} })
				require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

				vim.api.nvim_create_autocmd("InsertLeave", {
					callback = function()
						if
							require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
							and not require("luasnip").session.jump_active
						then
							require("luasnip").unlink_current()
						end
					end,
				})
			end,
		},

		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			opts = {
				disable_filetype = {
					"TelescopePrompt",
					"spectre_panel",
					"oil",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"NeogitStatus",
				},
			},
		},
	},
	opts = {
		keymap = {
			preset = "none",

			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<C-e>"] = { "cancel", "fallback" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },

			cmdline = {
				["<CR>"] = {},
			},
		},
		completion = {
			list = { selection = { preselect = false, auto_insert = true } },
			trigger = { show_in_snippet = false },
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "normal",
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				codecompanion = { "codecompanion" },
			},
			cmdline = {},
		},
		signature = { enabled = true },
		snippets = { preset = "luasnip" },
	},
	opts_extend = { "sources.default" },
}
