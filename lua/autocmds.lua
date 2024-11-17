local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

autocmd("FileType", {
  group = vim.api.nvim_create_augroup("tests", { clear = true }),
  pattern = { "rust", "go" },
  callback = function(args)
    local opts = function(desc)
      return { buffer = args.buf, desc = desc }
    end

    vim.keymap.set("n", "<leader>tt", function()
      require("neotest").run.run()
    end, opts("Run nearest test"))
    vim.keymap.set("n", "<leader>tf", function()
      require("neotest").run.run(vim.fn.expand("%"))
    end, opts("Run all tests in file"))
    vim.keymap.set("n", "<leader>ta", function()
      require("neotest").run.run(vim.fn.getcwd())
    end, opts("Run all tests in project"))
    vim.keymap.set("n", "<leader>ts", function()
      require("neotest").summary.toggle()
    end, opts("Toggle tests summary"))
    vim.keymap.set("n", "<leader>to", function()
      require("neotest").output_panel.toggle()
    end, opts("Toggle tests output"))
    vim.keymap.set("n", "<leader>td", function()
      require("neotest").run.run({ suite = false, strategy = "dap" })
    end, opts("Debug nearest test"))
  end,
})

autocmd({ "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("lints", { clear = true }),
  callback = function()
    require("lint").try_lint()
  end,
})
