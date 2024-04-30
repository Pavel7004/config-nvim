local map = vim.keymap.set

local on_attach = function(_, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = desc }
	end

	local builtin = require("telescope.builtin")

	map("n", "gD", vim.lsp.buf.declaration, opts("Lsp Go to declaration"))
	map("n", "gd", builtin.lsp_definitions, opts("Lsp Go to definition"))
	map("n", "gi", builtin.lsp_implementations, opts("Lsp Go to implementation"))
	map("n", "gr", builtin.lsp_references, opts("Lsp Show references"))

	map("n", "<leader>cf", require("conform").format, opts("Format Current Buffer"))
	map("n", "<leader>ct", require("trouble").toggle, opts("Toggle Diagnostic Buffer"))
	map("n", "<leader>ck", vim.lsp.buf.hover, opts("Display Lsp doc"))

	map("n", "<leader>cr", function()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end, { expr = true, buffer = bufnr, desc = "Rename Variable at cursor" })

	map("n", "<leader>cs", vim.lsp.buf.signature_help, opts("Lsp Show signature help"))
	map("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder, opts("Lsp Add workspace folder"))
	map("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder, opts("Lsp Remove workspace folder"))

	map("n", "<leader>cww", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("Lsp List workspace folders"))
	map("n", "<leader>cD", vim.lsp.buf.type_definition, opts("Lsp Go to type definition"))

	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Lsp Code action"))
end

local on_init = function(_, _) end

local base_capabilities = vim.lsp.protocol.make_client_capabilities()
base_capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}
local capabilities_cmp = require("cmp_nvim_lsp").default_capabilities()

local capabilities = vim.tbl_deep_extend("keep", base_capabilities, capabilities_cmp)

local lspconfig = require("lspconfig")

local servers = {
	"html",
	"cssls",
	"tsserver",
	"clangd",
	"gopls",
	"r_language_server",
	"rust_analyzer",
	"pylsp",
	"pest_ls",
}

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
					"--keep-logs",
					"--keep-intermediates",
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
	on_init = on_init,

	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
					[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})
