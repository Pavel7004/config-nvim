local map = vim.keymap.set

local builtin = require("telescope.builtin")
local snacks = require("snacks")

map("n", "<leader>pp", function()
	vim.cmd("NeovimProjectHistory")
end, { desc = "Find recent projects" })
map("n", "<leader>pr", function()
	vim.cmd("NeovimProjectLoadRecent")
end, { desc = "Load recent project" })
map("n", "<leader>pd", function()
	vim.cmd("NeovimProjectDiscover")
end, { desc = "Discover projects in search path" })

map("n", "<leader>bb", builtin.buffers, { desc = "Find Buffer" })
map("n", "<leader>bl", function()
	if #vim.fn.expand("#") > 0 then
		vim.cmd.edit(vim.fn.expand("#"))
	end
end, { desc = "Switch to last buffer" })

map("n", "<leader><leader>", builtin.git_files, { desc = "Find files in project" })

map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Search for a string in current directory" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Find Recent Files" })

map("n", "<leader>hm", builtin.man_pages, { desc = "Find man page" })
map("n", "<leader>ht", builtin.help_tags, { desc = "Find nvim help page" })

map("n", "<leader>tt", snacks.terminal.toggle, { desc = "Toggle terminal", noremap = true, silent = true })
