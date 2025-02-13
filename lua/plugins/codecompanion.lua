return {
	"olimorris/codecompanion.nvim",
	cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat" },
	keys = {
		{
			"<leader>aa",
			"<cmd>CodeCompanionActions<cr>",
			mode = { "n", "v" },
			desc = "AI actions",
			noremap = true,
			silent = true,
		},
		{
			"<leader>ac",
			"<cmd>CodeCompanionChat<cr>",
			mode = { "n", "v" },
			desc = "AI Chat",
			noremap = true,
			silent = true,
		},
		{
			"<leader>ap",
			"<cmd>CodeCompanion<cr>",
			desc = "AI Prompt",
			noremap = true,
			silent = true,
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("codecompanion").setup({
			display = {
				chat = {
					render_headers = false,
				},
				diff = {
					provider = "default",
				},
			},
			strategies = {
				chat = {
					adapter = "ollama",
				},
				inline = {
					adapter = "ollama",
				},
			},
			adapters = {
				chat = require("codecompanion.adapters").extend(
					"ollama",
					{ schema = { model = { default = "phi4" } } }
				),
				inline = require("codecompanion.adapters").extend(
					"ollama",
					{ schema = { model = { default = "phi4" } } }
				),
			},
		})
	end,
}
