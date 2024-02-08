return {
  "echasnovski/mini.files",
  version = "*",
  opts = {
    mappings = {
      close = "q",
      go_in = "l",
      go_in_plus = "<CR>",
      go_out = "h",
      go_out_plus = "<BS>",
      reset = "",
      reveal_cwd = "@",
      show_help = "g?",
      synchronize = "<leader>ss",
      trim_left = "<",
      trim_right = ">",
    },
    options = {
      -- Whether to delete permanently or move into module-specific trash
      permanent_delete = true,
      -- Whether to use for editing directories
      use_as_default_explorer = false,
    },
  },
}
