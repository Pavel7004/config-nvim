local map = vim.keymap.set

local servers = {
	"html",
	"cssls",
	"clangd",
	"gopls",
	"r_language_server",
	"rust_analyzer",
	"pest_ls",
	"denols",
	"marksman",
	"tinymist",
}

local on_attach = function(client, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = desc }
	end
	local builtin = require("telescope.builtin")

	map("n", "<leader>xa", require("neogen").generate, opts("Generate code annotations"))

	map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", opts("Diagnostics (Trouble)"))
	map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts("Buffer Diagnostics (Trouble)"))
	map("n", "<leader>co", "<cmd>Trouble symbols toggle focus=false<cr>", opts("Symbols (Trouble)"))
	map(
		"n",
		"<leader>cl",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		opts("LSP Definitions / references / ... (Trouble)")
	)
	map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", opts("Location List (Trouble)"))
	map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", opts("Quickfix List (Trouble)"))

	map("n", "gD", vim.lsp.buf.declaration, opts("Lsp Go to declaration"))
	map("n", "gd", builtin.lsp_definitions, opts("Lsp Go to definition"))
	map("n", "gi", builtin.lsp_implementations, opts("Lsp Go to implementation"))
	map("n", "gr", builtin.lsp_references, opts("Lsp Show references"))

	map("n", "<leader>cf", require("conform").format, opts("Format Current Buffer"))

	map("n", "<leader>cr", vim.lsp.buf.rename, opts("Rename Variable at cursor"))
	map("n", "<leader>cs", vim.lsp.buf.signature_help, opts("Lsp Show signature help"))
	map("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder, opts("Lsp Add workspace folder"))
	map("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder, opts("Lsp Remove workspace folder"))
	map("n", "<leader>cq", vim.diagnostic.setqflist, opts("lsp diagnostic quickfix"))

	map("n", "<leader>cww", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("Lsp List workspace folders"))
	map("n", "<leader>cD", vim.lsp.buf.type_definition, opts("Lsp Go to type definition"))

	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Lsp Code action"))

	if client.supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

local on_config = function()
	local capabilities = require("blink.cmp").get_lsp_capabilities()
	local lspconfig = require("lspconfig")

	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end

	lspconfig.texlab.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			texlab = {
				build = {
					executable = "tectonic",
					args = {
						"-X",
						"compile",
						"%f",
						"--synctex",
					},
					onSave = true,
					forwardSearchAfter = false,
				},
				chktex = {
					onOpenAndSave = true,
					onEdit = true,
				},
				experimental = {
					verbatimEnvironments = {
						"lstlisting",
					},
				},
			},
		},
	})

	lspconfig.lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,

		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
			},
		},
	})

	lspconfig.pylsp.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			"saghen/blink.cmp",
		},
		init = function()
			vim.g.markdown_fenced_languages = {
				"ts=typescript",
			}
		end,
		config = on_config,
	},

	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-web-devicons",
		},
		cmd = "Trouble",
		opts = {},
	},

	{
		"danymat/neogen",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
		},
		opts = {
			enabled = true,
			input_after_comment = true,
			snippet_engine = "luasnip",
		},
	},
}
