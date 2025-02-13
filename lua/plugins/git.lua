return {
	{
		"NeogitOrg/neogit",
		keys = {
			{
				"<leader>gg",
				function()
					require("neogit").open()
				end,
				desc = "Open git overview",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			graph_style = "unicode",
			kind = "replace",
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "󰍵" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "│" },
			},

			on_attach = function(bufnr)
				local function opts(desc)
					return { buffer = bufnr, desc = desc }
				end

				local map = vim.keymap.set
				local gs = package.loaded.gitsigns

				map("n", "<leader>gr", gs.reset_hunk, opts("Git Reset hunk"))
				map("n", "<leader>gh", gs.preview_hunk, opts("Git Preview hunk"))
				map("n", "<leader>gb", gs.blame_line, opts("Git Blame line"))
			end,
		},
	},
}
