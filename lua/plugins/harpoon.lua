return {
	"ThePrimeagen/harpoon",
	event = "VeryLazy",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local map = vim.keymap.set
		local harpoon = require("harpoon")
		local harpoon_extensions = require("harpoon.extensions")

		harpoon:setup()
		harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

		require("telescope").load_extension("harpoon")

		map("n", "<leader>,", function()
			require("telescope").extensions.harpoon.marks()
		end, { desc = "Open harpoon buffers list" })

		map("n", "<A-1>", function()
			harpoon:list():select(1)
		end, { desc = "Select 1 buffer in harpoon" })
		map("n", "<A-2>", function()
			harpoon:list():select(2)
		end, { desc = "Select 2 buffer in harpoon" })
		map("n", "<A-3>", function()
			harpoon:list():select(3)
		end, { desc = "Select 3 buffer in harpoon" })
		map("n", "<A-4>", function()
			harpoon:list():select(4)
		end, { desc = "Select 4 buffer in harpoon" })
		map("n", "<A-5>", function()
			harpoon:list():select(5)
		end, { desc = "Select 5 buffer in harpoon" })

		map("n", "<A-[>", function()
			harpoon:list():prev()
		end, { desc = "Select previous buffer in harpoon" })
		map("n", "<A-]>", function()
			harpoon:list():next()
		end, { desc = "Select next buffer in harpoon" })

		map("n", "<A-b>", function()
			harpoon:list():add()
		end, { desc = "Add buffer to harpoon" })
	end,
}
