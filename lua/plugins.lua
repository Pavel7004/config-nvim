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
		"goolord/alpha-nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			return require("alpha.themes.theta").config
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			return require("configs.lualine")
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
		dependencies = { "nvim-web-devicons" },
		keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		opts = {
			preset = "modern",
			plugins = {
				marks = true,
				registers = true,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
		},
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
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = function()
			return require("configs.dressing")
		end,
	},

	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			return require("configs.oil")
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		keys = { { "<A-i>", "<cmd>ToggleTerm<CR>I", desc = "Toggle floating terminal" } },
		cmd = "ToggleTerm",
		version = "*",
		opts = {
			autochdir = true,
			direction = "float",
			auto_scroll = true,
			start_in_insert = false,
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
		event = "BufWritePost",
		opts = {
			linters_by_ft = {
				go = { "golangcilint", "typos" },
				lua = { "typos" },
				rust = { "clippy", "typos" },
			},
		},
		config = function(_, opts)
			local lint = require("lint")

			lint.linters_by_ft = opts.linters_by_ft
		end,
	},

	{
		"stevearc/aerial.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			autojump = true,
			layout = {
				default_direction = "prefer_left",
			},
		},
	},
}

return plugins
