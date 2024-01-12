return {

  "mrcjkb/rustaceanvim",
  version = "^3",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    {
      "lvimuser/lsp-inlayhints.nvim",
      opts = {}
    },
  },
  ft = { "rust" },
  config = function()
    vim.g.rustaceanvim = {
      inlay_hints = {
        highlight = "NonText",
      },
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },
      server = {
        on_attach = function(client, bufnr)
          local inlay = require("lsp-inlayhints")
          inlay.setup({
            tools = {
              inlay_hints = {
                auto = false
              }
            }
          })
          inlay.on_attach(client, bufnr)
        end
      }
    }
  end
}
