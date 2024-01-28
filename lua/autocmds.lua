vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.opt_local.filetype = "terraform"
  end,
})

vim.api.nvim_create_user_command("OnSaveCommand", function(opts)
  -- Find the first space in the string
  local space_index = string.find(opts.args, " ")

  -- Split the string into two parts based on the first space
  local cmd, file_type

  if space_index then
    file_type = string.sub(opts.args, 1, space_index - 1)
    cmd = string.sub(opts.args, space_index + 1)
  else
    print("Error: OnSaveCommand requires two arguments.")
    return
  end

  print("checking one ", cmd)
  print("checking two ", file_type)

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*." .. file_type,
    callback = function()
      vim.cmd(cmd)
      print("autocmd done")
    end,
  })
  print("done adding ", cmd, file_type)
end, { nargs = "*" })



vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end
})


vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'return cursor to where it was last time closing the file',
  pattern = '*',
  command = 'silent! normal! g`"zv',
})
