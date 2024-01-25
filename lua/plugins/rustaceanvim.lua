return {
  "mrcjkb/rustaceanvim",
  version = "^3",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    }
    -- {
    --   "lvimuser/lsp-inlayhints.nvim",
    --   opts = {}
    -- },
  },
  ft = { "rust" },
  config = function()
    vim.g.rustaceanvim = {
      -- inlay_hints = {
      --   highlight = "NonText",
      -- },
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },
      server = {
        -- on_attach = function(client, bufnr)
        --   local inlay = require("lsp-inlayhints")
        --   inlay.setup({
        --     tools = {
        --       inlay_hints = {
        --         auto = false
        --       }
        --     }
        --   })
        --   inlay.on_attach(client, bufnr)
        -- end
        settings = {
          ["rust-analyzer"] = {
            -- Other Settings ...
            procMacro = {
              ignored = {
                leptos_macro = {
                  -- optional: --
                  -- "component",
                  "server",
                },
              },
            },
          },
        }
      },
    }
  end
}
