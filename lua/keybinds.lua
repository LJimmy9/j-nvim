print("keybinds loaded")
-- GENERAL
-- Keymap("n", "H", "Hzz")
-- Keymap("n", "L", "Lzz")
Keymap({ "n", "v" }, "H", "_")
Keymap({ "n", "v" }, "L", "$")
Keymap("n", "<leader>so", function()
  RunCommands({ "w", "so" })
end)

-- Keymap("n", "<leader>er", ":NvimTreeToggle<CR>")
Keymap("n", "<leader>er", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0))
end)

Keymap({ "n", "v" }, "<leader>nh", ":nohl<CR>")
Keymap("n", "<leader>lr", ":LspRestart<CR>")
Keymap("n", "<leader>qq", ":q<CR>")
Keymap("n", "<leader>vs", ":vs<CR>")
-- Keymap("n", "<leader>vv", ":tab split<CR>")
Keymap("n", "<leader>w", "<C-w>")

Keymap("v", "J", ":m '>1<CR>gv=gv")
Keymap("v", "K", ":m '<-2<CR>gv=gv")
Keymap({ "n", "v" }, "<leader>d", [["_d]])

Keymap("n", "g;", [[g;zz]])
Keymap("n", "g,", [[g,zz]])

Keymap("n", "<leader>gd", function()
  RunCommands({ ":normal *", ":nohl" })
  RunCommands({ ":normal zz" })
end)

Keymap("n", "<leader>ss", function()
  -- vim.lsp.buf.format()
  if vim.lsp.buf.server_ready() then
    vim.lsp.buf.format()
  end
  RunCommands({ "w" })
end)

-- GENERAL

-- Keymap({ "n", "v" }, "y", [[ygv<Esc>]])

-- Open command list
Keymap("n", "<leader>cl", ":<C-f>")
Keymap("i", "<C-l>", "<Right>")
Keymap("i", "<C-h>", "<Left>")

Keymap("n", "<C-o>", "<C-o>zz")

Keymap("n", "<C-i>", "<C-o>zz")
Keymap("n", "n", "nzz")
Keymap("n", "N", "Nzz")
Keymap("n", "}", "}zz")
Keymap("n", "{", "{zz")

Keymap("v", "<leader>cw", ":s///g<Left><Left><Left>")

Keymap("n", "<leader>cd", ":cd %:p:h <CR>")
-- Open command list

-- LSP
Keymap("n", "gh", vim.diagnostic.open_float)
Keymap("n", "K", vim.lsp.buf.hover)
Keymap("n", "gd", vim.lsp.buf.definition)
Keymap("n", "<leader>ca", vim.lsp.buf.code_action)
Keymap("n", "<leader>rn", vim.lsp.buf.rename)
Keymap("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>")
-- LSP

-- TELESCOPE
local builtin = require("telescope.builtin")
local utils = require("telescope.utils")
vim.keymap.set("n", "<leader>fj", function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    previewer = false,
  }))
end)
vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files()
end)
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fs", function()
  builtin.live_grep()
end)

vim.keymap.set("n", "<leader>ft", function()
  RunCommands({ "TodoTelescope" })
end)
-- TELESCOPE

-- TOGGLE TERM
Keymap("t", "<esc>", [[<C-\><C-n>]])
Keymap("n", "<leader>1", ":ToggleTerm1<CR>")
Keymap("n", "<leader>2", ":ToggleTerm2<CR>")
Keymap("n", "<leader>tt", ":ToggleTermToggleAll")
-- TOGGLE TERM

--  TODO
Keymap("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
Keymap("n", "<leader>ft", function()
  RunCommands({ "TodoTelescope" })
end)

Keymap("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
--  TODO

-- LUASNIP
Keymap({ "n", "v" }, "<leader>ls", require("luasnip.loaders").edit_snippet_files)
-- Keymap({ "n", "v" }, "<leader>ls", "<cmd>source ~/.config/nvim/lua/plugins/luasnip.lua<CR>")
-- LUASNIP

-- DAP
Keymap("n", "<leader>br", function()
  local dap = require("dap")
  dap.set_breakpoint()
end)
-- DAP

-- Neorg
-- Keymap("n", "<leader>od", ":Neorg workspace default <CR>")
Keymap("n", "<leader>on", ":Neorg workspace notes")
Keymap("n", "<leader>od", ":Neorg workspace daily")

-- Neorg
Keymap("n", "<Esc>[17;5u", "<Nop>", { noremap = true, silent = true })

function _G.send_line_to_terminal()
  -- Send the line to a ToggleTerm terminal
  -- Adjust the terminal ID (here 1) if needed
  local line = vim.fn.getline(".")
  line = line:gsub("//", "")
  line = line:gsub("#", "")
  -- line = line:gsub("-", "")

  -- Base64 encode the line
  local encoded = vim.fn.system("echo -n " .. line .. " | base64")

  -- Trim the newline character that system() adds
  encoded = encoded:gsub("\n", "")

  -- Use base64 decoding in the shell command
  local cmd = 'TermExec cmd="echo ' .. encoded .. ' | base64 --decode | bash"'

  vim.cmd(cmd)
end

vim.api.nvim_create_user_command("SendLineToTerminal", send_line_to_terminal, {})

Keymap("n", "<leader>sl", ":SendLineToTerminal<CR>", { noremap = true, silent = true })

-- local function run_and_redir()
--   vim.cmd("redir @a")
--   vim.cmd("RustRun")
--   vim.cmd("redir END")

-- local bufnr = vim.api.nvim_create_buf(false, true)
-- vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.split(vim.fn.getreg('a'), '\n'))
--
-- local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
-- for i, line in ipairs(lines) do
--   if i == 0 then
--   else
--     lines[i] = "// " .. line
--   end
-- end
-- vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
-- vim.fn.setreg('a', vim.fn.join(lines, "\n"))
-- vim.api.nvim_buf_delete(bufnr, { force = true })
-- end

Keymap("n", "<leader>rr", [[:RustRun<CR>]], { noremap = true, silent = true })
Keymap("n", "<leader>ap", [["ap]], { noremap = true, silent = true })
Keymap("n", "<leader>ap", [["ap]], { noremap = true, silent = true })
Keymap("n", "<leader>ap", [["ap]], { noremap = true, silent = true })
