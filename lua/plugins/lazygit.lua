return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("telescope").load_extension("lazygit")
    Keymap("n", "<leader>gg", function()
      vim.cmd(":LazyGitCurrentFile")
    end)
  end,
}
