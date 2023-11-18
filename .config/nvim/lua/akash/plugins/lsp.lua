return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = {
      "markdown",
      "lua",
      "c",
      "cpp",
      "java",
      "python",
      "json",
      "xml",
      "bash",
      "sh",
      "toml",
      "zsh",
      "rust",
      "html",
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "python",
    },
    lazy = true,
    event = "BufReadPost",
    config = function()
      require("akash.lsp.attach")
      require("akash.lsp.lsp-conf")
      require("akash.lsp.diagnostic")
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    event = "BufReadPost",
    lazy = true,
    config = function()
      require("akash.lsp.clangd")
    end,
  },
  {
    "Ciel-MC/rust-tools.nvim",
    branch = "inline-inlay-hints",
    ft = { "rust" },
    lazy = true,
    event = "BufReadPost",
    config = function()
      require("akash.lsp.rust-tools")
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = true,
    lazy = true,
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    config = function()
      require("akash.lsp.nvim-conform")
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    enabled = true,
    config = function()
      require("akash.lsp.nvim-lint")
    end,
  },
}
