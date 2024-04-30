require("options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.loader.enable()

local lazy_config = require("configs.lazy")
require("lazy").setup({
	{ import = "plugins" },
}, lazy_config)

require("autocmds")

vim.schedule(function()
	require("mappings")
end)
