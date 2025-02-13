return {
	"nvim-neotest/neotest",
	dependencies = {
		"fredrikaverpil/neotest-golang",
		"rouge8/neotest-rust",
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",

		{
			"antoinemadec/FixCursorHold.nvim",
			event = "VeryLazy",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-golang"),
				require("neotest-rust"),
			},
		})
		local opts = function(desc)
			return { desc = desc }
		end
		local map = vim.keymap.set

		map("n", "<leader>tt", function()
			require("neotest").run.run()
		end, opts("Run nearest test"))
		map("n", "<leader>tf", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, opts("Run all tests in file"))
		map("n", "<leader>ta", function()
			require("neotest").run.run(vim.fn.getcwd())
		end, opts("Run all tests in project"))
		map("n", "<leader>ts", function()
			require("neotest").summary.toggle()
		end, opts("Toggle tests summary"))
		map("n", "<leader>to", function()
			require("neotest").output_panel.toggle()
		end, opts("Toggle tests output"))
		map("n", "<leader>td", function()
			require("neotest").run.run({ suite = false, strategy = "dap" })
		end, opts("Debug nearest test"))
	end,
}
