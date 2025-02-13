return {
	{
		"gbprod/nord.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = false,
			terminal_colors = true,

			diff = { mode = "bg" },

			borders = true,

			errors = { mode = "bg" },

			search = { theme = "vscode" },

			styles = {
				comments = { italic = true },
				keywords = {},
				functions = {},
				variables = {},

				bufferline = {
					current = {},
					modified = { italic = true },
				},
			},
		},
		config = function(_, opts)
			require("nord").setup(opts)
			vim.cmd.colorscheme("nord")
		end,
	},

	{
		"dgagn/diagflow.nvim",
		event = "LspAttach",
		opts = {},
	},

	{
		"folke/todo-comments.nvim",
		event = "BufEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	{
		"j-hui/fidget.nvim",
		event = "VeryLazy",
		opts = {
			progress = {
				suppress_on_insert = true,
			},
			notification = {
				override_vim_notify = true,
				window = {
					normal_hl = "Normal",
				},
			},
		},
	},

	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "BufEnter",
		init = function()
			vim.g.rainbow_delimiters = {
				highlight = {
					"RainbowDelimiterCyan",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterRed",
				},
			}
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		event = "BufEnter",
		opts = { user_default_options = { names = false } },
		config = function(_, opts)
			require("colorizer").setup(opts)

			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)
		end,
	},
}
