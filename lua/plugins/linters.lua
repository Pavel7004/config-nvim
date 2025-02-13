local linters_by_ft = {
	go = { "golangcilint", "typos" },
	lua = { "typos" },
	rust = { "clippy", "typos" },
	js = { "eslint", "typos" },
	html = { "typos" },
	css = { "typos" },
}

return {
	"mfussenegger/nvim-lint",
	event = "BufWritePost",
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = linters_by_ft

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = vim.api.nvim_create_augroup("lints", { clear = true }),
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
