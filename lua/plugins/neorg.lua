-- lazy.nvim spec
local M = {
  "nvim-neorg/neorg",
  ft = "norg",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-cmp",
    "nvim-lua/plenary.nvim",
  },
  build = ":Neorg sync-parsers",
  cmd = "Neorg",
}
local modules = {
  ["core.defaults"] = {},
  ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
  ["core.integrations.nvim-cmp"] = {},
  ["core.concealer"] = { config = { icon_preset = "diamond" } },
  ["core.keybinds"] = {
    -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
    config = {
      default_keybinds = true,
      neorg_leader = "<Leader><Leader>",
      hook = function(keybinds)
        -- keybinds.remap_key("norg", "i", "<M-CR>", "<Leader><CR>")
        keybinds.remap_event("norg", { "n", "i" }, "<Leader><CR>", "core.itero.next-iteration")
      end,
    },
  },
  ["core.dirman"] = {
    config = {
      workspaces = {
        notes = "~/neorg/notes",
        daily = "~/neorg/daily",
      },
    },
  },
}
M.opts = {
  load = modules,
}
return M
