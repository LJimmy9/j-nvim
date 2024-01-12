return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {},

  config = function()
    require('toggleterm').setup({
      shading_factor = '3', -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
    })
  end
}
