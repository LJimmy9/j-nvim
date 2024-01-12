local keys = {
  func = "f",
  cl = "l",
  param = "p",
  block = "b",
  cm = "c",
}



return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment region" },
            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment region" },

            ["a" .. keys.param] = {
              query = "@parameter.outer",
              desc = "Select outer part of a parameter/field region",
            },

            ["i" .. keys.param] = {
              query = "@parameter.inner",
              desc = "Select inner part of a parameter/field region",
            },

            ["a" .. keys.cm] = {
              query = "@comment.outer",
              desc = "Select outer part of a comment region",
            },
            ["i" .. keys.cm] = {
              query = "@comment.inner",
              desc = "Select inner part of a comment region",
            },

            ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region" },
            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop region" },

            ["a" .. keys.block] = { query = "@block.outer", desc = "Select outer part of a block region" }, -- overrides default text object block of parenthesis to parenthesis
            ["i" .. keys.block] = { query = "@block.inner", desc = "Select inner part of a block region" }, -- overrides default text object block of parenthesis to parenthesis

            ["a" .. keys.func] = {
              query = "@function.outer",
              desc = "Select outer part of a function region",
            },
            ["i" .. keys.func] = {
              query = "@function.inner",
              desc = "Select inner part of a function region",
            },

            ["a" .. keys.cl] = { query = "@class.outer", desc = "Select outer part of a class region" },
            ["i" .. keys.cl] = { query = "@class.inner", desc = "Select inner part of a class region" },
          },
          include_surrounding_whitespace = true,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>m" .. keys.param] = "@parameter.inner", -- swap object under cursor with next
            ["<leader>m" .. keys.func] = "@function.outer",   -- swap object under cursor with next
            ["<leader>m" .. keys.cm] = "@comment.outer",      -- swap object under cursor with next
          },
          swap_previous = {
            ["<leader>m" .. string.upper(keys.param)] = "@parameter.inner", -- swap object under cursor with previous
            ["<leader>m" .. string.upper(keys.func)] = "@function.outer",   -- swap object under cursor with next
            ["<leader>m" .. string.upper(keys.cm)] = "@comment.outer",      -- swap object under cursor with next
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["[" .. keys.func] = "@function.outer",
            ["[" .. keys.param] = "@parameter.inner",
            ["[" .. keys.cm] = "@comment.outer",
            ["[" .. keys.block] = "@block.outer",
            ["[" .. keys.cl] = { query = "@class.outer", desc = "Next class start" },
          },
          goto_next_end = {
            ["]" .. keys.func] = "@function.outer",
            ["]" .. keys.param] = "@parameter.inner",
            ["]" .. keys.cm] = "@comment.outer",
            ["]" .. keys.block] = "@block.outer",
            ["]" .. keys.cl] = { query = "@class.outer", desc = "Next class start" },
          },
        },
      },
    })
  end,
}
