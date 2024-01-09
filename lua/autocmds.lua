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
