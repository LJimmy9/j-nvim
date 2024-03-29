return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      -- local _ts = require("tree-setter")

      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        indent = { enable = true },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        autotag = { enable = true },
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "tsx",
          "html",
          "go",
          "cpp",
          "css",
          "markdown",
          "markdown_inline",
          "svelte",
          "rust",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
          "bash",
          "zig",
        },
        -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
        enable = true,
        context_commentstring = {
          enable_autocmd = false,
        },
        -- auto install above language parsers
        auto_install = true,
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<M-;>",
            node_incremental = "n",
            scope_incremental = ".",
            node_decremental = "p",
          },
        },

      })
      -- vim.treesitter.language.register('c', 'cpp')
    end,
  },
}
