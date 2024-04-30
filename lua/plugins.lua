local plugins = {
	{
		"gbprod/nord.nvim",
		lazy = false,
		priority = 1000,
		opts = function()
			return require("configs.nord")
		end,
		config = function(_, opts)
			require("nord").setup(opts)
			vim.cmd.colorscheme("nord")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			return require("configs.lualine")
		end,
	},

	{
		"goolord/alpha-nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			return require("alpha.themes.theta").config
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		config = function()
			require("configs.lspconfig")
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = function()
			return require("configs.mason")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			return require("configs.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		opts = function()
			return require("configs.gitsigns")
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		event = "BufEnter",
		opts = { user_default_options = { names = false } },
		config = function(_, opts)
			require("colorizer").setup(opts)

			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)
		end,
	},

	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("project_nvim").setup({
				patterns = {
					".git",
					"_darcs",
					".hg",
					".bzr",
					".svn",
					"Makefile",
					"package.json",
					"Tectonic.toml",
					">Projects",
					">Latex",
					"!>home",
				},
				scope_chdir = "tab",
				silent_chdir = false,
				exclude_dirs = { "~/.cargo/*" },
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = "Telescope",
		opts = function()
			return require("configs.telescope")
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)

			for _, ext in ipairs(opts.extensions_list) do
				telescope.load_extension(ext)
			end
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)
					require("configs.luasnip")
				end,
			},

			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)

					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},

			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"onsails/lspkind.nvim",
			},
		},
		opts = function()
			return require("configs.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},

	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			require("harpoon"):setup()
		end,
	},

	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			require("configs.conform")
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			{
				"theHamsta/nvim-dap-virtual-text",
				config = function()
					require("nvim-dap-virtual-text").setup()
				end,
			},
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("trouble").setup()
		end,
	},

	{
		"folke/todo-comments.nvim",
		event = "BufEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	{
		"NeogitOrg/neogit",
		keys = {
			{
				"<leader>gg",
				function()
					require("neogit").open()
				end,
				desc = "Open git overview",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			graph_style = "unicode",
			kind = "replace",
		},
	},

	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		config = function(_, opts)
			require("which-key").setup(opts)
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufEnter",
		opts = {
			indent = {
				char = "│",
			},
			scope = {
				char = "│",
			},
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"toggleterm",
					"NeogitStatus",
				},
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},

	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "BufEnter",
		init = function()
			vim.g.rainbow_delimiters = {
				highlight = {
					"RainbowDelimiterCyan",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterRed",
				},
			}
		end,
	},

	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n", desc = "Comment toggle current block" },
			{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
		},
		opts = {
			padding = true,
		},
	},

	{
		"pest-parser/pest.vim",
		ft = { "pest" },
	},

	{
		"j-hui/fidget.nvim",
		event = "VeryLazy",
		opts = {
			progress = {
				suppress_on_insert = true,
			},
			notification = {
				override_vim_notify = true,
				window = {
					normal_hl = "Normal",
				},
			},
		},
	},

	{
		"stevearc/dressing.nvim",
		event = "UIEnter",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = function()
			return require("configs.dressing")
		end,
	},

	{
		"smjonas/inc-rename.nvim",
		event = "LspAttach",
		dependencies = {
			"stevearc/dressing.nvim",
		},
		opts = {
			input_buffer_type = "dressing",
		},
		config = function(_, opts)
			require("inc_rename").setup(opts)
		end,
	},

	{
		"stevearc/oil.nvim",
		keys = {
			{
				"-",
				function()
					require("oil").toggle_float()
				end,
				mode = "n",
				desc = "Open parent directory",
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			default_file_explorer = true,
			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},
			view_options = {
				show_hidden = false,
			},
			float = {
				padding = 2,
				max_width = 0,
				max_height = 0,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<esc>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
		},
	},

	{
		"akinsho/toggleterm.nvim",
		keys = { { "<A-i>", "<cmd>ToggleTerm<CR>", desc = "Toggle floating terminal" } },
		cmd = "ToggleTerm",
		version = "*",
		opts = {
			autochdir = true,
			direction = "float",
			auto_scroll = true,
			start_in_insert = true,
		},
	},

	{
		"nvim-neotest/neotest",
		dependencies = {
			{
				"nvim-neotest/neotest-go",
				"rouge8/neotest-rust",
			},

			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-go")({
						recursive_run = true,
					}),
					require("neotest-rust"),
				},
			})
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = "LspAttach",
		opts = {
			linters_by_ft = {
				go = { "golangcilint" },
			},
		},
		config = function(_, opts)
			local lint = require("lint")

			lint.linters_by_ft = opts.linters_by_ft
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	{
		"LunarVim/breadcrumbs.nvim",
		event = "VeryLazy",
		dependencies = {
			{
				"SmiteshP/nvim-navic",
				opts = {
					lsp = {
						auto_attach = true,
					},
				},
			},
		},
		config = function()
			require("breadcrumbs").setup()
		end,
	},
}

return plugins
