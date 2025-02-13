return {
	"coffebar/neovim-project",
	lazy = false,
	priority = 100,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
		{ "Shatur/neovim-session-manager" },
	},
	init = function()
		vim.opt.sessionoptions:append("globals")
	end,
	opts = {
		projects = {
			"~/Projects/*",
			"~/.config/*",
			"~/Documents/latex/*",
			"~/Documents/typst/*",
		},
		picker = {
			type = "telescope",
		},
		dashboard_mode = true,
	},
}
