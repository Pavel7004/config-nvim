local map = vim.keymap.set

local on_attach = function(client, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = desc }
	end

	local builtin = require("telescope.builtin")

	map("n", "gD", vim.lsp.buf.declaration, opts("Lsp Go to declaration"))
	map("n", "gd", builtin.lsp_definitions, opts("Lsp Go to definition"))
	map("n", "gi", builtin.lsp_implementations, opts("Lsp Go to implementation"))
	map("n", "gr", builtin.lsp_references, opts("Lsp Show references"))

	map("n", "<leader>cf", require("conform").format, opts("Format Current Buffer"))
	map("n", "<leader>co", require("aerial").toggle, opts("Open code outline"))

	map("n", "<leader>cr", vim.lsp.buf.rename, opts("Rename Variable at cursor"))
	map("n", "<leader>cs", vim.lsp.buf.signature_help, opts("Lsp Show signature help"))
	map("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder, opts("Lsp Add workspace folder"))
	map("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder, opts("Lsp Remove workspace folder"))

	map("n", "<leader>cww", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("Lsp List workspace folders"))
	map("n", "<leader>cD", vim.lsp.buf.type_definition, opts("Lsp Go to type definition"))

	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Lsp Code action"))

	if client.supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

local base_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities_cmp = require("cmp_nvim_lsp").default_capabilities()

local capabilities = vim.tbl_deep_extend("force", base_capabilities, capabilities_cmp)

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
	"marksman",
	"solargraph",
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
