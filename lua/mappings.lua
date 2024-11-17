local map = vim.keymap.set

local builtin = require("telescope.builtin")
local harpoon = require("harpoon")

map("n", "<leader>pp", function()
  vim.cmd("Telescope neovim-project")
end, { desc = "Find recent projects" })

map("n", "<leader>bb", builtin.buffers, { desc = "Find Buffer" })

map("n", "<leader><leader>", builtin.git_files, { desc = "Find files in project" })

map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Search for a string in current directory" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Find Recent Files" })

map("n", "<leader>hm", builtin.man_pages, { desc = "Find man page" })
map("n", "<leader>ht", builtin.help_tags, { desc = "Find nvim help page" })

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

map("t", "<A-i>", "<C-\\><C-n><cmd>ToggleTerm<CR>", { desc = "Toggle floating terminal" })

map("n", "-", function()
  require("oil").toggle_float()
end, { desc = "Open parent directory" })
