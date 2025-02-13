local options = {
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"go",
		"typst",
		"regex",
		"markdown",
		"markdown_inline",
		"rust",
	},

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = { enable = true },
}

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup(options)
	end,
}
